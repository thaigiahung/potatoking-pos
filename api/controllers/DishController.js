/**
 * DishController
 *
 * @description :: Server-side logic for managing Dishes
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {
	view: function(req, res) {
    var ip = req.ip;
    ip = ip.substring(ip.lastIndexOf(":")+1, ip.length);
    
    DeviceIp.findOne({
      ip: ip
    }).populate('device').exec(function (err, deviceIp) {
      if(err || !deviceIp)
      {
        return res.view('404', {layout: false});
      }
      else
      {
        if(deviceIp.type == 'guest' || deviceIp.type == 'chief-cook')
        {
          device = deviceIp.device;

          Dish.find().exec(function (err, dishes) {
            if(err || !dishes)
            {
              return res.view('dish', {status: 0, dishes: [], session: {}, added: [], deviceIp: deviceIp});
            }
            else
            {
              var query = "SELECT s.* FROM session s JOIN sessiondevice sd ON sd.session = s.id WHERE s.status = 'open' AND sd.device = " + device.id;
              Session.query(query, function(err, session) {
                if(err || !session || session.length == 0)
                {
                  return res.view('dish', {status: 0, dishes: dishes, session: {}, added: [], deviceIp: deviceIp});
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
                      return res.view('dish', {status: 0, dishes: dishes, session: session, added: [], deviceIp: deviceIp});
                    }
                    else
                    {
                      return res.view('dish', {status: 1, dishes: dishes, session: session, added: added, deviceIp: deviceIp});
                    }
                  });
                }
              });
            }
          });
        }
        else
        {
          return res.view('404', {layout: false});
        }
      }
    });        
  },

  kitchenDish: function(req, res) {
    var ip = req.ip;
    ip = ip.substring(ip.lastIndexOf(":")+1, ip.length);
    
    DeviceIp.findOne({
      ip: ip
    }).populate('device').exec(function (err, deviceIp) {
      if(err || !deviceIp)
      {
        return res.view('404', {layout: false});
      }
      else
      {
        if(deviceIp.type == 'chief-cook')
        {
          device = deviceIp.device;

          Dish.find().exec(function (err, dishes) {
            if(err || !dishes || dishes.length == 0)
            {
              return res.view('kitchen-dish',{status: 0, datas: [], deviceIp: deviceIp});
            }
            else
            {
              return res.view('kitchen-dish',{status: 0, datas: dishes, deviceIp: deviceIp});
            }
          });
        }
        else
        {
          return res.view('404', {layout: false});
        }
      }
    });        
  },

  hideDish: function(req, res) {
    var id = req.body.id;
    
    Dish.findOne({
      id: id
    }).exec(function (err, dish) {
      if(err || !dish)
      {
        return res.json({
          status: 0,
          message: 'Không thể ẩn món này!'
        });
      }
      else
      {
        dish.status = 'disable'
        dish.save(function(err1, saved){
          if(err1 || !saved)
          {
            return res.json({
              status: 0,
              message: 'Không thể ẩn món này!'
            });
          }
          else
          {
            //Broadcast to room table to hide dish
            sails.sockets.broadcast(
              'table', 
              'hideDish', 
              {
                dishId: dish.id
              }
            );

            //Broadcast to device to hide dish
            sails.sockets.broadcast(
              'device', 
              'hideDish', 
              {
                dishId: dish.id,
                message: 'Ẩn'
              }
            );

            return res.json({
              status: 1,
              message: 'Thành công!'
            });
          }
        });        
      }
    });        
  },

  showDish: function(req, res) {
    var id = req.body.id;
    
    Dish.findOne({
      id: id
    }).exec(function (err, dish) {
      if(err || !dish)
      {
        return res.json({
          status: 0,
          message: 'Không thể hiện món này!'
        });
      }
      else
      {
        dish.status = 'enable'
        dish.save(function(err1, saved){
          if(err1 || !saved)
          {
            return res.json({
              status: 0,
              message: 'Không thể hiện món này!'
            });
          }
          else
          {
            //Broadcast to room table to show dish
            sails.sockets.broadcast(
              'table', 
              'showDish', 
              {
                dishId: dish.id
              }
            );

            //Broadcast to device to show dish
            sails.sockets.broadcast(
              'device', 
              'showDish', 
              {
                dishId: dish.id,
                message: 'Hiện'
              }
            );

            return res.json({
              status: 1,
              message: 'Thành công!'
            });
          }
        });        
      }
    });        
  },
};

