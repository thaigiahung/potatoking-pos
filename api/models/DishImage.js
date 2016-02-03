/**
* DishImage.js
*
* @description :: TODO: You might write a short summary of how this model works and what it represents here.
* @docs        :: http://sailsjs.org/#!documentation/models
*/

module.exports = {

  attributes: {
    dish: { model: 'Dish' },
    url: { type: 'string' },
    status: {
      type: 'string',
      enum: ['enable', 'disable']
    }
  }
};