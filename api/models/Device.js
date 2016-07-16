/**
* Device.js
*
* @description :: TODO: You might write a short summary of how this model works and what it represents here.
* @docs        :: http://sailsjs.org/#!documentation/models
*/

module.exports = {

  attributes: {    
    mac: { type: 'string' },
    name: { type: 'string' },
    table: { type: 'integer' },
    connecting: { type: 'boolean' },
    socketId: {type: 'string'},
    status: {
      type: 'string',
      enum: ['enable', 'disable']
    },
    opening: {type: 'boolean'},
    deviceIps: {
      collection: 'DeviceIp',
      via: 'device'
    },
    sessionDevices: {
      collection: 'SessionDevice',
      via: 'device'
    },
  },
};

