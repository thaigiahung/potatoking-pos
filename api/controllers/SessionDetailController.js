/**
 * SessionDetailController
 *
 * @description :: Server-side logic for managing order_details
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

 module.exports = {
 	deliver: function(req, res) {
 		var sessionDetailId = req.body.sessionDetailId;

 		SessionDetail.findOne({
 			id: sessionDetailId,
 			status: 'ordered'
 		}).populate('session').populate('dish').exec(function (err, sessionDetail) {
 			if(err || !sessionDetail)
 			{
 				return res.json({
 					status: 0,
 					message: 'Không thể giao hàng!'
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
 							message: 'Không thể giao hàng!'
 						});
 					}
 					else
 					{
 						sessionDetail.status = 'delivered';
 						sessionDetail.save(function(err3, savedSessionDetail){
 							if(err3 || !savedSessionDetail)
 							{
 								return res.json({
 									status: 0,
 									message: 'Không thể giao hàng!'
 								});
 							}
 							else
 							{
 								sails.sockets.broadcast('device', 'removeKitchenOverview', { sessionDetailId: sessionDetailId });
 								sails.sockets.broadcast('table'+sessionDetail.session.table, 'item-delivered', {sessionDetailId: sessionDetailId, dishName: sessionDetail.dish.name, message: 'Đã giao' });

 								return res.json({
 									status: 1,
 									message: 'Thành công!'
 								});
 							}
 						});
 					}
 				});
 			}
 		});
	},

 	detail: function(req, res) {
 		var sessionId = req.params.id;

 		Session.findOne({
 			id: sessionId,
 		}).exec(function (err, session) {
 			if(err || !session)
 			{
 				return res.view('session-detail',{status: 0, datas: [], session: {}});
 			}
 			else
 			{
 				SessionDetail.find({
 					session: sessionId,
 					status: 'delivered'
 				}).populate('dish').exec(function (err, sessionDetails) {
 					if(err || !sessionDetails || sessionDetails.length <= 0)
 					{
 						return res.view('session-detail',{status: 1, datas: [], session: session});
 					}
 					else
 					{
 						return res.view('session-detail',{status: 1, datas: sessionDetails, session: session});
 					}
 				});
 			}
 		});
	},
};

