/**
 * Route Mappings
 * (sails.config.routes)
 *
 * Your routes map URLs to views and controllers.
 *
 * If Sails receives a URL that doesn't match any of the routes below,
 * it will check for matching files (images, scripts, stylesheets, etc.)
 * in your assets directory.  e.g. `http://localhost:1337/images/foo.jpg`
 * might match an image file: `/assets/images/foo.jpg`
 *
 * Finally, if those don't match either, the default 404 handler is triggered.
 * See `api/responses/notFound.js` to adjust your app's 404 logic.
 *
 * Note: Sails doesn't ACTUALLY serve stuff from `assets`-- the default Gruntfile in Sails copies
 * flat files from `assets` to `.tmp/public`.  This allows you to do things like compile LESS or
 * CoffeeScript for the front-end.
 *
 * For more information on configuring custom routes, check out:
 * http://sailsjs.org/#/documentation/concepts/Routes/RouteTargetSyntax.html
 */

module.exports.routes = {

  /***************************************************************************
  *                                                                          *
  * Make the view located at `views/homepage.ejs` (or `views/homepage.jade`, *
  * etc. depending on your default view engine) your home page.              *
  *                                                                          *
  * (Alternatively, remove this and add an `index.html` file in your         *
  * `assets` directory)                                                      *
  *                                                                          *
  ***************************************************************************/

  // '/': {
  //   view: 'test'
  // },

  /***************************************************************************
  *                                                                          *
  * Custom routes here...                                                    *
  *                                                                          *
  *  If a request to a URL doesn't match any of the custom routes above, it  *
  * is matched against Sails route blueprints. See `config/blueprints.js`    *
  * for configuration options and examples.                                  *
  *                                                                          *
  ***************************************************************************/
  //VIEW
  'GET /': 'DishController.index',
  'GET /menu': 'DishController.viewMenu',
  'GET /devices': 'DeviceController.listDevice',
  'GET /ordered': 'SessionController.listOrdered',
  'GET /ordered/overview': 'SessionController.overview',
  'GET /ordered/detail/:id': 'SessionDetailController.detail',
  'GET /kitchen/overview': 'SessionController.kitchenOverview',
  'GET /kitchen/dish': 'DishController.kitchenDish',
  'GET /kitchen/fastDelivery': 'DeviceController.fastDelivery',
  'GET /dish/manage' : 'DishController.manage',
  'GET /cashier/menu' : 'DishController.cashierMenu',
  'GET /cashier/ordered' : 'SessionController.cashierOrdered',
  'GET /kitchen/report': 'SessionController.report',

  //API
  'GET /dishes': 'DishController.getDishes',
  'GET /categories/getDish': 'DishController.getDishByCategory',
  'GET /categories': 'DishController.getCategories',
  'GET /subscribe/:roomName': 'DeviceController.subscribe',
  'GET /unsubscribe/:roomName': 'DeviceController.unsubscribe',
  'GET /list-subscriber/:roomName': 'TestController.listSubscriber',
  'POST /api/ordered/detail' : 'SessionController.getSessionDetails',
  'POST /broadcast': 'TestController.broadcast',
  'POST /device/connect': 'DeviceController.connect',
  'POST /table/open': 'SessionController.openTable',
  'POST /table/openAndOpen': 'SessionController.mergeAndOpenTable',
  'POST /addItem': 'SessionController.addItem',
  'POST /removeItem': 'SessionController.removeItem',
  'POST /removeOrderedItem': 'SessionController.removeOrderedItem',
  'POST /cancelTable': 'SessionController.cancelTable',
  'POST /cancelAll': 'SessionController.cancelAll',
  'POST /order': 'SessionController.order',
  'POST /checkout': 'SessionController.checkout',
  'POST /deliver': 'SessionDetailController.deliver',
  'POST /batchDeliverDineIn': 'SessionDetailController.batchDeliverDineIn',
  'POST /batchDeliverToGo': 'SessionDetailController.batchDeliverToGo',
  'POST /finalCheckout': 'SessionController.finalCheckout',
  'POST /hideDish': 'DishController.hideDish',
  'POST /showDish': 'DishController.showDish',
  'POST /blockTable': 'SessionController.blockTable',
  'POST /unblockTable': 'SessionController.unblockTable',
  'POST /cashier/order': 'SessionController.cashierOrder',
  'POST /kitchen/fastDelivery': 'DeviceController.startFastDelivery',
  'POST /kitchen/report': 'SessionController.getReport',

  // Dish management
  'POST /dish/editDish': 'DishController.editDish',
  'POST /dish/enableDish': 'DishController.enableDish',
  'POST /dish/disableDish': 'DishController.disableDish',
  'POST /dish/deleteDish': 'DishController.deleteDish',
  'POST /dish/addDish': 'DishController.addDish',
};
