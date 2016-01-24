(function() {
	var app = angular.module('king', []);
	var devicesViewPath = '/templates/devicesView/';
	var dishesViewPath = '/templates/dishesView';

	var devices = [
		{ deviceIndex: 0, isSelected: false},
		{ deviceIndex: 1, isSelected: false},
		{ deviceIndex: 2, isSelected: false},
		{ deviceIndex: 3, isSelected: false},
		{ deviceIndex: 4, isSelected: false},
		{ deviceIndex: 5, isSelected: false},
		{ deviceIndex: 6, isSelected: false},
		{ deviceIndex: 7, isSelected: false}
	];


	app.controller('allDevicesController', function(){
		this.devices = devices;

		this.changeStatus = function(index, status) {
			this.devices[index].status = status;
			console.log(index, status);
		};

		this.isAnyChecked = function() {
			return countSelection() > 0 ? true : false;
		};

		this.canMerge = function() {
			return countSelection() > 1 ? true : false;
		};
	});

	app.directive('mergeTableModal', function() {
		return {
			restrict: 'E',
			templateUrl: devicesViewPath + '_mergeTableModal.html',
			controller: function() {
				this.selectedDevice = 0;

				this.devices = devices;

				this.changeDevice = function(device) {
					this.selectedDevice = device;
				};

				this.isSelected = function(index) {
					return this.selectedDevice == index ? true : false;
				};

				this.firstSelection = function() {
					for(var i = 0 ; i < devices.length; i++) {
						if(devices[i].isSelected) 
						{
							return i;
						}
					}

					return -1;
				};

			},
			controllerAs: 'mergeTable'
		};
	});

	app.controller('dishManamentController', function() {
		
	});

	var isInDishesManagement = function(view) {
		return view == 'dishesManage';
	};

	var countSelection = function() {
		var number = 0;

		for(var i = 0 ; i < devices.length; i++) {
			if(devices[i].isSelected) 
			{
				number++;
			}
		}

		return number;
	};
})();

// (function() {

// 	var app = angular.module('store-products', []);


// 	app.controller('ReviewController', function() {
// 	  this.review = {};

// 	  this.addReview = function(product) {
// 	    product.reviews.push(this.review);

// 	    this.review = {};
// 	  }
// 	});

// 	app.directive('productTitle', function() {
// 	  return {
// 	    restrict: 'A',
// 	    templateUrl: '/templates/product-title.html'
// 	  };
// 	})

// 	app.directive('productPanels', function() {
// 	  return {
// 	    restrict: 'E',
// 	    templateUrl: '/templates/product-panels.html',
// 	    controller: function() {
// 	      this.tab = 1;

// 	      this.selectTab = function(setTab) {
// 	        this.tab = setTab;
// 	      };

// 	      this.isSelected = function(checkTab) {
// 	        return this.tab === checkTab;
// 	      };

// 	    },
// 	    controllerAs: 'panels'
// 	  };
// 	})

// })();