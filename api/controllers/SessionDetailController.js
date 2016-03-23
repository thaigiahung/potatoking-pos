/**
 * SessionDetailController
 *
 * @description :: Server-side logic for managing order_details
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

 var fs = require('fs');
 var async = require('async');

 module.exports = {
 	deliver: function(req, res) {
 		var sessionDetailId = req.body.sessionDetailId;
 		var trainId = req.body.trainId;
 		var fullFilePath = './assets/order.dat';

 		SessionDetail.findOne({
 			id: sessionDetailId,
 			status: 'ordered'
 		}).populate('session').populate('dish').exec(function (err, sessionDetail) {
 			if(err || !sessionDetail)
 			{
 				return res.json({
 					status: 0,
 					message: 'Không tìm thấy chi tiết đơn hàng!'
 				});
 			}
 			else
 			{
 				sessionDetail.session.total += sessionDetail.price;
 				sessionDetail.session.save(function(err2, savedSession){
 					if(err2 || !savedSession)
 					{
 						return res.json({
 							status: 0,
 							message: 'Không thể lưu đơn hàng!'
 						});
 					}
 					else
 					{
 						fs.readFile(fullFilePath, 'utf8', function read(err3, data) { 							
 							if(err3 || !data)
 							{
 								return res.json({
 									status: 0,
 									message: 'Không thể đọc file!'
 								});
 							}
 							else
 							{
 								var arr = data.split("\n");
 								if(arr[0] == 1) //Train is currently at station
 								{
 									var newStr = "2\n" + sessionDetail.session.table + "\n" + trainId;
 									fs.writeFile(fullFilePath, newStr, 'utf8', function (err4) {
 										if(err4)
 										{
 											return res.json({
 												status: 0,
 												message: 'Không thể ghi file!'
 											});
 										}
 										else
 										{
					 						sessionDetail.status = 'delivered';
					 						sessionDetail.save(function(err5, savedSessionDetail){
					 							if(err5 || !savedSessionDetail)
					 							{
					 								return res.json({
					 									status: 0,
					 									message: 'Không thể giao hàng!'
					 								});
					 							}
					 							else
					 							{
					 								sails.sockets.broadcast('device', 'removeKitchenOverview', { sessionDetailId: sessionDetailId });
					 								sails.sockets.broadcast('table'+sessionDetail.session.table, 'item-delivered', 
					 								{
					 									sessionDetailId: sessionDetailId, 
					 									dishName: sessionDetail.dish.name, 
					 									type: 1, //Đã giao
					 									message: 'Đã giao' 
													});

					 								return res.json({
					 									status: 1,
					 									message: 'Thành công!'
					 								});
					 							}
					 						});
 										}
 									});
 								}
 								else
 								{
 									return res.json({
 										status: 0,
 										message: 'Xe không sẵn sàng!'
 									});
 								}
 							}
 						});
 					}
 				});
 			}
 		});
	},

 	batchDeliver: function(req, res) {
 		var arrSessionDetailId = req.body.arrSessionDetailId;
 		var trainId = req.body.trainId;
 		var fullFilePath = './assets/order.dat';

 		fs.readFile(fullFilePath, 'utf8', function read(err3, data) { 							
 			if(err3 || !data)
 			{
 				return res.json({
 					status: 0,
 					message: 'Không thể đọc file!'
 				});
 			}
 			else
 			{
 				var arr = data.split("\n");
 				if(arr[0] == 1) //Train is currently at station
 				{
			 		async.forEachOfSeries(arrSessionDetailId, function (sessionDetailId, index, callback) {
			   		SessionDetail.findOne({
			   			id: sessionDetailId,
			   			status: 'ordered'
			   		}).populate('session').populate('dish').exec(function (err, sessionDetail) {
			   			if(err || !sessionDetail)
			   			{
			   				return res.json({
			   					status: 0,
			   					message: 'Không tìm thấy chi tiết đơn hàng!'
			   				});
			   			}
			   			else
			   			{
			   				sessionDetail.session.total += sessionDetail.price;
			   				sessionDetail.session.save(function(err2, savedSession){
			   					if(err2 || !savedSession)
			   					{
			   						return res.json({
			   							status: 0,
			   							message: 'Không thể lưu đơn hàng!'
			   						});
			   					}
			   					else
			   					{
				 						sessionDetail.status = 'delivered';
				 						sessionDetail.save(function(err5, savedSessionDetail){
				 							if(err5 || !savedSessionDetail)
				 							{
												callback(err5);
				 							}
				 							else
				 							{
				 								sails.sockets.broadcast('device', 'removeKitchenOverview', { sessionDetailId: sessionDetailId });
				 								sails.sockets.broadcast('table'+sessionDetail.session.table, 'item-delivered', 
				 								{
				 									sessionDetailId: sessionDetailId, 
				 									dishName: sessionDetail.dish.name, 
				 									type: 1, //Đã giao
				 									message: 'Đã giao' 
												});

												console.log("index: " + index);
												console.log("table: " + sessionDetail.session.table)
												table = sessionDetail.session.table;
				 							}
				 						});
			   					}
			   				});
			   			}
			   		});
			 		}, function done(err, table) {
			 			console.log(err);
			 			console.log("Table: " + table);
   					var newStr = "2\n" + table + "\n" + trainId;
   					fs.writeFile(fullFilePath, newStr, 'utf8', function (err4) {
   						if(err4)
   						{
   							return res.json({
   								status: 0,
   								message: 'Không thể ghi file!'
   							});
   						}
   						else
   						{
  					 		return res.json({
  							status: 1,
  							message: 'Giao hàng thành công!'
  						});
   						}
   					});
			 		});
 				}
 				else
 				{
 					return res.json({
 						status: 0,
 						message: 'Xe không sẵn sàng!'
 					});
 				}
 			}
 		});
	},

 	detail: function(req, res) {
 		var ip = req.ip;
 		ip = ip.substring(ip.lastIndexOf(":")+1, ip.length);

 		DeviceIp.findOne({
 		  ip: ip
 		}).exec(function (err, deviceIp) {
 		  if(err || !deviceIp)
 		  {
 		    return res.view('404', {layout: false});
 		  }
 		  else
 		  {
 		    if(deviceIp.type == 'cashier' || deviceIp.type == 'chief-cook')
 		    {
 		    	var sessionId = req.params.id;

 		    	Session.findOne({
 		    		id: sessionId,
 		    	}).exec(function (err1, session) {
 		    		if(err1 || !session)
 		    		{
 		    			return res.view('session-detail',{status: 0, datas: [], session: {}, deviceIp: deviceIp, remainings: []});
 		    		}
 		    		else
 		    		{
 		    			SessionDetail.find({
 		    				session: sessionId,
 		    				status: 'delivered'
 		    			}).populate('dish').exec(function (err2, sessionDetails) {
 		    				if(err2 || !sessionDetails || sessionDetails.length <= 0)
 		    				{
 		    					return res.view('session-detail',{status: 1, datas: [], session: session, deviceIp: deviceIp, remainings: []});
 		    				}
 		    				else
 		    				{
 		    					SessionDetail.find({
 		    						session: sessionId,
 		    						status: 'ordered'
 		    					}).populate('dish').exec(function (err3, remainings) {
 		    						if(err3 || !sessionDetails || sessionDetails.length <= 0)
 		    						{
 		    							return res.view('session-detail',{status: 1, datas: sessionDetails, session: session, deviceIp: deviceIp, remainings: []});
 		    						}
 		    						else
 		    						{
 		    							return res.view('session-detail',{status: 1, datas: sessionDetails, session: session, deviceIp: deviceIp, remainings: remainings});
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
};

