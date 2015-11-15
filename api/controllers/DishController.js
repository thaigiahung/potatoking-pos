/**
 * DishController
 *
 * @description :: Server-side logic for managing Dishes
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {
	view: function(req, res) {
    DeviceIp.findOne({
      ip: req.ip
    }).populate('device').exec(function (err, device) {
      if(err || !device)
      {
        return res.view('404');
      }
      else
      {
        device = device.device;

        Dish.find({
          status: 'enable'
        }).exec(function (err, dishes) {
          if(err || !dishes)
          {
            return res.view('dish', {status: 0, dishes: [], added: []});
          }
          else
          {
            var query = "SELECT s.* FROM session s JOIN sessiondevice sd ON sd.session = s.id WHERE s.status = 'open' AND sd.device = " + device.id;
            Session.query(query, function(err, session) {
              if(err || !session || session.length == 0)
              {
                return res.view('dish', {status: 0, dishes: dishes, added: []});
              }
              else
              {
                session = session[0];
                SessionDetail.find({ 
                  where: { 
                    session: session.id 
                  },
                  sort: 'id DESC' 
                }).populate('dish').exec(function (err, added) {
                  if(err)
                  {
                    return res.view('dish', {status: 0, dishes: dishes, added: []});
                  }
                  else
                  {
                    return res.view('dish', {status: 1, dishes: dishes, added: added});
                  }
                });
              }
            });
          }
        });
      }
    });        
  },
};

