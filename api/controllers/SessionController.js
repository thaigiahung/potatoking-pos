/**
 * SessionController
 *
 * @description :: Server-side logic for managing sessions
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

var async = require('async');
var moment = require('moment-timezone');

module.exports = {
  getSessionDetails: function (req, res) {
    this.authorizeRoles = ['guest', 'chief-cook', 'cashier'];
    this.req = req;
    this.res = res;
    this.deviceIp = DeviceIp;

    function callback() {
      SessionDetail.find({
        session: req.body.sessionId,
        parent: null,
        status: 'added'
      }).populate('dish')
        .exec(function (err, found) {
          if (err) {
            console.log(err);
            res.json({
              status: 0,
              message: "Internal Error"
            });
          }

          res.json({
            status: 1,
            details: found
          });
        })
    };

    return Authorize.apply(this, callback);
  },

  openTable: function (req, res) {
    Device.findOne({
      id: req.body.id
    }).exec(function (err, device) {
      if (err || !device) {
        return res.json({
          status: 0,
          message: 'Thiết bị lạ'
        });
      }
      else if (!device.connecting) {
        return res.json({
          status: 0,
          message: 'Thiết bị chưa kết nối vào mạng'
        });
      }
      else {
        Session.findOne({
          table: device.table,
          status: 'open'
        }).exec(function (err, session) {
          if (err || !session) {
            //Update table Session
            Session.create({
              table: device.table,
              status: 'open',
              deliveryType: 'dine-in',
              startTime: new Date(),
              endTime: new Date()
            }).exec(function (err2, createdSession) {
              if (err2 || !createdSession) {
                return res.json({
                  status: 0,
                  message: 'Không thể mở bàn'
                });
              }
              else {
                SessionDevice.create({
                  device: device.id,
                  session: createdSession.id
                }).exec(function (err3, createdSessionDevice) {
                  device.opening = true;
                  device.save(function (err, saved) { });

                  //Broadcast to room tableId with the event name opened
                  sails.sockets.broadcast(
                    'table' + device.table,
                    'opened',
                    {
                      table: device.table,
                      sessionId: createdSession.id,
                      message: '[Bàn ' + device.table + '] Mở bàn thành công!'
                    }
                  );

                  //Broadcast to room device with the event name opened
                  sails.sockets.broadcast(
                    'device',
                    'opened',
                    {
                      table: device.table,
                      session: createdSession,
                      message: '[Bàn ' + device.table + '] Mở bàn thành công!'
                    }
                  );

                  sails.sockets.broadcast('device', 'addOverviewRow', { session: createdSession });

                  sails.sockets.broadcast(
                    'device',
                    'addToDivOpenedTable',
                    {
                      session: createdSession.id,
                      table: device.table
                    }
                  );

                  return res.json({
                    status: 1,
                    message: '[Bàn ' + device.table + '] Mở bàn thành công!'
                  });

                  //Broadcast to room
                  /*sails.sockets.broadcast('table', 'table'+device.table, {message: "Thiết bị này đã được ghép vào bàn " + device.table});

                  return res.json({
                    status: 1,
                    message: 'Thiết bị này đã được ghép vào bàn ' + device.table
                  });*/
                });
              }
            });
          }
          else {
            return res.json({
              status: 0,
              message: 'Bàn đang hoạt động!'
            });
          }
        });
      }
    });
  },

  mergeAndOpenTable: function (req, res) {
    var arrSelectedTableName = [];
    var arrSelectedTable = JSON.parse(req.body.arrSelectedTable);
    var selectedMergeTable = req.body.selectedMergeTable;
    var arrError = [];

    Session.findOne({
      table: selectedMergeTable,
      status: 'open',
    }).exec(function (err, session) {
      if (session) {
        //Already created
        return res.json({
          status: 0,
          message: 'Bàn đã được mở từ trước!'
        });
      }
      else {
        //Update table Session
        Session.create({
          table: selectedMergeTable,
          status: 'open',
          deliveryType: 'dine-in',
          startTime: new Date(),
          endTime: new Date()
        }).exec(function (err, createdSession) {
          if (err || !createdSession) {
            return res.json({
              status: 0,
              message: 'Không thể mở bàn!'
            });
          }
          else {
            async.forEachOfSeries(arrSelectedTable, function (selectedTable, index, callback) {
              Device.findOne({
                id: selectedTable,
                connecting: true
              }).exec(function (err2, device) {
                if (!err2 && device) {
                  SessionDevice.findOne({
                    device: device.id,
                    session: createdSession.id
                  }).exec(function (err3, sessionDevice) {
                    if (err3 || !sessionDevice) {
                      SessionDevice.create({
                        device: device.id,
                        session: createdSession.id
                      }).exec(function (err3, createdSessionDevice) {
                        device.opening = true;
                        device.save(function (err, saved) { });

                        //Broadcast to current table's room to order it subscribes to new table
                        sails.sockets.broadcast(
                          'table' + device.table,
                          'merged',
                          {
                            table: selectedMergeTable,
                            room: 'table' + selectedMergeTable,
                            sessionId: createdSession.id,
                            message: '[Bàn ' + selectedMergeTable + '] Mở bàn thành công!'
                          }
                        );

                        //Broadcast to room device with the event name opened
                        sails.sockets.broadcast(
                          'device',
                          'opened',
                          {
                            table: device.table,
                            session: createdSession,
                            message: '[Bàn ' + device.table + '] Mở bàn thành công!'
                          }
                        );
                      });
                    }
                  });
                }
                else {
                  arrError.push(device.table);
                }
                arrSelectedTableName.push(device.table);
                callback();
              });
            }, function done() {
              if (arrError.length > 0) {
                return res.json({
                  status: 0,
                  message: 'Không thể ghép bàn ' + arrError.toString() + ' vào bàn ' + selectedMergeTable
                });
              }
              else {
                sails.sockets.broadcast('device', 'addOverviewRow', { session: createdSession });

                sails.sockets.broadcast(
                  'device',
                  'addToDivOpenedTable',
                  {
                    session: createdSession.id,
                    table: arrSelectedTableName.join()
                  }
                );
                return res.json({
                  status: 1,
                  message: '[Bàn ' + selectedMergeTable + '] Mở bàn thành công!'
                });
              }
            });
          }
        });
      }
    });
  },


  addItem: function (req, res) {
    var roomName = req.body.roomName;
    var data = req.body;

    var dishIds = _.map(data.items, function (item) {
      return item.dish.id;
    });

    Dish.find({
      id: dishIds,
      status: 'enable',
    }).exec(function (err, dishes) {
      if (err || dishes.length < dishIds.length) {
        return res.json({
          status: 0,
          message: 'Không thể chọn món!'
        });
      }
      else {
        //Find Session
        Session.findOne({
          id: data.sessionId,
          status: 'open',
        }).exec(function (err, session) {
          if (err || !session) {
            return res.json({
              status: 0,
              message: 'Không thể chọn món!'
            });
          }
          else {
            var itemsToAdd = [];
            var parentItems = [];

            data.items.forEach(function (dish) {
              var currentItemToAdd = {
                session: data.sessionId,
                dish: dish.dish.id,
                price: getDishPriceBySize(dish.dish, dish.size),
                size: dish.size,
                status: 'added',
                parent: dish.parentDish
              }
              if (dish.parentDish != null) {
                itemsToAdd.push(currentItemToAdd);
              }
              else {
                parentItems.push(currentItemToAdd);
              }
            });


            SessionDetail.find({
              session: data.sessionId,
              status: 'added',
              parent: null
            }).exec(function (err, foundDetails) {
              if (err) {
                console.log(err);
                return res.json({
                  status: 0,
                  message: 'Không thể chọn món!'
                });
              }
              else if (foundDetails.length >= Util.trainSize || (foundDetails.length + parentItems.lenght) > Util.trainSize) {
                console.log('Train maximum capacity reached!');
                return res.json({
                  status: 0,
                  message: 'Train maximum capacity reached!'
                });
              }
              else {
                SessionDetail.create(parentItems)
                  .exec(function (err, created) {
                    if (err || !created) {
                      if (err) {
                        console.log(err);
                        return res.json({
                          status: 0,
                          message: 'Không thể chọn món!'
                        });
                      }
                      else {
                        return res.json({
                          status: 0,
                          message: 'Can not create session details!'
                        });
                      }
                    }

                    itemsToAdd.forEach(function (e) {
                      e.parent = created[0].id;
                    });

                    SessionDetail.create(itemsToAdd)
                      .exec(function (err, createdChild) {
                        if (err || !createdChild) {
                          if (err) {
                            console.log(err);
                            return res.json({
                              status: 0,
                              message: 'Không thể chọn món!'
                            });
                          }
                          else {
                            return res.json({
                              status: 0,
                              message: 'Can not create child session details!'
                            });
                          }
                        }
                        else {
                          SessionDetail.find({
                            session: data.sessionId,

                            status: 'added',
                            parent: null
                          })
                            .exec(function (err, details) {
                              if (err || !details) {

                                if (err) {
                                  console.log(err);
                                }
                                else {
                                  console.log('Can not find session details');
                                }
                              }

                              sails.sockets.broadcast(roomName, 'addItem', { msg: details });
                              return res.json({
                                status: 1,
                                message: 'Thành công!'
                              });

                              // //                 // data['sessionDetail'] = createdSessionDetail;
                            });
                        }
                      });
                  });
              }
            });

          }
        });
      }
    });
  },

  removeItem: function (req, res) {
    var roomName = req.body.roomName;
    var detailId = req.body.detailId;

    //Update status in Session Detail
    SessionDetail.update({
      id: detailId
    }, {
        status: 'cancelled'
      }, function (err, sessionDetails) {
        if (err || !sessionDetails) {
          return res.json({
            status: 0,
            message: 'Không thể hủy món!'
          });
        }
        else {
          var parentId = _.map(sessionDetails, 'id');
          SessionDetail.update({
            parent: parentId
          }, {
              status: 'cancelled'
            }, function (err, childSession) {
              if (err) {
                return res.json({
                  status: 0,
                  message: 'Không thể hủy món!'
                });
              }

                sails.sockets.broadcast(roomName, 'removeItem', null);
                return res.json({
                  status: 1,
                  message: 'Thành công!'

            })


          });
        }
      });
  },

  removeOrderedItem: function (req, res) {
    var id = req.body.id;

    //Update status in Session Detail
    SessionDetail.findOne({
      id: id,
      status: 'ordered'
    }).populate('session').populate('dish').exec(function (err, sessionDetail) {
      if (err || !sessionDetail) {
        return res.json({
          status: 0,
          message: 'Không thể hủy món!'
        });
      }
      else {
        sessionDetail.status = 'removed';
        sessionDetail.save(function (err, saved) {
          if (err) {
            return res.json({
              status: 0,
              message: 'Không thể hủy món!'
            });
          }
          else {
            sails.sockets.broadcast('device', 'removeKitchenOverview', { deliveryType: sessionDetail.session.deliveryType, sessionDetailId: id });
            sails.sockets.broadcast('table' + sessionDetail.session.table, 'item-delivered',
              {
                sessionDetailId: id,
                dishName: sessionDetail.dish.name,
                type: 2, //Đã hủy
                message: 'Nhà bếp đã hủy'
              });
            return res.json({
              status: 1,
              message: 'Thành công!'
            });
          }
        });
      }
    });
  },

  cancelTable: function (req, res) {
    var sessionId = JSON.parse(req.body.sessionId);

    Session.findOne({
      id: sessionId,
      status: 'open'
    }).exec(function (err, session) {
      if (err || !session) {
        return res.json({
          status: 0,
          message: 'Không thể hủy bàn!'
        });
      }
      else {
        //Check if this table has any item delivered
        SessionDetail.find({
          session: sessionId,
          status: 'delivered'
        }).exec(function (err, sessionDetails) {
          if (err || !sessionDetails) //No item delivered
          {
            //Cancel all items
            SessionDetail.update(
              { session: sessionId, status: 'ordered' },
              { status: 'cancelled' }
            ).exec(function (err, updated) {
              if (err || !updated) {
                return res.json({
                  status: 0,
                  message: 'Không thể hủy món!'
                });
              }
              else {
                //Update session status
                session.status = 'close';
                session.paymentStatus = 'cancelled';
                session.save(function (err2, saved) {
                  if (err2 || !saved) {
                    return res.json({
                      status: 0,
                      message: 'Không thể hủy bàn!'
                    });
                  }
                  else {
                    //Broadcast to kitchen to remove these items
                    sails.sockets.broadcast('device', 'cancelAll', { sessionId: sessionId });

                    SessionDevice.find({
                      session: sessionId
                    }).populate('device').exec(function (err3, sessionDevices) {
                      if (!err3 && sessionDevices && sessionDevices.length > 0) {
                        async.forEachOfSeries(sessionDevices, function (sessionDevice, index, callback) {
                          sessionDevice.device.opening = false;
                          sessionDevice.device.save(function (err4, saved) {
                            if (!err4) {
                              sails.sockets.broadcast('device', 'cancelled', sessionDevice.device.table);
                            }
                          });
                          callback();
                        }, function done() {
                          sails.sockets.broadcast('table' + session.table, 'cancelled', { msg: session.table });

                          sails.sockets.broadcast('device', 'removeOverviewRow', sessionId);

                          return res.json({
                            status: 1,
                            message: 'Hủy bàn thành công!'
                          });
                        });
                      }
                    });
                  }
                });
              }
            });
          }
          else {
            return res.json({
              status: 0,
              message: 'Vui lòng thanh toán trước khi hủy bàn!'
            });
          }
        });
      }
    });
  },

  cancelAll: function (req, res) {
    var sessionId = JSON.parse(req.body.sessionId);

    SessionDetail.update(
      { session: sessionId, status: 'ordered' },
      { status: 'cancelled' }
    ).exec(function (err, updated) {
      if (err || !updated) {
        return res.json({
          status: 0,
          message: 'Không thể hủy món!'
        });
      }
      else {
        //Broadcast to kitchen to remove these items
        sails.sockets.broadcast('device', 'cancelAll', { sessionId: sessionId });

        return res.json({
          status: 1,
          message: 'Thành công!'
        });
      }
    });
  },

  order: function (req, res) {
    var sessionId = req.body.sessionId;
    
    Session.findOne({
      id: sessionId
    }).exec(function (err, session) {
      if (err || !session) {
        return res.json({
          status: 0,
          message: 'Không thể đặt món!'
        });
      }
      else {
        SessionDetail.find({
          session: sessionId,
          status: 'added'
        }).populate('session').populate('dish').exec(function (err1, sessionDetails) {
          console.log(sessionDetails);
          
          // if (!err1 && sessionDetails.length > 0) {
          //   //Broadcast to view Kitchen Overview
          //   sails.sockets.broadcast('device', 'newOrderAdded', { type: 'dine-in', sessionDetails: JSON.stringify(sessionDetails) });

          //   //Change status to ordered
          //   SessionDetail.update(
          //     { session: sessionId, status: 'added' },
          //     { status: 'ordered' }
          //   ).exec(function (err2, updatedSessionDetail) {
          //     if (err2 || !updatedSessionDetail) {
          //       return res.json({
          //         status: 0,
          //         message: 'Không thể đặt món!'
          //       });
          //     }
          //     else {
          //       sails.sockets.broadcast('table' + session.table, 'ordered', { msg: '/menu' });

          //       return res.json({
          //         status: 1,
          //         message: 'Đặt món thành công!'
          //       });
          //     }
          //   });
          // }
          // else {
          //   return res.json({
          //     status: 0,
          //     message: 'Không thể đặt món!'
          //   });
          // }
        });
      }
    });
  },

  listOrdered: function (req, res) {
    var ip = req.ip;
    ip = ip.substring(ip.lastIndexOf(":") + 1, ip.length);

    DeviceIp.findOne({
      ip: ip
    }).populate('device').exec(function (err, deviceIp) {
      if (err || !deviceIp) {
        return res.view('404', { layout: false });
      }
      else {
        if (deviceIp.type == 'guest') {
          device = deviceIp.device;

          var query = "SELECT s.* FROM session s JOIN sessiondevice sd ON sd.session = s.id WHERE s.status = 'open' AND sd.device = " + device.id;
          Session.query(query, function (err, session) {
            if (err || !session || session.length == 0) {
              return res.view('ordered', { layout: 'layout-user', status: 0, session: session, ordered: [], deviceIp: deviceIp });
            }
            else {
              session = session[0];
              SessionDetail.find({
                where: {
                  session: session.id,
                  status: ['ordered', 'cancelled', 'removed', 'delivered']
                },
                sort: 'id DESC'
              }).populate('dish').exec(function (err, ordered) {
                if (err || !ordered) {
                  return res.view('ordered', { layout: 'layout-user', status: 0, session: session, ordered: [], deviceIp: deviceIp });
                }
                else {
                  return res.view('ordered', { layout: 'layout-user', status: 1, session: session, ordered: ordered, deviceIp: deviceIp });
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
  },

  overview: function (req, res) {
    var ip = req.ip;
    ip = ip.substring(ip.lastIndexOf(":") + 1, ip.length);

    DeviceIp.findOne({
      ip: ip
    }).exec(function (err, deviceIp) {
      if (err || !deviceIp) {
        return res.view('404', { layout: false });
      }
      else {
        if (deviceIp.type == 'cashier' || deviceIp.type == 'chief-cook') {
          Session.find({
            status: 'open'
          }).exec(function (err, sessions) {
            if (err || !sessions) {
              return res.view('overview', { status: 0, moment: moment, sessions: [], deviceIp: deviceIp });
            }
            else {
              return res.view('overview', { status: 1, moment: moment, sessions: sessions, deviceIp: deviceIp });
            }
          });
        }
        else {
          return res.view('404', { layout: false });
        }
      }
    });
  },

  kitchenOverview: function (req, res) {
    var ip = req.ip;
    ip = ip.substring(ip.lastIndexOf(":") + 1, ip.length);
    DeviceIp.findOne({
      ip: ip
    }).exec(function (err, deviceIp) {
      if (err || !deviceIp) {
        return res.view('404', { layout: false }, { layout: false });
      }
      else {
        if (deviceIp.type == 'chief-cook') {
          // console.log("Devide founded");
          /*var query = "SELECT DISTINCT(s.id), s.* 
                      FROM `sessiondetail` sd JOIN session s ON s.id = sd.session 
                      WHERE sd.status = 'ordered' AND s.status = 'open'";*/
          SessionDetail.find({
            where: {
              status: 'ordered'
            },
            sort: 'id ASC'
          }).populate('dish').populate('session').exec(function (err, sessionDetails) {
            if (err || !sessionDetails) {
              return res.view('kitchen-overview', { status: 0, moment: moment, sessionDetails: [], deviceIp: deviceIp });
            }
            else {
              var sessionDetailsDineIn = [];
              var sessionDetailsTogo = [];

              for (var i = 0; i < sessionDetails.length; i++) {
                var currentSession = sessionDetails[i];

                if (currentSession.session.deliveryType == 'dine-in') {
                  sessionDetailsDineIn.push(currentSession);
                }
                else if (currentSession.session.deliveryType == 'to-go') {
                  sessionDetailsTogo.push(currentSession);
                }
              }

              return res.view('kitchen-overview', {
                status: 1
                , moment: moment
                , dineInList: sessionDetailsDineIn
                , toGoList: sessionDetailsTogo
                , sessionDetails: sessionDetails
                , deviceIp: deviceIp
              });
            }
          });
        }
        else {
          return res.view('404', { layout: false });
        }
      }
    });
  },

  checkout: function (req, res) {
    var sessionId = req.body.sessionId;

    Session.findOne({
      id: sessionId,
      status: 'open'
    }).exec(function (err, session) {
      if (err || !session) {
        return res.json({
          status: 0,
          message: 'Không thể thanh toán!'
        });
      }
      else {
        session.paymentStatus = 'checkout';
        session.save(function (err, saved) {
          if (err || !saved) {
            return res.json({
              status: 0,
              message: 'Không thể thanh toán!'
            });
          }
          else {
            sails.sockets.broadcast('device', 'checkout', { session: session });
            sails.sockets.broadcast('device', 'receive-message', { table: session.table, sessionId: session.id, message: 'Thanh toán. <a href="/ordered/detail/' + session.id + '">Xem chi tiết</a>' });

            sails.sockets.broadcast('table' + session.table, 'checkout', { msg: 'Nhân viên sẽ liên hệ với bạn ngay!' });

            return res.json({
              status: 1,
              message: 'Nhân viên sẽ liên hệ với bạn ngay!'
            });
          }
        });
      }
    });
  },

  finalCheckout: function (req, res) {
    var sessionId = req.body.sessionId;

    Session.findOne({
      id: sessionId,
      status: 'open',
      paymentStatus: 'checkout'
    }).exec(function (err, session) {
      if (err || !session) {
        return res.json({
          status: 0,
          message: 'Không thể thanh toán!'
        });
      }
      else {
        session.status = 'close'
        session.paymentStatus = 'paid';
        session.receive = req.body.receive;
        session.change = req.body.change;
        session.save(function (err, saved) {
          if (err || !saved) {
            return res.json({
              status: 0,
              message: 'Không thể thanh toán!'
            });
          }
          else {
            //Set Device Opening Status
            SessionDevice.find({
              session: sessionId
            }).populate('device').exec(function (err, sessionDevices) {
              if (!err && sessionDevices && sessionDevices.length > 0) {
                async.forEachOfSeries(sessionDevices, function (sessionDevice, index, callback) {
                  sessionDevice.device.opening = false;
                  sessionDevice.device.save(function (err4, saved) { });
                  callback();
                }, function done() { });
              }
            });

            // sails.sockets.broadcast('device', 'paid', { session: session });
            sails.sockets.broadcast('table' + session.table, 'paid', { table: session.table });

            return res.json({
              status: 1,
              message: 'Thành công!'
            });
          }
        });
      }
    });
  },

  cashierOrder: function (req, res) {
    var data = req.body.data;
    var total = req.body.total;
    var receive = req.body.receive;
    var change = req.body.change;

    var ip = req.ip;
    ip = ip.substring(ip.lastIndexOf(":") + 1, ip.length);

    if (data.length > 0) {
      DeviceIp.findOne({
        ip: ip
      }).populate('device').exec(function (err, deviceIp) {
        if (err || !deviceIp) {
          return res.view('404', { layout: false });
        }
        else {
          if (deviceIp.type == 'cashier') {
            device = deviceIp.device;

            Session.create({
              table: device.table,
              status: 'close',
              paymentStatus: 'paid',
              deliveryType: 'to-go',
              receive: receive,
              change: change,
              total: total,
              startTime: new Date(),
              endTime: new Date()
            }).exec(function (err, createdSession) {
              if (err || !createdSession) {
                return res.json({
                  status: 0,
                  message: 'Không thể đặt món!'
                });
              }
              else {
                var sessionDetails = [];
                async.forEachOfSeries(data, function (item, index, callback) {
                  //Create Session Detail
                  SessionDetail.create({
                    session: createdSession.id,
                    dish: item.id,
                    price: item.price,
                    status: 'ordered'
                  }).exec(function (err1, createdSessionDetail) {
                    if (err1 || !createdSessionDetail) {
                      callback(err1);
                    }
                    else {
                      callback();
                    }
                  });
                }, function done(err) {
                  if (err) {
                    return res.json({
                      status: 0,
                      message: 'Không thể đặt món!'
                    });
                  }
                  else {
                    SessionDetail.find({
                      session: createdSession.id,
                      status: 'ordered'
                    }).populate('session').populate('dish').exec(function (err, sessionDetails) {
                      if (!err && sessionDetails.length > 0) {
                        //Broadcast to view Kitchen Overview
                        sails.sockets.broadcast('device', 'newOrderAdded', { type: 'to-go', sessionDetails: JSON.stringify(sessionDetails) });
                      }
                    });

                    return res.json({
                      status: 1,
                      message: 'Đặt món thành công!'
                    });
                  }
                });
              }
            });
          }
        }
      });
    }
    else {
      return res.json({
        status: 0,
        message: 'Vui lòng chọn món!'
      });
    }
  },

  cashierOrdered: function (req, res) {
    var ip = req.ip;
    ip = ip.substring(ip.lastIndexOf(":") + 1, ip.length);

    DeviceIp.findOne({
      ip: ip
    }).populate('device').exec(function (err, deviceIp) {
      if (err || !deviceIp) {
        return res.view('403', { layout: false });
      }
      else {
        if (deviceIp.type == 'cashier') {
          Session.find({
            deliveryType: 'to-go'
          }).populate('sessionDetails').exec(function (err, sessions) {
            var objDishes = {};
            if (err || !sessions) {
              return res.view('cashier-ordered', { status: 0, deviceIp: deviceIp, data: [], dishes: objDishes });
            }
            else {

              Dish.find({ status: 'enable' }).exec(function (err, dishes) {
                if (err || !dishes) {
                  return res.view('cashier-ordered', { status: 0, deviceIp: deviceIp, data: sessions, dishes: objDishes });
                }
                else {
                  async.forEachOfSeries(dishes, function (dish, index, callback) {
                    objDishes[dish.id] = dish.name;
                    callback();
                  }, function done() {
                    return res.view('cashier-ordered', { status: 1, deviceIp: deviceIp, data: sessions, dishes: objDishes });
                  });
                }
              });
            }
          });
        }
        else {
          return res.view('403', { layout: false });
        }
      }
    });
  },

  blockTable: function (req, res) {
    var table = req.body.table;
    sails.sockets.broadcast('table' + table, 'blockTable', { msg: "Bàn của quý khách đang được thanh toán!" });
  },

  unblockTable: function (req, res) {
    var table = req.body.table;
    sails.sockets.broadcast('table' + table, 'unblockTable', { msg: "Bàn của quý khách đã được mở lại!" });
  },
};

var getMainDishId = function (dishes) {
  for (var i = 0; i < dishes.length; i++) {
    if (dishes[i].main) {
      return dishes[i];
    }
  }
}

var getDishPriceBySize = function (dish, sizeId) {
  if (sizeId == 0) {
    return dish.price;
  }

  for (var i = 0; i < dish.otherPrices.length; i++) {
    var currentPrice = dish.otherPrices[i];

    if (currentPrice.id == sizeId) {
      return currentPrice.price;
    }
  }
}