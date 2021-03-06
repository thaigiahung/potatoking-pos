/**
* Category.js
*
* @description :: TODO: You might write a short summary of how this model works and what it represents here.
* @docs        :: http://sailsjs.org/#!documentation/models
*/

module.exports = {

  attributes: {
    name: { type: 'string' },
    description: { type: 'text' },
    status: {
      type: 'string',
      enum: ['enable', 'disable']
    },
    dishes: {
      collection: 'Dish',
      via: 'category'
    },
    
    childCategories: {
        collection: 'Category',
        via: 'parentCategory'
    },
    
    parentCategory: {
        model: 'Category',
    },
    
    nameEn: { type: 'string' },
    image: {type: 'string'}
  }
};

