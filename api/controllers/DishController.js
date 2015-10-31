/**
 * DishController
 *
 * @description :: Server-side logic for managing Dishes
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {
	view: function(req, res) {
    Dish.find({
      status: 'enable'
    }).exec(function (err, dishes) {
      if(err || !dishes)
      {
        return res.view('dish', {status: 0, dishes: []});
      }
      else
      {
        return res.view('dish', {status: 1, dishes: dishes});
      }
    });    
  },
};

