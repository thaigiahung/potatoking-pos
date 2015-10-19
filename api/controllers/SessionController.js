/**
 * SessionController
 *
 * @description :: Server-side logic for managing sessions
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

var async = require('async');

module.exports = {
	openTable: function(req, res) {
    Device.findOne({
      id: req.body.id
    }).exec(function (err, device) {      
      if(err || !device)
      {
        return res.json({
          status: 0,
          message: 'Thiết bị lạ'
        });
      }
      else if(!device.connecting)
      {        
        return res.json({
          status: 0,
          message: 'Thiết bị chưa kết nối vào mạng'
        });
      }
      else
      {
        //Update table Session
        Session.create({
          device: device.id,
          table: device.table,
          status: 'open',
          startTime: new Date(),
          endTime: new Date()
        }).exec(function (err2, createdSession){
          if(err2 || !createdSession)
          {
            return res.json({
              status: 0,
              message: 'Không thể mở bàn'
            });
          }
          else
          {
            //Broadcast to room tableId with the event name opened
            sails.sockets.broadcast('table'+device.table, 'opened', {message: '[Bàn ' + device.table + '] Mở bàn thành công!'});

            return res.json({
              status: 1,
              message: '[Bàn ' + device.table + '] Mở bàn thành công!'
            });

            //Broadcast to room
            /*sails.sockets.broadcast('table', 'table'+device.table, {message: "Thiết bị này đã được ghép vào bàn " + device.table});

            return res.json({
              status: 1,
              message: 'Thiết bị này đã được ghép vào bàn ' + device.table
            });*/
          }
        });
      }
    });    
  },

  mergeAndOpenTable: function(req, res) {
    var arrSelectedTable = JSON.parse(req.body.arrSelectedTable);
    var selectedMergeTable = req.body.selectedMergeTable;

    var arrError = [];
    async.forEachOfSeries(arrSelectedTable, function (selectedTable, index, callback) {
      Device.findOne({
        id: selectedTable,
        connecting: true
      }).exec(function (err, device) {
        if(device)
        {
          Session.findOne({
            device: device.id,
            status: 'open'
          }).exec(function (err2, session) {
            if(!session)
            {
              //Update table Session
              Session.create({
                device: device.id,
                table: selectedMergeTable,
                status: 'open',
                startTime: new Date(),
                endTime: new Date()
              }).exec(function (err2, createdSession){                
                //Broadcast to current table's room to order it subscribes to new table
                sails.sockets.broadcast('table'+device.table, 'merged', {
                                                                          table: selectedMergeTable,
                                                                          room: 'table'+selectedMergeTable,
                                                                          message: '[Bàn ' + selectedMergeTable + '] Mở bàn thành công!'});
              });
            }
            else
            {
              arrError.push(device.table);              
            }
            callback();
          });          
        }   
      });           
    }, function done() {
      if(arrError.length > 0)
      {
        return res.json({
          status: 0,
          message: 'Không thể ghép bàn ' + arrError.toString() + ' vào bàn ' + selectedMergeTable
        });
      }
      else
      {
        return res.json({
        status: 1,
        message: '[Bàn ' + selectedMergeTable + '] Mở bàn thành công!'
      });
      }
    });   
  },
};

