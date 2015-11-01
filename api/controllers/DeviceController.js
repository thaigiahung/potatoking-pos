/**
 * DeviceController
 *
 * @description :: Server-side logic for managing devices
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

var async = require('async');

module.exports = {
  listDevice: function(req, res) {
    Device.find({
      where: {
        status: 'enable'
      },
      sort: 'table asc'
    }).exec(function (err, devices) {
      if(err || !devices)
      {
        return res.view('device-list',{status: 0, data: [], session: {}});
      }
      else
      {
        /*var newArrDevices = [];
        async.forEachOfSeries(devices, function (device, index, callback) {
          Session.findOne({
            device: device.id,
            status: 'open'
          }).exec(function (err2, session) {
            var isOpened;
            if(err2 || !session)
            {
              isOpened = false;
              session = {};
            }
            else
            {
              isOpened = true;
              session = session;
            }
            device['isOpened'] = isOpened;
            device['session'] = session;
            newArrDevices.push(device);
            
            callback();
          }); 
        }, function done() {
          return res.view('device-list', {status: 1, data: newArrDevices});
        });*/
        // return res.json(devices);
        return res.view('device-list', {status: 1, data: devices});
      }
    });    
  },

  connect: function(req, res) {
    var ip = req.ip;
    var data;
    Device.findOne({
      ip: ip
    }).exec(function (err, device) {
      if(err || !device)
      {
        data = {
                  status: 0,
                  message: "Unauthorised device!",
                  ip: ip,
                  data: []
                };

        return res.send(data);
      }
      else
      {   
        Session.findOne({
          device: device.id,
          status: 'open'
        }).exec(function (err2, session) {
          var isOpened;
          if(err2 || !session)
          {
            isOpened = false;
            session = {};
          }
          else
          {
            isOpened = true;
            session = session;
          }
          device.isOpened = isOpened;
          device.session = session;

          device.connecting = true;
          device.socketId = sails.sockets.id(req.socket);
          device.save(function(err, saved){});
          
          data = {
                    status: 1,
                    message: "Success!",
                    ip: ip,
                    data: device
                  };

          sails.sockets.broadcast('device', 'newDeviceConnected', data);
          return res.send(data);
        });        
      }      
    });
  },
};

