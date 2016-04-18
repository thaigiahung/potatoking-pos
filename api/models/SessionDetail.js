/**
* SessionDetail.js
*
* @description :: TODO: You might write a short summary of how this model works and what it represents here.
* @docs        :: http://sailsjs.org/#!documentation/models
*/

module.exports = {

  attributes: {
    session: { model: 'Session' },
    dish: { model: 'Dish' },
    price: { type: 'integer' },
    size: { type: 'integer' },
    status: {
      type: 'string',
      enum: ['added', 'cancelled', 'ordered', 'removed', 'preparing', 'delivering', 'delivered']
    }
  }
};

