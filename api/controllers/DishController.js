/* global DeviceIp */
/**
 * DishController
 *
 * @description :: Server-side logic for managing Dishes
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {
  index: function(req, res) {
	var ip = req.ip;
	ip = ip.substring(ip.lastIndexOf(":") + 1, ip.length);
	
	DeviceIp.findOne({
	  ip: ip
	}).exec(function (err, deviceIp) {
	  if(err || !deviceIp)
	  {
		return res.view('404', {layout: false});
	  }
	  else
	  {
		if(deviceIp.type == 'guest')
		{
		  res.redirect('/menu');
		}
		else if(deviceIp.type == 'cashier')
		{
		  res.redirect('/devices');
		}
		else if(deviceIp.type == 'chief-cook')
		{
		  res.redirect('/kitchen/overview');
		}
		else
		{
		  return res.view('404', {layout: false});
		}
	  }
	});
  },
  
  getDishByCategory: function(req, res) {
		this.authorizeRoles = ['guest', 'chief-cook', 'cashier'];
		this.req = req;
		this.res = res;
		this.deviceIp = DeviceIp;

		function callback(deviceIp) {
			Dish.find({
				category: req.query.id
			})
			.exec(function(err, foundDishes) {
				if(err) {
					return res.json({
						status: Enum.StatusCode.NotFoundObject,
						message:  Message.vn.DishNotExists
					}) 
				}
				
				return res.json({
					status: Enum.StatusCode.Success,
					dishes: foundDishes
				})
			});
		};

		return Authorize.apply(this, callback);
  },
  
  getDishes: function(req,res) {
		this.authorizeRoles = ['guest', 'chief-cook', 'cashier'];
		this.req = req;
		this.res = res;
		this.deviceIp = DeviceIp;

		function callback(deviceIp) {
			Dish.find({
				id: req.query.ids
			})
            .populate('otherPrices')
			.exec(function(err, foundDishes) {
				if(err) {
                    console.log(err);
					return res.json({
						status: Enum.StatusCode.NotFoundObject,
						message:  Message.vn.DishNotExists
					}) 
				}
                
				return res.json({
					status: Enum.StatusCode.Success,
					dishes: foundDishes
				})
			});
		};

		return Authorize.apply(this, callback);
  },
  
  getCategories: function(req, res) {
		this.authorizeRoles = ['guest', 'chief-cook', 'cashier'];
		this.req = req;
		this.res = res;
		this.deviceIp = DeviceIp;

		function callback(deviceIp) {
			data = req.body;
			
			Category.find({status: 'enable'})
				.then(function(categories) {
                    var foundDishes = Dish.find({status: 'enable'})
                    .populate('otherPrices')
                    .then(function(foundDishes) {
                        return foundDishes;
                    });
                    
                    return [categories, foundDishes];
				})
                .spread(function(categories, dishes) {
                    
                    categories = _.map(categories, function(cate) {
                        var tempCate = new Object();
                        
                        tempCate.parentCategory = cate.parentCategory
                        tempCate.name = cate.name
                        tempCate.description = cate.description
                        tempCate.status = cate.status
                        tempCate.nameEn = cate.nameEn
                        tempCate.id = cate.id
                        tempCate.image = cate.image
                        tempCate.dishes = [];        
                       
                       for(var i = 0 ; i < dishes.length ; i++ ){
                           if(dishes[i].category == cate.id) {
                                tempCate.dishes.push(dishes[i]);
                           }
                       }
                       
                       return tempCate;
                    });
                    
					return res.json({
                        status: Enum.StatusCode.Success,
                        categories: categories
					})
                })
				.catch(function(err) {
                    console.log(err);
                    
					return res.json({
						status: Enum.StatusCode.NotFoundObject,
						message: Message.vn.CategoryNotExists
					})
				})
		};

		return Authorize.apply(this, callback);
  },

  viewMenu: function(req, res) {
	var ip = req.ip;
	ip = ip.substring(ip.lastIndexOf(":") + 1, ip.length);
	
	DeviceIp.findOne({
	  ip: ip
	}).populate('device').exec(function (err, deviceIp) {
	  if(err || !deviceIp)
	  {
		return res.view('403', {layout: false});
	  }
	  else
	  {
		if(deviceIp.type == 'guest')
		{
		  device = deviceIp.device;

		  Dish.find({status: 'enable'}).exec(function (err, dishes) {
			if(err || !dishes)
			{
			  return res.view('dish', {layout: 'layout-user', status: 0, dishes: [], session: {}, added: [], deviceIp: deviceIp});
			}
			else {
				if (deviceIp.type == 'guest' || deviceIp.type == 'chief-cook') {
					var device = deviceIp.device;

					Dish.find().exec(function (err, dishes) {
						if (err || !dishes) {
							return res.view('dish', {layout: 'layout-user', status: 0, dishes: [], session: {}, added: [], deviceIp: deviceIp });
						}
						else {
							var query = "SELECT s.* FROM session s JOIN sessiondevice sd ON sd.session = s.id WHERE s.status = 'open' AND sd.device = " + device.id;
							Session.query(query, function (err, session) {
								if (err || !session || session.length == 0) {
									return res.view('dish', {layout: 'layout-user', status: 0, dishes: dishes, session: {}, added: [], deviceIp: deviceIp });
								}
								else {
									session = session[0];
									SessionDetail.find({
										where: {
											session: session.id
										},
										sort: 'id DESC'
									}).populate('dish').exec(function (err, added) {
										if (err) {
											return res.view('dish', {layout: 'layout-user', status: 0, dishes: dishes, session: session, added: [], deviceIp: deviceIp });
										}
										else {
											return res.view('dish', {layout: 'layout-user', status: 1, dishes: dishes, session: session, added: added, deviceIp: deviceIp });
										}
									});
								}
							});
						}
					});
				}
				else {
					return res.view('404', { layout: false });
				}
			}
		  });
		}
		else
		{
		  return res.view('403', {layout: false});
		}
	  }
	});
  },

	cashierMenu: function(req, res) {
	  var ip = req.ip;
	  ip = ip.substring(ip.lastIndexOf(":") + 1, ip.length);
	  
	  DeviceIp.findOne({
		ip: ip
	  }).populate('device').exec(function (err, deviceIp) {
		if(err || !deviceIp)
		{
		  return res.view('403', {layout: false});
		}
		else
		{
		  if(deviceIp.type == 'cashier')
		  {
			device = deviceIp.device;

			var potatoDishes = [];
			var potatoSauces = [];
			var potatoShakes = [];
			var friesDishes = [];
			var friesSauces = [];

			Category.find({
				'status' : 'enable',
				'parentCategory': null
			}).exec(function (err, categories) {
				if (err || !categories) {
					return res.view('cashier-dish', { status: 0, dishes: [], categories: [], deviceIp: deviceIp, friesSubCat1s: [], potatoDishes: potatoDishes, potatoSauces: potatoSauces, potatoShakes: potatoShakes, friesDishes: friesDishes, friesSauces: friesSauces });
				}
				else 
				{
					Category.find({
						'status' : 'enable',
						'parentCategory': 1
					}).exec(function (err2, friesSubCat1s) {
						if (err2 || !friesSubCat1s) {
							return res.view('cashier-dish', { status: 0, dishes: [], categories: categories, deviceIp: deviceIp, friesSubCat1s: [], potatoDishes: potatoDishes, potatoSauces: potatoSauces, potatoShakes: potatoShakes, friesDishes: friesDishes, friesSauces: friesSauces });
						}
						else 
						{
							Dish.find({'status' : 'enable'}).populate('category').populate('otherPrices').exec(function (err, dishes) {
								if (err || !dishes) {
									return res.view('cashier-dish', { status: 0, dishes: [], categories: categories, deviceIp: deviceIp, friesSubCat1s: friesSubCat1s, potatoDishes: potatoDishes, potatoSauces: potatoSauces, potatoShakes: potatoShakes, friesDishes: friesDishes, friesSauces: friesSauces });
								}
								else 
								{
									for(var i = 0; i < dishes.length; i++)
									{
										if(dishes[i].category.id == 4)
											potatoDishes.push(dishes[i]);
										else if(dishes[i].category.id == 5)
											potatoSauces.push(dishes[i]);
										else if(dishes[i].category.id == 6)
											potatoShakes.push(dishes[i]);
										else if(dishes[i].category.id == 7)
											friesDishes.push(dishes[i]);
										else if(dishes[i].category.id == 8)
											friesSauces.push(dishes[i]);
									}
									
									return res.view('cashier-dish', { status: 0, dishes: dishes, categories: categories, deviceIp: deviceIp, friesSubCat1s: friesSubCat1s, potatoDishes: potatoDishes, potatoSauces: potatoSauces, potatoShakes: potatoShakes, friesDishes: friesDishes, friesSauces: friesSauces });
								}
							});
						}
					});
				}
			});
		  }
		  else
		  {
			return res.view('403', {layout: false});
		  }
		}
	  });
	},

	kitchenDish: function (req, res) {
		var ip = req.ip;
		ip = ip.substring(ip.lastIndexOf(":") + 1, ip.length);

		DeviceIp.findOne({
			ip: ip
		}).populate('device').exec(function (err, deviceIp) {
			if (err || !deviceIp) {
				return res.view('404', { layout: false });
			}
			else {
				if (deviceIp.type == 'chief-cook') {
					device = deviceIp.device;

					Dish.find().exec(function (err, dishes) {
						if (err || !dishes || dishes.length == 0) {
							return res.view('kitchen-dish', { status: 0, datas: [], deviceIp: deviceIp });
						}
						else {
							return res.view('kitchen-dish', { status: 0, datas: dishes, deviceIp: deviceIp });
						}
					});
				}
				else {
					return res.view('404', { layout: false });
				}
			}
		});
	},

	hideDish: function (req, res) {
		var id = req.body.id;

		Dish.findOne({
			id: id
		}).exec(function (err, dish) {
			if (err || !dish) {
				return res.json({
					status: 0,
					message: 'Không thể ẩn món này!'
				});
			}
			else {
				dish.status = 'disable'
				dish.save(function (err1, saved) {
					if (err1 || !saved) {
						return res.json({
							status: 0,
							message: 'Không thể ẩn món này!'
						});
					}
					else {
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

	showDish: function (req, res) {
		var id = req.body.id;

		Dish.findOne({
			id: id
		}).exec(function (err, dish) {
			if (err || !dish) {
				return res.json({
					status: 0,
					message: 'Không thể hiện món này!'
				});
			}
			else {
				dish.status = 'enable'
				dish.save(function (err1, saved) {
					if (err1 || !saved) {
						return res.json({
							status: 0,
							message: 'Không thể hiện món này!'
						});
					}
					else {
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

	manage: function (req, res) {
		this.authorizeRoles = ['chief-cook'];
		this.req = req;
		this.res = res;
		this.deviceIp = DeviceIp;

		function callback(deviceIp) {
			Dish.find()
			.populate('images')
			.populate('category')
			.exec(function(err, found) {
				if(err) {
				  return Authorize.NotFound(res);
				}

				Category.find()
				.exec(function(err, categories) {
					if(err) {
						return Authorize.NotFound(res);
					}

					return res.view('dishManagement', { status: 0, 
						categories: categories,
						dishes: found, 
					  deviceIp: deviceIp });
					// });
				});
			});
		};

		return Authorize.apply(this, callback);
	},


	addDish: function(req, res) {
		this.authorizeRoles = ['chief-cook'];
		this.req = req;
		this.res = res;
		this.deviceIp = DeviceIp;

		function callback(deviceIp) {
			var data = req.body.dish;
			Category.findOne({id: data.category.id})
			.exec(function(err, foundCate) {
				if(err || foundCate.length == 0) {
					return res.json({
						status: Enum.StatusCode.NotFoundObject,
						message:  Message.vn.CategoryNotExists
					})
				}

				data.status = 'disable';

				Dish.create(data)
				.exec(function(err, created) {
					if(err || created.length == 0) {
						return res.json({
							status: Enum.StatusCode.CreatedFailed,
							message:  Message.vn.DishNotCreated
						})
					}
				});

				return res.json({
					status: Enum.StatusCode.Success
				})
			});
		}

		return Authorize.apply(this, callback);
	},

	editDish: function(req, res) {
		this.authorizeRoles = ['chief-cook'];
		this.req = req;
		this.res = res;
		this.deviceIp = DeviceIp;

		function callback(deviceIp) {
			var data = req.body;

			Category.findOne({id: data.category.id})
			.exec(function(err, foundCate) {
				if(err || foundCate.length == 0) {
					return res.json({
						status: Enum.StatusCode.NotFoundObject,
						message:  Message.vn.CategoryNotExists
					})
				}

				Dish
				.update({id: data.id},
				{
					name: data.name,
					price: data.price,
					description: data.description,
					category: foundCate
				})
				.exec(function(err, updatedDish) {
					if(err || updatedDish.length == 0) {
						return res.json({
							status: Enum.StatusCode.NotFoundObject,
							message:  Message.vn.DishNotExists
						})
					}

					return res.json({
						status: Enum.StatusCode.Success
					})
				});
			})

		}

		return Authorize.apply(this, callback);
	},

	enableDish: function(req, res) {
		this.authorizeRoles = ['chief-cook'];
		this.req = req;
		this.res = res;
		this.deviceIp = DeviceIp;

		function callback(deviceIp) {
			data = req.body;
			Dish.update({id: data.dishId}, {status: 'enable'})
			.exec(function(err, updatedDish) {
				if(err || updatedDish.length == 0) {
					return res.json({
						status: Enum.StatusCode.NotFoundObject,
						message:  Message.vn.DishNotExists
					})
				}

				return res.json({
					status: Enum.StatusCode.Success
				});
			});
		};

		return Authorize.apply(this, callback);
	},

	disableDish: function(req, res) {
		this.authorizeRoles = ['chief-cook'];
		this.req = req;
		this.res = res;
		this.deviceIp = DeviceIp;

		function callback(deviceIp) {
			data = req.body;
			Dish.update({id: data.dishId}, {status: 'disable'})
			.exec(function(err, updatedDish) {
				if(err || updatedDish.length == 0) {
					return res.json({
						status: Enum.StatusCode.NotFoundObject,
						message:  Message.vn.DishNotExists
					})
				}

				return res.json({
					status: Enum.StatusCode.Success
				});
			});
		};

		return Authorize.apply(this, callback);
	},

	deleteDish: function(req, res) {
		this.authorizeRoles = ['chief-cook'];
		this.req = req;
		this.res = res;
		this.deviceIp = DeviceIp;

		function callback(deviceIp) {
			var data = req.body;
			Dish.destroy({id: data.dishId})
			.exec(function(err, deletedDish) {
				if(err || deletedDish.length == 0) {
					return res.json({
						status: Enum.StatusCode.NotFoundObject,
						message:  Message.vn.DishNotExists
					});
				}

				return res.json({
					status: Enum.StatusCode.Success
				});
			});
		};

		return Authorize.apply(this, callback);
	},

	deleteImage: function(req, res) {
		this.authorizeRoles = ['chief-cook'];
		this.req = req;
		this.res = res;
		this.deviceIp = DeviceIp;

		function callback(deviceIp) {
			var data = req.body;
			DishImage.destroy({id: data.imageId})
			.exec(function(err, deletedImage) {
				if(err || deletedImage.length == 0) {
					return res.json({
						status: Enum.StatusCode.NotFoundObject,
						message:  Message.vn.ImageNotExists
					});
				}

				//TODO : Delete the actual file
				return res.json({
					status: Enum.StatusCode.Success
				});
			});
		};

		return Authorize.apply(this, callback);
	},

};
