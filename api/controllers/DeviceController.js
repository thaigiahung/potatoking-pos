/**
 * DeviceController
 *
 * @description :: Server-side logic for managing devices
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

var fs = require('fs');
var async = require('async');
var fullStatusFilePath = sails.config.local.fullStatusFilePath;
var fullTableFilePath = sails.config.local.fullTableFilePath;

module.exports = {
  subscribe: function(req, res) {
    var roomName = req.params.roomName;
    sails.sockets.join(req.socket, roomName);
    res.json({
      message: 'Subscribed to a fun room called '+roomName+'!'
    }); 
  },

  unsubscribe: function(req, res) {
    var roomName = req.params.roomName;
    sails.sockets.leave(req.socket, roomName);
    res.json({
      message: 'Left a fun room called '+roomName+'!'
    }); 
  },

  listDevice: function(req, res) {
    var ip = req.ip;
    ip = ip.substring(ip.lastIndexOf(":")+1, ip.length);

    DeviceIp.findOne({
      ip: ip
    }).exec(function (err, deviceIp) {
      if(err || !deviceIp)
      {
        return res.view('404', {layout: false});
      }
      else
      {
        if(deviceIp.type == 'cashier' || deviceIp.type == 'chief-cook')
        {
          Device.find({
            where: {
              status: 'enable'
            },
            sort: 'table asc'
          }).exec(function (err, devices) {
            var opened = [];
            if(err || !devices)
            {
              return res.view('device-list',{status: 0, data: [], opened: opened, deviceIp: deviceIp});
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

              Session.find({
                where: {
                  status: 'open'
                }
              }).exec(function (err, sessions) {
                if(err || !sessions)
                {
                  return res.view('device-list', {status: 1, data: devices, opened: opened, deviceIp: deviceIp});    
                }
                else
                {
                  async.forEachOfSeries(sessions, function (session, index, callback) {
                    SessionDevice.find({
                      where: {
                        session: session.id
                      },
                      sort: 'device'            
                    }).populate('device').exec(function (err2, sessionDevices) {
                      if(!err2 && sessionDevices && sessionDevices.length > 0)
                      {
                        var tables = [];
                        async.forEachOfSeries(sessionDevices, function (sessionDevice, index2, callback2) {                    
                          tables.push(sessionDevice.device.table);
                          callback2();
                        }, function done() {
                          var openedTable = {
                            session: session.id,
                            tables: tables.join()
                          }
                          opened.push(openedTable);
                          callback();
                        });
                      }
                      else
                      {
                        callback(err);
                      }  
                    });              
                  }, function done() {
                    return res.view('device-list', {status: 1, data: devices, opened: opened, deviceIp: deviceIp});
                  });
                }
              });
              
            }
          });
        }
        else
        {
          return res.view('404', {layout: false});
        }
      }
    });
  },

  connect: function(req, res) {
    var ip = req.ip;
    ip = ip.substring(ip.lastIndexOf(":")+1, ip.length);
    var data;
    DeviceIp.findOne({
      ip: ip
    }).populate('device').exec(function (err, device) {
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
        device = device.device;
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

  fastDelivery: function(req, res) {
    this.authorizeRoles = ['chief-cook'];
    this.req = req;
    this.res = res;
    this.deviceIp = DeviceIp;

    function callback(deviceIp) {
      Device.find({
        where: {
          status: 'enable',
          table: { '<': 30 }
        },
        sort: 'table asc'
      }).exec(function (err, devices) {
        var opened = [];
        if(err || !devices)
        {
          return res.view('fast-delivery',{status: 0, deviceIp: deviceIp, devices: []});
        }
        else
        {
          return res.view('fast-delivery', {status: 1, deviceIp: deviceIp, devices: devices});
        }
      });
    };

    return Authorize.apply(this, callback);
  },

  startFastDelivery: function(req, res) {
    this.authorizeRoles = ['chief-cook'];
    this.req = req;
    this.res = res;
    this.deviceIp = DeviceIp;

    function callback(deviceIp) {
      var trainId = 1;
      // var newStr = "2\n" + req.body.table + "\n";

      fs.readFile(fullStatusFilePath, 'utf8', function read(err, data) {               
        if(err || !data)
        {
          return res.json({
            status: 0,
            message: 'Không thể đọc file!'
          });
        }
        else
        {
          var arr = data.split("\n");
          if(arr[0] == 1) //Train is currently at station
          {
            fs.writeFile(fullStatusFilePath, 2, 'utf8', function (err) {
              if(err)
              {
                return res.json({
                  status: 0,
                  message: 'Không thể ghi file!'
                });
              }
              else
              {
                fs.writeFile(fullTableFilePath, req.body.table, 'utf8', function (err) {
                  if(err)
                  {
                    return res.json({
                      status: 0,
                      message: 'Không thể ghi file!'
                    });
                  }
                  else
                  {
                    return res.json({
                      status: 1,
                      message: 'Thành công!'
                    });
                  }
                });
              }
            });
          }
          else
          {
            return res.json({
              status: 0,
              message: 'Xe không sẵn sàng!'
            });
          }
        }
      });
    };

    return Authorize.apply(this, callback);
  },
};

