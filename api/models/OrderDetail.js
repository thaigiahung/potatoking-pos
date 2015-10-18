/**
* OrderDetail.js
*
* @description :: TODO: You might write a short summary of how this model works and what it represents here.
* @docs        :: http://sailsjs.org/#!documentation/models
*/

module.exports = {

  attributes: {
    order: { model: 'Order' },
    dish: { model: 'Dish' },
    quantity: { type: 'integer' },
    price: { type: 'integer' },
    subTotal: { type: 'integer' },
    status: {
      type: 'string',
      enum: ['preparing', 'cancelled', 'delivering', 'delivered']
    }
  }
};

