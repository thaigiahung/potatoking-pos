/**
* Session.js
*
* @description :: TODO: You might write a short summary of how this model works and what it represents here.
* @docs        :: http://sailsjs.org/#!documentation/models
*/

module.exports = {

  attributes: {
    device: { model: 'Device' },
    table: { type: 'string' },
    status: {
      type: 'string',
      enum: ['open', 'close']
    },
    startTime: {type: 'datetime'},
    endTime: {type: 'datetime'}
  }
};

