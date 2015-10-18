/**
 * DeviceController
 *
 * @description :: Server-side logic for managing devices
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {
  listDevice: function(req, res) {
    Device.find({
      status: 'enable',
      connecting: true
    }).exec(function (err, devices) {
      if(err || !devices)
      {
        return res.view('device-list',{status: 0, data: []});
      }
      else
      {
        return res.view('device-list', {status: 1, data: devices});
      }
    });    
  },

  connect: function(req, res) {
    console.log("Broadcast: " + req.ip);
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
      }
      else
      {
        device.connecting = true;
        device.save(function(err, saved){});
        
        data = {
                  status: 1,
                  message: "Success!",
                  ip: ip,
                  data: device
                };
      }
      sails.sockets.broadcast('device', 'newDeviceConnected', data);
      return res.send(data);
    });
  },
};

