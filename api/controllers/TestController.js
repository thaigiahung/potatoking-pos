module.exports = {
  subscribeToFunRoom: function(req, res) {
    var roomName = req.params.roomName;
    sails.sockets.join(req.socket, roomName);
    res.json({
      message: 'Subscribed to a fun room called '+roomName+'!'
    }); 
  },

  broadcast: function(req, res) {
    var roomName = req.body.roomName;
    var message = req.body.message;
    console.log(roomName);
    console.log(message);
    sails.sockets.broadcast(roomName, 'chat', { msg: message });    
  },

  listSubscriber: function(req, res) {
    var roomName = req.params.roomName;
    var subscribers = sails.sockets.subscribers(roomName);
    res.json(subscribers);
  },
};