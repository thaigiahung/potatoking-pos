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
        Session.findOne({
          device: device.id,
          status: 'open'
        }).exec(function (err, session) {
          if(err || !session)
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
                SessionDevice.create({
                  device: device.id,
                  session: createdSession.id
                }).exec(function (err3, createdSessionDevice){
                  device.opening = true;
                  device.save(function(err, saved){});

                  //Broadcast to room tableId with the event name opened
                  sails.sockets.broadcast(
                    'table'+device.table, 
                    'opened', 
                    {
                      table: device.table,
                      sessionId: createdSession.id,
                      message: '[Bàn ' + device.table + '] Mở bàn thành công!'
                    }
                  );

                  //Broadcast to room device with the event name opened
                  sails.sockets.broadcast(
                    'device', 
                    'opened', 
                    {
                      table: device.table,
                      sessionId: createdSession.id,
                      message: '[Bàn ' + device.table + '] Mở bàn thành công!'}
                  );

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
                });                
              }
            });
          }
          else 
          {
            return res.json({
              status: 0,
              message: 'Bàn đang hoạt động!'
            });
          }
        });

        
      }
    });    
  },

  mergeAndOpenTable: function(req, res) {
    var arrSelectedTable = JSON.parse(req.body.arrSelectedTable);
    var selectedMergeTable = req.body.selectedMergeTable;
    var arrError = [];

    Session.findOne({
      table: selectedMergeTable,
      status: 'open',
    }).exec(function (err, session){
      if(session)
      {
        //Already created
        return res.json({
          status: 0,
          message: 'Bàn đã được mở từ trước!'
        });
      }
      else
      {
        //Update table Session
        Session.create({
          table: selectedMergeTable,
          status: 'open',
          startTime: new Date(),
          endTime: new Date()
        }).exec(function (err, createdSession){
          if(err || !createdSession)
          {
            return res.json({
              status: 0,
              message: 'Không thể mở bàn!'
            });
          }
          else
          {
            async.forEachOfSeries(arrSelectedTable, function (selectedTable, index, callback) {
              Device.findOne({
                id: selectedTable,
                connecting: true
              }).exec(function (err2, device) {            
                if(!err2 && device)
                {
                  SessionDevice.findOne({
                    device: device.id,
                    session: createdSession.id
                  }).exec(function (err3, sessionDevice) {
                    if(err3 || !sessionDevice)
                    {
                      SessionDevice.create({
                        device: device.id,
                        session: createdSession.id
                      }).exec(function (err3, createdSessionDevice){
                        device.opening = true;
                        device.save(function(err, saved){});

                        //Broadcast to current table's room to order it subscribes to new table
                        sails.sockets.broadcast(
                          'table'+device.table,
                          'merged', 
                          {
                            table: selectedMergeTable,
                            room: 'table'+selectedMergeTable,
                            sessionId: createdSession.id,
                            message: '[Bàn ' + selectedMergeTable + '] Mở bàn thành công!'
                          }
                        );

                        //Broadcast to room device with the event name opened
                        sails.sockets.broadcast(
                          'device', 
                          'opened', 
                          {
                            table: device.table,
                            sessionId: createdSession.id,
                            message: '[Bàn ' + device.table + '] Mở bàn thành công!'
                          }
                        );
                      });
                    }
                  });              
                }
                else
                {
                  arrError.push(device.table); 
                }
                callback();
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
          }
        });
      }
    });    
  },

  addItem: function(req, res) {
    var roomName = req.body.roomName;
    var data = req.body.data;
    var eventName = req.body.eventName;

    Dish.findOne({
      id: data.id,
      status: 'enable',
    }).exec(function (err, dish){
      if(err || !dish)
      {
        return res.json({
          status: 0,
          message: 'Không thể đặt món!'
        });
      }
      else
      {
        //Find Session
        Session.findOne({
          id: data.sessionId,
          status: 'open',
        }).exec(function (err, session){
          if(err || !session)
          {
            return res.json({
              status: 0,
              message: 'Không thể đặt món!'
            });
          }
          else
          {
            //Create Session Detail
            SessionDetail.create({
              session: session.id,
              dish: dish.id,
              price: dish.price,
              status: 'added'
            }).exec(function (err, createdSessionDetail){
              if(err || !createdSessionDetail)
              {
                return res.json({
                  status: 0,
                  message: 'Không thể đặt món!'
                });
              }
              else
              {
                data['sessionDetailId'] = createdSessionDetail.id;
                sails.sockets.broadcast(roomName, eventName, { msg: data });
                return res.json({
                  status: 1,
                  message: 'Thành công!'
                });
              }
            });
          }
        });
      }
    });
  },
};

