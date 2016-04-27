(function() {
    var app = angular.module('king', ['ui.bootstrap']);
    var devicesViewPath = '/templates/devicesView/';
    var dishesViewPath = '/templates/dishesView';
    var modalsViewPath = '/templates/modalsView/';

    var devices = [
        { deviceIndex: 0, isSelected: false },
        { deviceIndex: 1, isSelected: false },
        { deviceIndex: 2, isSelected: false },
        { deviceIndex: 3, isSelected: false },
        { deviceIndex: 4, isSelected: false },
        { deviceIndex: 5, isSelected: false },
        { deviceIndex: 6, isSelected: false },
        { deviceIndex: 7, isSelected: false }
    ];

    app.controller('kitchenOverviewController', function($scope) {
        this.items = [];
        this.selectedItems = [];
        this.filters = new Array();
        this.testingVariable = 0;
        this.selectedTable = -1;

        const numberOfTable = 8;

        for (var i = 0; i < numberOfTable; i++) {
            this.filters.push({ index: i, value: 1, selected: 0 });
        }

        var self = this;

        this.convertDate = function(input) {
            var rawResult = input.match(/T.+Z$/);
            var result = rawResult[0].replace(/^T/, "");
            result = result.replace(/\.\d{3}Z$/, "");

            return result;
        }

        this.reassignItems = function(newItems) {
            self.items = newItems;
        }

        this.reInitKitchen = function(newItems) {
            if (newItems) {
                self.reassignItems(newItems);
            }

            self.selectedItems = [];
            for (var i = 0; i < numberOfTable; i++) {
                self.filters[i].value = 1;
                self.filters[i].selected = 0;
            }

            $scope.$apply();
        }

        this.updateNumberOfSelectedPerTable = function() {
            var temp = new Array();

            for (var i = 0; i < numberOfTable; i++) {
                temp.push(0);
            }

            for (var j = 0; j < self.selectedItems.length; j++) {
                temp[self.getTable(self.selectedItems[j]) - 1]++;
            }

            for (var i = 0; i < numberOfTable; i++) {
                self.filters[i].selected = temp[i];
            }
        }

        this.canSelect = function(id) {
            return this.selectingTable() == -1 ||
                this.selectingTable() == id;
        }

        this.selectingTable = function() {
            return this.numberOfSelected() == 0 ? -1 : this.getTable(this.selectedItems[0]);
        }

        this.getTable = function(id) {
            for (var i = 0; i < self.items.length; i++) {
                if (self.items[i].id == id) {
                    return self.items[i].session.table;
                }
            }
        }

        // This function will be run after the user click Huy~ in the kitchen-overview page
        this.removeOrderedItem = function(e, id) {
            e.stopPropagation();
            self.removeItemById(id);

            //TODO: This code will be run before the server response

            var data = {
                id: id
            }

            io.socket.post('/removeOrderedItem', data, function(result) {
                if (result.status == 0) {
                    failNotify(result.message);
                }
                else {
                    self.items = result.sessionDetails;
                }
            });
            self.updateNumberOfSelectedPerTable();
        }

        // This function will be ran after the user click Giao in the kitchen-overview page
        this.shipOrders = function(url) {

            //TODO: This code will be run before the server response

            console.log(url, self.selectedItems);

            var data = {
                arrSessionDetailId: self.selectedItems,
                trainId: 1
            }

            io.socket.post(url, data, function(result) {
                console.log(result.status)
                if (result.status == 0) {
                    failNotify(result.message);
                }
                else {
                    self.removeSelectedItems();
                    self.reInitKitchen(result.sessionDetails);
                }
            });

            self.updateNumberOfSelectedPerTable();
        }

        this.removeSelectedItems = function() {
            for (var i = self.items.length - 1; i >= 0; i--) {
                if (self.selectedItems.indexOf(self.items[i].id) != -1) {
                    self.items.splice(i, 1);
                }
            }
        }

        this.removeItemById = function(id) {
            for (var i = 0; i < self.items.length; i++) {
                if (self.items[i].id == id) {
                    self.items.splice(i, 1);

                    if (self.selectedItems.indexOf(id) != -1) {
                        self.selectedItems.splice(self.selectedItems.indexOf(id), 1);
                    }
                }
            }
        }

        this.isOn = function(index) {
            return self.filters[index].value == 1;
        }

        this.canShow = function(table) {
            return self.filters[table - 1].value == 1;
        }

        this.numberOfSelected = function() {
            return self.selectedItems.length;
        }

        this.select = function(id) {
            if (!self.isSelected(id)) {
                self.selectedItems.push(id);
            }
            else {
                var index = self.selectedItems.indexOf(id);

                self.selectedItems.splice(index, 1);
            }

            self.updateNumberOfSelectedPerTable();
        }

        this.isSelected = function(id) {
            return self.selectedItems.indexOf(id) != -1;
        }

        this.changeFilterStatus = function(index) {
            self.filters[index].value = !self.filters[index].value;
        }
    });

    app.controller('allDevicesController', function($scope) {
        this.devices = devices;
        this.devicePerRow = 4;
        
        $scope.myFilter = function (item) { 
            return item.table < 100; 
        };
        
        var self = this;
        
        this.imagePath = {
            yellow: "/img/device-status/yellow.png",
            green: "/img/device-status/green.png",
            black: "/img/device-status/black.png"
        };
        
        this.getDeviceImage = function(info) {
            if(info.connecting) {
                if(info.opening) {
                    return self.imagePath.yellow;
                }
                
                return self.imagePath.green;
            }
            
            return self.imagePath.black;
        };

        this.changeStatus = function(index, status) {
            this.devices[index].status = status;
        };

        this.isAnyChecked = function() {
            return countSelection() > 0;
        };

        this.canMerge = function() {
            return countSelection() > 1;
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
                    for (var i = 0; i < devices.length; i++) {
                        if (devices[i].isSelected) {
                            return i;
                        }
                    }

                    return -1;
                };

            },
            controllerAs: 'mergeTable'
        };
    });

    app.directive('myEnter', function() {
        return function(scope, element, attrs) {
            element.bind("keydown keypress", function(event) {
                if (event.which === 13) {
                    scope.$apply(function() {
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
            if (isFirst) {
                self.selectedDish = id;
            }
        }

        this.getFirstSelectedDish = function() {
            if (self.dishes.length == 0) {
                return null;
            }

            // var isDisable = false;
            var isEnable = false;
            var minPriceDisable = self.dishes[0].price;
            var minPriceEnable = self.dishes[0].price;
            var indexDisable = 0;
            var indexEnable = 0;

            for (var i = 0; i < self.dishes.length; i++) {

                if (self.dishes[i].status == 'enable') {
                    isEnable = true;

                    if (self.dishes[i].price < minPriceEnable) {
                        minPriceEnable = self.dishes[i].price;
                        indexEnable = i;
                    }

                } else if (!isEnable) {
                    // isDisable = true;

                    if (self.dishes[i].price < minPriceDisable) {
                        minPriceDisable = self.dishes[i].price;
                        indexDisable = i;
                    }
                }
            }

            if (isEnable) {
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

            for (var i = 0; i < dishes.length; i++) {
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
            $.ajax({
                method: 'POST',
                url: '/dish/addDish',
                data: {
                    dish: dish
                }
            }).done(function(data) {
                finishAdd();

                if (data.status == 0) {
                    $scope.$digest();
                    var message = "Tạo món " + self.dishes[getCurrentDish()].name + " thành công.";
                    successNotify(message);
                }
                else {
                    var message = "Tạo món " + self.dishes[getCurrentDish()].name + " không thành công.";
                    failNotify(message);
                }
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
            if (this.selectedDish == index && this.dirty) {
                return true;
            }

            return false;
        }

        function getImage(id) {
            var currentDish = self.dishes[getCurrentDish()];
            for (var i = 0; i < currentDish.images.length; i++) {
                if (currentDish.images[i].id == id) {
                    return i;
                }
            }
        }

        function delayTimeForDeleting(modal, button) {

            self.deleteCountdown = self.countdownDuration;
            self.counting = true;

            var deleteBtnText = "Xóa ";

            (function myLoop(duration) {
                setTimeout(function() {
                    var textResult = self.deleteCountdown--;
                    if (textResult > 1) {
                        $(button).text(deleteBtnText + (textResult - 1));
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
            for (var i = 0; i < self.dishes.length; i++) {
                dish = self.dishes[i];
                if (dish.id == self.selectedDish) {
                    return i;
                }
            }
        }

        function getCurrentSelect(id) {
            for (var i = 0; i < self.selectOptions.length; i++) {
                select = self.selectOptions[i];
                if (select.id == id) {
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
                if (data.status == 0) {
                    self.dishes[getCurrentDish()].status = 'enable';
                    $scope.$digest();
                    var message = "Enable món " + self.dishes[getCurrentDish()].name + " thành công.";
                    successNotify(message);
                }
                else {
                    var message = "Enable món " + self.dishes[getCurrentDish()].name + " không thành công.";
                    failNotify(message);
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
                if (data.status == 0) {
                    self.dishes[getCurrentDish()].status = 'disable';
                    $scope.$digest();
                    var message = "Disable món " + self.dishes[getCurrentDish()].name + " thành công.";
                    successNotify(message);
                }
                else {
                    var message = "Disable món " + self.dishes[getCurrentDish()].name + " không thành công.";
                    failNotify(message);
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
            }).done(function(data) {
                if (data.status == 0) {
                    var currentName = self.dishes[getCurrentDish()].name;
                    var currentDish = self.dishes[getCurrentDish()];
                    currentDish.images.splice(getImage(id), 1);

                    $scope.$digest();

                    var message = "Xóa hình cho món " + currentName + " thành công.";
                    successNotify(message);
                }
                else {
                    var message = "Xóa hình cho món " + self.dishes[getCurrentDish()].name + " không thành công.";
                    failNotify(message);
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
                if (data.status == 0) {
                    var currentName = self.dishes[getCurrentDish()].name;
                    self.dishes.splice(getCurrentDish(), 1);
                    $scope.$digest();
                    var message = "Xóa món " + currentName + " thành công.";
                    sucessNotify(message);
                }
                else {
                    var message = "Xóa món " + self.dishes[getCurrentDish()].name + " không thành công.";
                    failNotify(message);
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
            if (this.dirty) {
                var currentDish = getCurrentDish();
                $.ajax({
                    method: 'POST',
                    url: '/dish/editDish',
                    data: this.dishes[currentDish]
                }).done(function(data) {
                    if (data.status == 0) {
                        var currentName = self.dishes[getCurrentDish()].name;
                        var message = "Sửa món " + currentName + " thành công.";
                        successNotify(message);
                    }
                    else {
                        var message = "Sửa món " + self.dishes[getCurrentDish()].name + " không thành công.";
                        failNotify(message);
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

    app.service('trainService', function() {
        var selectedItems = ['zxczxczxzxczx'];
        var self = this;

        var addItem = function(item) {
            selectedItems.push(item);
        }

        var removeItem = function(item) {
            selectedItems.remove(item);
        }

        var resetItems = function() {
            selectedItems = [];
        }

        var getItems = function() {
            return self.selectedItems;
        }

        return {
            addItem: addItem,
            removeItem: removeItem,
            resetItems: resetItems,
            selectedItems: getItems,
            testingVar: "TestingVar"
        }
    })

    app.controller('menuController', function($scope, $http, $uibModal, $log, trainService, $rootScope) {
        var self = this;


        $http.get("/categories")
            .then(function(response) {
                self.categories = response.data.categories;

                self.childFries = self.getCategory(self.fixCategory.childFries);

                self.potatoDishes = self.getCategory(self.fixCategory.potatoDishes);
                self.potatoDip = self.getCategory(self.fixCategory.potatoDip);
                self.potatoShake = self.getCategory(self.fixCategory.potatoShake);

                self.potatoDipShake = [];
                self.potatoDipShake.push(self.potatoDip);
                self.potatoDipShake.push(self.potatoShake);

                self.friesDishes = self.getCategory(self.fixCategory.friesDishes);
                self.friesDip = self.getCategory(self.fixCategory.friesDip);

                self.menuWidth = 512;
                self.dishWidth = self.menuWidth / 4;

                self.potatoDishesWidth = self.potatoDishes.dishes.length * self.dishWidth;

                $('html, body').delay(1500).animate({
                    scrollTop: 100
                }, '2000', 'easeOutCubic');
            });


        this.getCategory = function(categoryId) {
            for (var i = 0; i < self.categories.length; i++) {
                if (self.categories[i].id == categoryId) {
                    return self.categories[i];
                }
            }
        }

        this.fixCategory = {
            fries: 1,
            potato: 2,
            potatoDishes: 4,
            potatoDip: 5,
            potatoShake: 6,

            childFries: 3,
            friesDishes: 7,
            friesDip: 8
        }

        this.trainLength = 3;

        this.selectedCategory = self.fixCategory.fries;
        this.selectedSubtab = self.fixCategory.potato;

        this.selectedDish = {
            level1: null,
            level2: null,
            onlyLevel: null
        }

        this.steps = {
            begin: 1,
            dipShake: 2,
            final: 1000
        }

        this.currentStep = self.steps.begin;

        this.resetStep = function() {
            self.currentStep = self.steps.begin;
            self.selectedDish = {
                level1: null,
                level2: null,
                onlyLevel: null
            }
        }

        this.isSelectedDish = function(id) {
            return self.selectedDish.level1 == id;
        }

        this.selectLvl2 = function(level2Id) {
            self.selectedDish.level2 = level2Id;

            var ids = [];

            if (self.selectedDish.level1) {
                ids.push(self.selectedDish.level1);
            }

            if (self.selectedDish.level2) {
                ids.push(self.selectedDish.level2);
            }

            if (self.selectedDish.onlyLevel) {
                ids.push(self.selectedDish.onlyLevel);
            }

            var modalInstance = $uibModal.open({
                animation: true,
                templateUrl: 'myModalContent.html',
                controller: 'ModalInstanceCtrl',
                size: '',
                resolve: {
                    items: function() {
                        var items = [];
                        self.categories.forEach(function(cate) {
                            cate.dishes.forEach(function(cateDish) {
                                var haveMedium = cateDish.otherPrices.some(function(item) {
                                    return item.id == 0;
                                })

                                if (!haveMedium) {
                                    cateDish.otherPrices.push({
                                        name: "Medium",
                                        id: "0",
                                        price: cateDish.price
                                    })
                                }

                                if (self.selectedDish.onlyLevel == cateDish.id) {
                                    items.push({
                                        dish: cateDish,
                                        size: 0,
                                        order: 0,
                                        main: true
                                    })
                                }
                                else {
                                    if (self.selectedDish.level2 == cateDish.id) {
                                        items.push({
                                            dish: cateDish,
                                            size: 0,
                                            order: 1,
                                            main: false
                                        })
                                    }
                                    if (self.selectedDish.level1 == cateDish.id) {
                                        items.push({
                                            dish: cateDish,
                                            size: 0,
                                            order: 0,
                                            main: true
                                        })
                                    }

                                }
                            })
                        })
                        
                        return items;
                    },
                    sessionId: function() {
                        return self.sessionId;
                    }
                }
            });

            modalInstance.result.then(function(selectedItem) {
                $scope.selected = selectedItem;
            }, function() {
                $log.info('Modal dismissed at: ' + new Date());
            });

            var itemsDetails = [];
        }

        this.selectLvl1 = function(level1Id) {
            self.resetStep();
            self.currentStep = self.steps.dipShake;
            self.selectedDish.level1 = level1Id;
        }

        this.selectOneLevel = function(id) {
            var currentItem;

            self.categories.forEach(function(cate) {
                cate.dishes.forEach(function(dish) {
                    if (dish.id == id) {
                        currentItem = dish;
                    }
                })
            });


            self.addDishOnlyLevel(currentItem);
            self.selectedDish.onlyLevel = id;
        }

        this.addStep = function() {
            self.currentStep = self.currentStep == self.steps.final ? self.steps.final : self.currentStep + 1;
        }

        this.removeStep = function() {
            self.currentStep = self.currentStep == self.steps.begin ? self.steps.begin : self.currentStep - 1;
        }

        this.isParent = function(category) {
            return category ? category.parentCategory == null : false;
        }

        this.isSubLevel1 = function(id) {
            return id == self.fixCategory.fries
                || id == self.fixCategory.potato;
        }

        this.isSubLevel2 = function(id) {
            return id == self.fixCategory.childFries ||
                id == self.fixCategory.potatoDishes ||
                id == self.fixCategory.potatoDip ||
                id == self.fixCategory.potatoShake ||
                id == self.fixCategory.friesDishes ||
                id == self.fixCategory.friesDip;
        }

        this.isFries = function() {
            return self.selectedCategory == self.fixCategory.fries;
        }

        this.changeSubtab = function(categoryId) {
            self.selectedSubtab = categoryId;
            self.resetStep();
        }

        this.changeCategory = function(categoryId) {
            self.selectedCategory = categoryId;
            self.resetStep();
        }

        this.showDishes = [];

        this.actualDishes = [];

        // Triggered when recieve broadcast message from the function broadcastRemoveDish() 
        this._removeDish = function(index) {
            self.showDishes.splice(index, 1);
            self.actualDishes.splice(index, 1);
        }
        
        this.removeDish = function(index) {
            self.broadcastRemoveDish(index);
            self._removeDish(index);
        }
        
        this.broadcastRemoveDish = function(index) {
            // broadcast to other devices
        }

        this.fullTrain = function() {
            return self.showDishes.length >= self.trainLength;
        }
        
        //  This function will be triggered when recieve broadcast message 
        //from other devices in the function broadcastAddDish()
        //  Only add the new dish to train, does not broad cast
        this._addDishToTrain = function (showDish, actualDish) {
                self.showDishes.push(showDish);
                self.actualDishes.push(actualDish);
        }
        
        // This function will be triggered when user order a dish
        // Including 2 steps, add dish to train and broadcast message
        this.addDishToTrain = function(showDish, actualDish) {
                self.broadcastAddDish(actualDish);
                self._addDishToTrain(showDish, actualDish);
        }
        
        this.broadcastAddDish = function(dish) {
            // Broadcast to other devices
        }

        // Trigger when user choose dish 1 level
        this.addDishOnlyLevel = function(dish) {
            if (!self.fullTrain()) {

                var showDish = {
                    dish: dish,
                    order: -1,
                    size: 0,
                    main: true
                };

                var actualDish = [showDish];
                
                self.addDishToTrain(showDish, actualDish);
            }
        }
        
        this.submitOrder = function() {
            // Broadcast to other devices
            // Post datas to server
            // Data use to post : self.actualDish
        }

        this.blankCargo = self.trainLength - self.showDishes.length;

        // Trigger when user choose dish with 2 levels
        $scope.$on('addItem', function(response, data) {
            if (!self.fullTrain()) {
                var mainDish;
                data.forEach(function(dish) {
                    if (dish.dish.category == 4 || dish.dish.category == 7) {
                        mainDish = dish;
                    }
                });
                
                var currentDishes = data;
                
                alert("YAAAAAAAAAAAAAAY");
                
                /*$http.post("/addItem", {
                    sessionId: self.sessionId,
                    data: data
                });*/

                var postData = {
                  sessionId: self.sessionId,
                  data: data
                }

                io.socket.post('/addItem', postData, function (result) {
                  if(result.status == 0)
                  {
                    failNotify(result.message);
                  }
                });
            }
            
            this.addItem = function() {
                alert("Adding Item");
            }
            
        });

        this.submitOrder = function() {
            console.log(self.actualDishes);
        }
    });

    app.controller('ModalInstanceCtrl', function($scope, $uibModalInstance, items, sessionId, $sce, trainService, $rootScope, $http) {
        $scope.items = convertItem(items);

        $scope.selectedItem = getFirstDish();

        function getFirstDish() {
            for (var i = 0; i < $scope.items.length; i++) {
                if ($scope.items[i].order == 0) {
                    return $scope.items[i];
                }
            }
        }

        $scope.changeItem = function(id) {
            for (var i = 0; i < $scope.items.length; i++) {
                if ($scope.items[i].dish.id == id) {
                    $scope.selectedItem = $scope.items[i];
                }
            }
        }
        
        var dataToPost = {
            items: items,
            sessionId: sessionId,
            roomName: localStorage.currentTable
        }

        $scope.ok = function() {
            // $rootScope.$broadcast('addItem', $scope.items);
            $http.post('/addItem', dataToPost)
            .then(function success(result) {
                // alert("Testing");
            });
            
            $uibModalInstance.close();
        };

        function convertItem(items) {
            items.forEach(function(item) {
                item.dish.descriptionTrusted = $sce.trustAsHtml(item.dish.description);
            });

            return items;
        }

        $scope.cancel = function() {
            $uibModalInstance.dismiss('cancel');
        };

        $scope.changeSize = function(itemId, sizeId) {
            for (var i = 0; i < items.length; i++) {
                if ($scope.items[i].dish.id == itemId) {
                    $scope.items[i].size = sizeId;
                }
            }
        };

        $scope.isSelectedSize = function(currentSize, compareSize) {
            return currentSize == compareSize;
        };
    });

    var isInDishesManagement = function(view) {
        return view == 'dishesManage';
    };

    var countSelection = function() {
        var number = 0;

        for (var i = 0; i < devices.length; i++) {
            if (devices[i].isSelected) {
                number++;
            }
        }

        return number;
    };
})();
