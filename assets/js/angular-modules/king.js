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

	app.directive('myEnter', function () {
	    return function (scope, element, attrs) {
	        element.bind("keydown keypress", function (event) {
	            if(event.which === 13) {
	                scope.$apply(function (){
	                    scope.$eval(attrs.myEnter);
	                });

	                event.preventDefault();
	            }
	        });
	    };
	});

	app.controller('dishManamentController', function($scope) {
		this.selectedDish = 0;
		this.editable = false;
		this.dishes = [];
		this.selectOptions = [];
		this.invalidInput = false;
		this.dirty = false;
		this.resetData = {};
		this.selectedName = '';
		this.countdownDuration = 3;
		this.deleteCountdown = this.countdownDuration;
		this.counting = false;
		this.selectedImage = {};
		this.adding = false;

		var notificationLocation = 'top left';

		var self = this;

		this.selectFirstDish = function(id, isFirst) {
			if(isFirst) {
				self.selectedDish = id;
			}
		}

		this.getFirstSelectedDish = function() {
			if(self.dishes.length == 0) {
				return null;
			}

			// var isDisable = false;
			var isEnable = false;
			var minPriceDisable = self.dishes[0].price;
			var minPriceEnable = self.dishes[0].price;
			var indexDisable = 0;
			var indexEnable = 0;

			for(var i = 0 ; i < self.dishes.length ; i ++ ) {

				if(self.dishes[i].status == 'enable') {
					isEnable = true;

					if(self.dishes[i].price < minPriceEnable)  {
						minPriceEnable = self.dishes[i].price;
						indexEnable = i;
					}

				} else if(!isEnable) {
					// isDisable = true;

					if(self.dishes[i].price < minPriceDisable)  {
						minPriceDisable = self.dishes[i].price;
						indexDisable = i;
					}
				}
			}

			if(isEnable) {
				console.log('selected enable' + indexEnable);
				self.selectedDish = indexEnable;
			}
			else {
				console.log('selected Disable' + indexDisable);
				self.selectedDish = indexDisable;
			}
		}

		function getMaxId() {
			var dishes = self.dishes;
			var maxId = -999;

			for(var i = 0; i < dishes.length; i++ ){
				maxId = dishes[i].id > maxId ? dishes[i].id : maxId;
			}

			return maxId;
		}

		function getNextId() {
			return getMaxId() + 1;
		}

		this.addDish = function() {
			var nexId = getNextId();
			var newDish = {
				id: nexId,
				name: '',
				description: '',
				status: 'disable',
				price: ''
			};

			beginAdd();

			self.dishes.push(newDish);
			self.selectedDish = nexId;
		}

		function beginAdd() {
			self.adding = true;
			self.dirty = true;
			self.editable = true;
		}

		function finishAdd() {
			self.adding = false;
			self.dirty = false;
			self.editable = false;
		}

		this.submitAddDish = function(dish) {
			// console.log('testing');
			// console.log(dish);

			$.ajax({
				method: 'POST',
				url: '/dish/addDish',
				data: { 
					dish: dish
				}
			}).done(function(data) {
				if(data.status == 0) {
 					$scope.$digest();
					$.notify("Tạo món " + self.dishes[getCurrentDish()].name + " thành công."
						, { position: notificationLocation, className: 'success' });
				}
				else {
					var message = "Tạo món " + self.dishes[getCurrentDish()].name + " không thành công.";
					$.notify( data.message ? data.message : message
						, { position: notificationLocation, className: 'error' });
				}
				// finishAdd();
			});
		}

		this.cancelAddDish = function() {
			var maxId = getMaxId();

			finishAdd();
			self.dishes.pop();
			self.selectedDish = getMaxId(this.dishes);
		}

		this.turnOnDirty = function() {
			this.dirty = true;
		}

		this.isDirty = function(index) {
			if(this.selectedDish == index && this.dirty) {
				return true;
			}

			return false;
		}

		function getImage(id) {
			var currentDish = self.dishes[getCurrentDish()];
			for(var i = 0 ; i < currentDish.images.length; i++ ) {
				if(currentDish.images[i].id == id) {
					return i;		
				}
			}
		}

		function delayTimeForDeleting(modal, button) {

			self.deleteCountdown = self.countdownDuration;
			self.counting = true;

			var deleteBtnText = "Xóa ";

			(function myLoop (duration) {          
			   setTimeout(function () {  
			   	  var textResult = self.deleteCountdown--;
			   	  if(textResult>1) {
			   	  	$(button).text(deleteBtnText + (textResult-1));
			   	  }
			   	  else {
			   	  	self.counting = false;
			   	  	$(button).text(deleteBtnText);
					$(button).removeAttr('disabled');
			   	  }

			      if (--duration && self.counting) myLoop(duration);
			   }, 1000)
			})(self.deleteCountdown);

	   	  	$(button).text(deleteBtnText + self.deleteCountdown);
			$(button).attr('disabled', 'disabled');
			$(modal).modal('show');
		}

		this.confirmDeleteImage = function(id) {			
			var currentImage = this.dishes[getCurrentDish()];
			this.selectedImage = this.dishes[getCurrentDish()].images[getImage(id)];

			delayTimeForDeleting('#deleteImage', '#btnDeleteImage');
		}

		function getCurrentDish() {
			for(var i = 0 ; i < self.dishes.length ; i++) {
				dish = self.dishes[i];
				if(dish.id == self.selectedDish) {
					return i;
				}
			}
		}

		function getCurrentSelect(id) {
			for(var i = 0 ; i < self.selectOptions.length ; i++) {
				select = self.selectOptions[i];
				if(select.id == id) {
					return select.name;
				}
			}
		}

		this.enableDish = function() {
			$.ajax({
				method: 'POST',
				url: '/dish/enableDish',
				data: { 
					dishId: this.selectedDish
				}
			}).done(function(data) {
				if(data.status == 0) {
					self.dishes[getCurrentDish()].status = 'enable';
 					$scope.$digest();
					$.notify("Enable món " + self.dishes[getCurrentDish()].name + " thành công."
						, { position: notificationLocation, className: 'success' });
				}
				else {
					var message = "Enable món " + self.dishes[getCurrentDish()].name + " không thành công.";
					$.notify( data.message ? data.message : message
						, { position: notificationLocation, className: 'error' });
				}
			});
		}

		this.disableDish = function() {
			$.ajax({
				method: 'POST',
				url: '/dish/disableDish',
				data: { 
					dishId: this.selectedDish
				}
			}).done(function(data) {
				if(data.status == 0) {
					self.dishes[getCurrentDish()].status = 'disable';
 					$scope.$digest();
					$.notify("Disable món " + self.dishes[getCurrentDish()].name + " thành công."
						, { position: notificationLocation, className: 'success' });
				}
				else {
					var message = "Disable món " + self.dishes[getCurrentDish()].name + " không thành công.";
					$.notify( data.message ? data.message : message
						, { position: notificationLocation, className: 'error' });
				}
			});

			$('#disableModal').modal('hide');
		}

		this.deleteImage = function(id) {
			$.ajax({
				method: 'POST',
				url: '/dish/deleteImage',
				data: {
					imageId: id
				}
			}).done(function(data){
				if(data.status == 0) {
					var currentName = self.dishes[getCurrentDish()].name;
					var currentDish = self.dishes[getCurrentDish()];
					currentDish.images.splice(getImage(id),1);		

 					$scope.$digest();
					$.notify("Xóa hình cho món " + currentName + " thành công."
						, { position: notificationLocation, className: 'success' });
				}
				else {
					var message = "Xóa hình cho món " + self.dishes[getCurrentDish()].name + " không thành công.";
					$.notify( data.message ? data.message : message
						, { position: notificationLocation, className: 'error' });
				}
			});

			$('#deleteImage').modal('hide');
		}

		this.deleteDish = function() {
			$.ajax({
				method: 'POST',
				url: '/dish/deleteDish',
				data: { 
					dishId: this.selectedDish
				}
			}).done(function(data) {
				if(data.status == 0) {
					var currentName = self.dishes[getCurrentDish()].name;
					self.dishes.splice(getCurrentDish(),1);
 					$scope.$digest();
					$.notify("Xóa món " + currentName + " thành công."
						, { position: notificationLocation, className: 'success' });
				}
				else {
					var message = "Xóa món " + self.dishes[getCurrentDish()].name + " không thành công.";
					$.notify( data.message ? data.message : message
						, { position: notificationLocation, className: 'error' });
				}
			});

			$('#deleteModal').modal('hide');
		}

		this.confirmDisableDish = function() {
			var currentDish = this.dishes[getCurrentDish()];
			this.selectedName = currentDish.name;

			$('#disableModal').modal('show');
		}

		this.resetDeleteCountdown = function() {
			self.counting = false;
		}

		this.confirmDeleteDish = function() {
			var currentDish = this.dishes[getCurrentDish()];
			this.selectedName = currentDish.name;

			delayTimeForDeleting('#deleteModal', '#btnDeleteDish');
		}


		this.selectName = function(id) {
			return getCurrentSelect(id);
		}

		this.changeCate = function(dishId, cateId) {
			this.dishes[dishId].category.id = cateId;
		}

		this.submitChange = function() {
			if(this.dirty) {
				var currentDish = getCurrentDish();
				$.ajax({
					method: 'POST',
					url: '/dish/editDish',
					data: this.dishes[currentDish]
				}).done(function(data) {
					if(data.status == 0) {
						var currentName = self.dishes[getCurrentDish()].name;
						$.notify("Sửa món " + currentName + " thành công."
							, { position: notificationLocation, className: 'success' });
					}
					else {
						var message = "Sửa món " + self.dishes[getCurrentDish()].name + " không thành công.";
						$.notify( data.message ? data.message : message
							, { position: notificationLocation, className: 'error' });
					}
				});
			}

			this.dirty = false;
			this.editable = false;
		}

		this.changeDish = function(index) {
			this.submitChange();
			this.selectedDish = index;
		}

		this.toggleEditMode = function() {
			this.editable = !this.editable;
		}

		this.edit = function() {
			angular.copy(this.dishes[getCurrentDish()], this.resetData);
			this.editable = true;
		}

		this.cancelEdit = function() {
			if (!this.adding) {
				angular.copy(this.resetData, this.dishes[getCurrentDish()]);
			}

			this.adding = false;
			this.editable = false;
			this.dirty = false;

		}
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
