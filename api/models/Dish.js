/**
* Dish.js
*
* @description :: TODO: You might write a short summary of how this model works and what it represents here.
* @docs        :: http://sailsjs.org/#!documentation/models
*/

module.exports = {

  attributes: {
    category: { model: 'Category' },
    name: { type: 'string' },
    nameEn: { type: 'string' },
    description: { type: 'text' },
    price: { type: 'integer' },
    status: {
      type: 'string',
      enum: ['enable', 'disable']
    },
    images: {
      collection: 'DishImage',
      via: 'dish'
    },
    order: { type: 'integer' },
    mainImage: {
        type: 'string'
    },
    
    otherPrices: {
        collection: 'Price',
        via: 'dish'
    }
  }
};

