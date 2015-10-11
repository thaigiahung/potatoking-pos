/**
 * DeviceController
 *
 * @description :: Server-side logic for managing devices
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {
  listDevice: function(req, res) {
    return res.view('device-list');
  },

  connect: function(req, res) {
    console.log("Broadcast: " + req.ip);
    sails.sockets.broadcast('pos', 'newDeviceConnected', { ip: req.ip });
    return res.send(req.ip + " connected!");
  },
};

