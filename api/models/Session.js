/**
* Session.js
*
* @description :: TODO: You might write a short summary of how this model works and what it represents here.
* @docs        :: http://sailsjs.org/#!documentation/models
*/

module.exports = {

  attributes: {
    table: { type: 'string' },
    status: {
      type: 'string',
      enum: ['open', 'close']
    },
    total: { type: 'integer', defaultsTo: 0},
    paymentStatus: {
      type: 'string',
      enum: ['checkout', 'paid', 'cancelled']
    },
    startTime: {type: 'datetime'},
    endTime: {type: 'datetime'}
  }
};

