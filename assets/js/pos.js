$( document ).ready(function() {
  // $('#addedItemTable').DataTable();
  if($('#divCashierMenuAlert').length > 0)
  {
    localStorage.setItem("cashierAddedItems", JSON.stringify([]));
  }

  //Calculate change
  $( "#receive" ).keyup(function() {
    var total = $("#total").val();
    var receive = $("#receive").val();
    change = receive - total;
    $("#change").val(change);

    if(change < 0)
    {
      $("#change").addClass("change-warning");
    }
    else
    {
      $("#change").removeClass("change-warning");
    }
  });

  if($('#divReportPage').length > 0)
  {
    $("#dateFrom").val(moment().format("MM/DD/YYYY"));
    $("#dateTo").val(moment().format("MM/DD/YYYY"));
  }
});



/*******************************************************
*
* Socket IO
*
*******************************************************/
io.socket.on('connect', function (status) {
  //TODO: call api update device status
  io.socket.post('/device/connect', function (deviceData) {    
    console.log(deviceData)
    if(deviceData.status == 1)
    {
      successNotify("Thiết bị đã kết nối thành công!");
    }

    //Subscribe to global room named 'pos'
    io.socket.get('/subscribe/pos', function (message) {});

    /*******************************************************
    *
    * Pages
    *
    *******************************************************/
    //Page: Devices or Overview
    if($('#devicesPage').length > 0 || $('#overviewPage').length > 0)
    {
      io.socket.get('/subscribe/device', function (message) {});

      io.socket.on('newDeviceConnected', function (newDeviceConnectedData) {
        var imgSrc;
        if(newDeviceConnectedData.data.opening)
        {
          imgSrc = '/img/device-status/yellow.png';
        }
        else
        {
          imgSrc = '/img/device-status/green.png';
        }
        //Find img tag & change img source
        $("#img-table-"+newDeviceConnectedData.data.table).attr('src', imgSrc);
      });

      io.socket.on('deviceDisconnected', function (deviceDisconnectedData) {
        //Find img tag & change img source
        $("#img-table-"+deviceDisconnectedData.table).attr('src', '/img/device-status/black.png');
      });

      io.socket.on('opened', function (openedData) {
        //Find img tag & change img source
        $("#img-table-"+openedData.table).attr('src', '/img/device-status/yellow.png');
        $("#img-table-"+openedData.table).parent().parent().removeClass('select-device');
        $("#img-table-"+openedData.table).parent().parent().addClass('disabled-table');
      });

      io.socket.on('cancelled', function (cancelledData) {
        $("#img-table-"+cancelledData).attr('src', '/img/device-status/green.png');
        $("#img-table-"+cancelledData).parent().parent().removeClass('disabled-table');
      });      

      io.socket.on('addToDivOpenedTable', function (data) {        
        // $("#divOpenedTable").append(
        //   '<div>' +
        //     '<div style="clear:both"></div>' +
        //     '<label>' +
        //       '<input type="radio" name="rdoOpenedTable" value="'+data.session+'"> Bàn ' + data.table +
        //     '</label>' +
        //   '</div>'
        // );

        var appElement = document.querySelector("#divOpenedTable");
        var $scope = angular.element(appElement).scope();

        $scope.$apply(function() {
          $scope.allDevices.addToDivOpenedTable(data.session, data.table);
        });

        /*$("#divOpenedTable").append(
          '<div>' +
            '<label ng-class="[' +
              '{\'select-device\': closeTableCheckbox'+data.session+'}]" class="label-list ng-binding">' +
              '<div style="display: none;" class="checker">' +
                '<span class="">' +
                  '<input type="checkbox" hidden="" ng-model="closeTableCheckbox'+data.session+'" value="'+data.session+'" name="rdoOpenedTable" class="ng-untouched ng-valid ng-dirty ng-valid-parse ng-empty">' +
                '</span>' +
              '</div> Bàn ' + data.table +
            '</label>' +
          '</div>'
        );*/
      });

      io.socket.on('addOverviewRow', function (openedData) {
        //Added session to page Overview
        $("#overviewOpenedTable").append(
          '<tr id="session'+openedData.session.id+'">' +
            '<td>' +
              openedData.session.table +
            '</td>' +
            '<td>' +
              openedData.session.status +
            '</td>' +
            '<td>' +
              moment(openedData.session.startTime).format("hh:mm:ss a") +
            '</td>' +
          '</tr>'
        );
      });

      io.socket.on('removeOverviewRow', function (sessionId) {
        $("#session"+sessionId).remove();
      });

      io.socket.on('checkout', function (msg) {
        $("#session"+msg.session.id).addClass('pending-checkout');
      });

      //http://www.jqueryscript.net/other/Classic-Growl-like-Notification-Plugin-For-jQuery-Gritter.html
      io.socket.on('receive-message', function (msg) {
        /*$.gritter.add({
          // (string | mandatory) the heading of the notification
          title: 'Bàn ' + msg.table,
          // (string | mandatory) the text inside the notification
          text: msg.message,
          sticky: true,
          fade_out_speed: 100
        });*/
        persistNotify('[Bàn ' + msg.table + '] ' + msg.message);
      });
    }

    //Page: Order Detail
    if($('#sessionDetailPage').length > 0)
    {      
      io.socket.get('/subscribe/device', function (message) {});

      //Call API checkout
      $("#btnCheckout").click(function () {
        var change = $("#change").val();
        if(change < 0)
        {
          failNotify('Vui lòng kiểm tra lại số tiền!');
        }
        else
        {
          var data = {
            sessionId: $("#hdSessionId").val(),
            receive: $("#receive").val(),
            change: change
          }

          io.socket.post('/finalCheckout', data, function (result) {
            if(result.status == 1)
            {
              successNotify(result.message);

              $("#receive").prop('disabled', true);

              //Clear modal footer & add button OK
              $("#modalCheckoutFooter").html('<a href="/ordered/overview" class="btn btn-default">Ok</a>');
            }
            else
            {
              failNotify(result.message);
            }
          });
        }          
      });

      //http://www.jqueryscript.net/other/Classic-Growl-like-Notification-Plugin-For-jQuery-Gritter.html
      io.socket.on('receive-message', function (msg) {
        /*$.gritter.add({
          // (string | mandatory) the heading of the notification
          title: 'Bàn ' + msg.table,
          // (string | mandatory) the text inside the notification
          text: msg.message,
          sticky: true,
          fade_out_speed: 100
        });*/
        persistNotify('[Bàn ' + msg.table + '] ' + msg.message);
      });
    }

    //Page: Kitchen Overview
    if($('#kitchenOverviewPage').length > 0)
    {
      io.socket.get('/subscribe/device', function (message) {});

      io.socket.on('removeKitchenOverview', function (result) {
        // $("#sessionDetail"+result.sessionDetailId).remove();

        var type = result.deliveryType;

        var tableId = '';

        if(type == 'dine-in')
        {
          tableId = '#kitchenOverviewDineInTable';
        }
        else if(type = 'to-go')
        {
          tableId = '#kitchenOverviewToGoTable';
        }

        var appElement = document.querySelector(tableId);
        var $scope = angular.element(appElement).scope();

        $scope.$apply(function() {
          $scope.kitchen.removeItemById(result.sessionDetailId);
        });
      });

      io.socket.on('newOrderAdded', function (result) {
        var sessionDetails = JSON.parse(result.sessionDetails);
        var type = result.type;
        var tableId = '';

        if(type == 'dine-in')
        {
          tableId = '#kitchenOverviewDineInTable';
        }
        else if(type = 'to-go')
        {
          tableId = '#kitchenOverviewToGoTable';
        }

        var appElement = document.querySelector(tableId);
        var $scope = angular.element(appElement).scope();

        $scope.$apply(function() {
          for(var i = 0 ; i < sessionDetails.length; i ++ ) {
            var item = sessionDetails[i];
            $scope.kitchen.items.push(item);
          }
        });

        // for(var i = 0; i < sessionDetails.length; i++)
        // {
        //   var item = sessionDetails[i];
          
        //   var table = $(tableId).DataTable();
        //   var rowNode = table.row.add([
        //     item.id, 
        //     item.session.table, 
        //     item.dish.name,
        //     moment(item.updatedAt).format("hh:mm:ss a"),
        //     '<button class="btn btn-large btn-success" onclick="deliver('+item.id+')">Giao</button> <input type="button" class="btn btn-large btn-danger" onclick="removeOrderedItem('+item.id+')" value="Hủy">'
        //   ]).draw().node();

        //   $(rowNode).addClass('session-'+item.session.id).attr('id', 'sessionDetail'+item.id);
        // }        
      });

      //Listen for event cancel all remaining items
      io.socket.on('cancelAll', function (message) {
        $('.session-'+message.sessionId).remove();
      });

      //Listen for event checkout (Highlight row)
      io.socket.on('checkout', function (message) {
        $(".session-"+message.session.id).addClass('row-warning')
      });
    }

    //Page: Kitchen Dish
    if($('#kitchenDishPage').length > 0)
    {
      io.socket.get('/subscribe/device', function (message) {});

      //Listen for event hide dish
      io.socket.on('hideDish', function (message) {
        $("#itemStatus"+message.dishId).text(message.message)
        $("#itemAction"+message.dishId).html('<button class="btn btn-large btn-success" onclick="showDish('+message.dishId+')">Hiện</button>');
      });

      //Listen for event show dish
      io.socket.on('showDish', function (message) {        
        $("#itemStatus"+message.dishId).text(message.message)
        $("#itemAction"+message.dishId).html('<button class="btn btn-large btn-danger" onclick="hideDish('+message.dishId+')">Ẩn</button>');
      });
    }    

    //Page: Dishes
    if($('#divDishPageAlert').length > 0)
    {
      //Subscribe to room table (All table will subscribe to this room)
      io.socket.get('/subscribe/table', function (message) {console.log("table")});

      //Subscribe to original room table
      io.socket.get('/subscribe/table'+deviceData.data.table, function (message) {
        //Save originalTable (field table in Device) to localStorage
        localStorage.originalTable = deviceData.data.table;     
      });

      //Subscribe to current room table (Necessary for reloading page)
      io.socket.get('/subscribe/table'+localStorage.currentTable, function (message) {});

      //Listen for event open table
      io.socket.on('opened', function (message) {
        //Single table (not merged to any others) => currentTable will be original table
        localStorage.currentTable = deviceData.data.table;

        //Store current session id in localStorage
        localStorage.sessionId = message.sessionId;

        /*$("#divDishPageAlert").prepend('<div class="alert alert-success">' +
                                      '<button type="button" class="close" data-dismiss="alert">×</button>' +
                                      message.message +
                                    '</div>');*/   
        reload();     
      });


      //Listen for event merge table
      io.socket.on('merged', function (mergedMessage) {
        io.socket.get('/subscribe/'+mergedMessage.room, function (message) {
          //Table is merged => currentTable will be the return value from API
          localStorage.currentTable = mergedMessage.table;

          //Store current session id in localStorage
          localStorage.sessionId = mergedMessage.sessionId;

          /*$('#divDishPageAlert').prepend('<div class="alert alert-success">' +
                                        '<button type="button" class="close" data-dismiss="alert">×</button>' +
                                        mergedMessage.message +
                                      '</div>');*/
        });
        reload();
      });

      //Listen for event cancel table
      io.socket.on('cancelled', function (message) {
        if(localStorage.originalTable != message)
        {
          io.socket.get('/unsubscribe/table'+localStorage.message, function (message) {});
          reload();
        }
      });

      //Listen for event paid
      io.socket.on('paid', function (message) {
        if(localStorage.originalTable != message)
        {
          io.socket.get('/unsubscribe/table'+localStorage.message, function (message) {});
          redirect('/');
        }
      });

      //Listen for event add item
      io.socket.on('addItem', function (message) {
        var appElement = document.querySelector('#menuPage');
        var $scope = angular.element(appElement).scope();

        $scope.$apply(function() {
          $scope.menu.reloadTrain();
        });
      });

      //Listen for event remove item
      io.socket.on('removeItem', function (message) {
        var appElement = document.querySelector('#menuPage');
        var $scope = angular.element(appElement).scope();

        $scope.$apply(function() {
          $scope.menu.reloadTrain();
        });
      });

      //Listen for event order item
      io.socket.on('ordered', function (message) {        
        redirect(message.msg);
      });

      io.socket.on('item-delivered', function (msg) {
        /*$.gritter.add({
          // (string | mandatory) the heading of the notification
          title: 'Món ' + msg.dishName,
          // (string | mandatory) the text inside the notification
          text: msg.message,
          sticky: true,
          fade_out_speed: 100
        });*/
        if(msg.type == 1)
        {
          successNotify('Món ' + msg.dishName + ': ' + msg.message);
        }
        else
        {
          failNotify('Món ' + msg.dishName + ': ' + msg.message);
        }
      });

      //Listen for event hide dish
      io.socket.on('hideDish', function (message) {
        console.log("hide")
        $("#item"+message.dishId).hide();
      });

      //Listen for event show dish
      io.socket.on('showDish', function (message) {
        $("#item"+message.dishId).show();
      });

      //Listen for event block table
      io.socket.on('blockTable', function (message) {
        $("#modalBlockTableBodyAlert").text(message.msg);
        $('#modalBlockTable').modal('show');
      });

      //Listen for event unblock table
      io.socket.on('unblockTable', function (message) {
        $('#modalBlockTable').modal('hide');
      });
    }

    //Page: Ordered
    if($('#orderedPage').length > 0)
    {
      //Subscribe to room table (All table will subscribe to this room)
      io.socket.get('/subscribe/table', function (message) {});

      //Subscribe to original room table
      io.socket.get('/subscribe/table'+deviceData.data.table, function (message) {
        //Save originalTable (field table in Device) to localStorage
        localStorage.originalTable = deviceData.data.table;     
      });

      //Subscribe to current room table (Necessary for reloading page)
      io.socket.get('/subscribe/table'+localStorage.currentTable, function (message) {});

      //Listen for event open table
      io.socket.on('opened', function (message) {
        //Single table (not merged to any others) => currentTable will be original table
        localStorage.currentTable = deviceData.data.table;

        //Store current session id in localStorage
        localStorage.sessionId = message.sessionId;

        /*$("#divDishPageAlert").prepend('<div class="alert alert-success">' +
                                      '<button type="button" class="close" data-dismiss="alert">×</button>' +
                                      message.message +
                                    '</div>');*/   
        redirect('/');
      });

      //Listen for event merge table
      io.socket.on('merged', function (mergedMessage) {
        io.socket.get('/subscribe/'+mergedMessage.room, function (message) {
          //Table is merged => currentTable will be the return value from API
          localStorage.currentTable = mergedMessage.table;

          //Store current session id in localStorage
          localStorage.sessionId = mergedMessage.sessionId;

          /*$('#divDishPageAlert').prepend('<div class="alert alert-success">' +
                                        '<button type="button" class="close" data-dismiss="alert">×</button>' +
                                        mergedMessage.message +
                                      '</div>');*/
        });
        redirect('/');
      });

      //Listen for event cancel table
      io.socket.on('cancelled', function (message) {
        if(localStorage.originalTable != message)
        {
          io.socket.get('/unsubscribe/table'+localStorage.message, function (message) {});
          redirect('/');
        }
      });

      //Listen for event paid
      io.socket.on('paid', function (message) {
        if(localStorage.originalTable != message)
        {
          io.socket.get('/unsubscribe/table'+localStorage.message, function (message) {});
          redirect('/');
        }
      });
      

      //Listen for event order item
      io.socket.on('ordered', function (message) {        
        reload();
      });

      io.socket.on('item-delivered', function (msg) {
        /*$.gritter.add({
          // (string | mandatory) the heading of the notification
          title: 'Món ' + msg.dishName,
          // (string | mandatory) the text inside the notification
          text: msg.message,
          sticky: true,
          fade_out_speed: 100
        });*/

        if(msg.type == 1)
        {
          successNotify('Món ' + msg.dishName + ': ' + msg.message);
        }
        else
        {
          failNotify('Món ' + msg.dishName + ': ' + msg.message);
        }

        // $("#tdSessionDetail"+msg.sessionDetailId).html('<div class="item-status">' + msg.message + '</div>');
      });

      io.socket.on('removeOrderedItem', function (result) {  
        $.gritter.add({
          // (string | mandatory) the heading of the notification
          title: 'Món ' + msg.dishName,
          // (string | mandatory) the text inside the notification
          text: msg.message,
          sticky: true,
          fade_out_speed: 100
        });

        // $("#tdSessionDetail"+result.sessionDetailId).html('<div class="item-status">' + msg.message + '</div>');
      });

      //Listen for event block table
      io.socket.on('blockTable', function (message) {
        $("#modalBlockTableBodyAlert").text(message.msg);
        $('#modalBlockTable').modal('show');
      });

      //Listen for event unblock table
      io.socket.on('unblockTable', function (message) {
        $('#modalBlockTable').modal('hide');
      });

      //Listen for event checkout
      io.socket.on('checkout', function (message) {
        persistNotify(message.msg);
      });
    }
  });
});



io.socket.on('chat', function (data) {
  console.log(data);
  $("#divChatContent").append(data.msg);
});




/*******************************************************
*
* Custom Function
*
*******************************************************/
function addItem (id, name) {
  var data = {
    roomName: 'table'+localStorage.currentTable,
    eventName: 'addItem',
    data: {
      id: id,
      sessionId: localStorage.sessionId,
      name: name,
      table: localStorage.currentTable
    }
  }

  io.socket.post('/addItem', data, function (result) {
    if(result.status == 0)
    {
      failNotify(result.message);
    }
  });
}

function removeItem (id) {
  var data = {
    roomName: 'table'+localStorage.currentTable,
    eventName: 'removeItem',
    data: {
      id: id,
      sessionId: localStorage.sessionId,
      table: localStorage.currentTable
    }
  }

  io.socket.post('/removeItem', data, function (result) {
    if(result.status == 0)
    {
      failNotify(result.message);
    }
  });
};

function removeOrderedItem (id) {
  var data = {
    id: id
  }

  io.socket.post('/removeOrderedItem', data, function (result) {
    if(result.status == 0)
    {
      failNotify(result.message);
    }
  });
};

function order (sessionId) 
{
  var data = {
    sessionId: sessionId
  }

  io.socket.post('/order', data, function (result) {
    if(result.status == 0)
    {
      failNotify(result.message);
    }
    else {
      successNotify("Đặt món thành công");
    }
  });
}

function checkout (sessionId) 
{
  startCountdown('btnCheckout', 60);

  var data = {
    sessionId: sessionId
  }

  io.socket.post('/checkout', data, function (result) {
    if(result.status == 0)
    {
      failNotify(result.message);
    }
  });
}

function deliver (sessionDetailId) 
{
  var data = {
    sessionDetailId: sessionDetailId
  }

  io.socket.post('/deliver', data, function (result) {
    if(result.status == 0)
    {
      failNotify(result.message);
    }
    else {
      // successNotify("")
      //TODO: Deliver món thành công
    }
  });
}

function hideDish (dishId) {
  var data = {
    id: dishId
  }

  io.socket.post('/hideDish', data, function (result) {
    if(result.status == 0)
    {
      failNotify(result.message);
    }
  });
};

function showDish (dishId) {
  var data = {
    id: dishId
  }

  io.socket.post('/showDish', data, function (result) {
    if(result.status == 0)
    {
      failNotify(result.message);
    }
  });
};

//Block Table
function blockTable (table) {
  var data = {
    table: table
  }

  io.socket.post('/blockTable', data, function (result) {
    //Do nothing because backend's broadcasted to all table
  });
};

//Unblock Table
function unblockTable (table) {
  var data = {
    table: table
  }

  io.socket.post('/unblockTable', data, function (result) {
    //Do nothing because backend's broadcasted to all table
  });
};

function mergeAndOpenTable (argument) 
{
  var arrSelectedTable = [];
  $("input:checkbox[name=chkSelectTable]:checked").each(function(){
      arrSelectedTable.push($(this).val());
  });

  var selectedMergeTable = $('input[name=rdoMergeTable]:checked').val();
  io.socket.post('/table/openAndOpen', {
                                        arrSelectedTable: JSON.stringify(arrSelectedTable), 
                                        selectedMergeTable: selectedMergeTable
  }, function (data) {
    if(data.status == 1) //Success
    {
      //Uncheck & disable all checkbox
      $("input:checkbox[name=chkSelectTable]:checked").each(function(){
        $(this).prop('checked', false);
        $(this).prop('disabled', true);
        $.uniform.update();
      });
      
      successNotify(data.message);
    }
    else //Fail
    {
      failNotify(data.message);
    }
    $('#mergeTableModal').modal('hide');
  });
}

function cancelAll (sessionId) {
  var data = {
    sessionId: sessionId
  }

  io.socket.post('/cancelAll', data, function (result) {
    if(result.status == 1)
    {
      successNotify(result.message);

      //Remove all remaining item
      // $("#remainingItems").remove();
      reload();
    }
    else
    {
      failNotify(result.message);
    }
  });
};

function cashierAddItem (id, name, price, size) 
{
  //Get variable cashierAddedItems from localStorage
  var cashierAddedItems = localStorage.getItem("cashierAddedItems");
  cashierAddedItems = JSON.parse(cashierAddedItems);

  var newItem = {
    [id]: {
      id: id,
      quantity: 1,
      price: price,
      size: size
    }
  };

  //Push it to cashierAddedItems
  cashierAddedItems.push(newItem);

  //Store it in localStorage again
  localStorage.setItem("cashierAddedItems", JSON.stringify(cashierAddedItems));

  //Calculate total
  var total = 0;
  for(var i = 0; i < cashierAddedItems.length; i++)
  {
    var items = cashierAddedItems[i];
    for(var value in items)
    {
      var item = items[value];
      total += (item.quantity * item.price);
    }
  }
  localStorage.setItem("cashierAddedItemsTotalPrice", total);
  
  
  $('.btnDish'+id).attr('disabled', true);
  $('#cashierMenuPageTableBody').append(
    '<tr>' +
      '<td>' + name + '</td>' +      
      '<td>' + price + '</td>' +
      '<td><input type="number" class="input-quantity" item-id="'+id+'" price="'+price+'" size="'+size+'" value="1"></td>' +
      '<td>' + price + '</td>' +
      '<td>' + size + '</td>' +
      '<td><button class="btn btn-large btn-danger" onclick="cashierRemoveAddedItem(this, '+id+')">Hủy</button></td>' +
    '</tr>'
  );

  //Set total to table footer
  setTotalAddedItem();
}

function cashierRemoveAddedItem (element, itemId) 
{
  $(element).parent().parent().remove();
  $('.btnDish' + itemId).attr('disabled', false);

  //Set total to table footer
  setTotalAddedItem();
}

function cashierCheckout () 
{
  var change = $("#change").val();
  if(change < 0)
  {
    failNotify('Vui lòng kiểm tra lại số tiền!');
  }
  else
  {
    var trs = $('#cashierMenuPageTableBody > tr');
    var items = [];
    var total = 0;
    for(var i = 0; i < trs.length; i++)
    {
      var tr = trs[i];
      var inputQuantity = $(tr).children().eq(2).children().first();
      var quantity = inputQuantity.val();
      var id = inputQuantity.attr('item-id');
      var price = inputQuantity.attr('price');
      var size = inputQuantity.attr('size');

      total += (quantity * price);

      for(var j = 0; j < quantity;  j++)
      {
        items.push({
          id: id,
          price: price,
          size: size 
        });
      }
    }

    if(parseInt($('#total').val()) !== total)
    {
      failNotify('Vui lòng kiểm tra lại số tiền!');
    }
    else
    {
      var data = {
        data: items,
        total: $('#total').val(),
        receive: $('#receive').val(),
        change: $('#change').val()
      }
      
      io.socket.post('/cashier/order', data, function (result) {
        if(result.status == 1)
        {
          successNotify(result.message);
          resetModalCashierCheckout();
          resetBtnDish();
          reload();
        }
        else
        {
          failNotify(result.message);
        }
      });
    }
  }
}

function resetModalCashierCheckout () {
  $('#total').val("");
  $('#receive').val("");
  $('#change').val("");
}

function resetBtnDish () {
  $('.btnDish').attr('disabled', false);
}

function setTotalAddedItem () 
{
  var total = 0;

  //Find all tr of cashierMenuPageTableBody
  var trs = $('#cashierMenuPageTableBody > tr');
  for(var i = 0; i < trs.length; i++)
  {
    var tr = trs[i];

    //Get amount of each row (cot Thanh tien)
    var amount = $(tr).children().eq(3).text();

    //Add it to total
    total += parseInt(amount);
  }

  //Set total to table footer
  $('#thTotal').text(total);

  //Set total to input total in modal checkout
  $('#total').attr('value', total);
}

function fastDelivery () 
{
  var selectedTable = $( "input[name=fast-delivery]:checked" ).val();
  var data = {
    table: selectedTable
  }

  io.socket.post('/kitchen/fastDelivery', data, function (result) {
    console.log(result)
    if(result.status == 0)
    {
      failNotify(result.message);
    }
    else
    {
      successNotify(result.message);
    }
  });
}

function getReport () {
  var dateFrom = $("#dateFrom").val();
  var dateTo = $("#dateTo").val();
  var data = {
    dateFrom: dateFrom,
    dateTo: dateTo
  }

  io.socket.post('/kitchen/report', data, function (result) {    
    if(result.status == 1)
    {      
      var reportBody = '';
      var sessions = result.sessions
      for(var i = 0; i < sessions.length; i++)
      {        
        reportBody += '<tr><td>' + 
                        moment(sessions[i].createdAt).format("DD/MM/YYYY") +
                      '</td>' + 
                      '<td>' + 
                        sessions[i].total +
                      '</td></tr>';
      }     
      $("#reportBody").html(reportBody);
    }
  });
}

function smoothScrollToBottom() {
  $('html, body').animate({
    scrollTop: 500
  }, '1000');
}

function reload () 
{
  location.reload();
}

function redirect (url) 
{
  window.location.replace(url);
}

/*******************************************************
*
* Button Click
*
*******************************************************/
$("#subscribe").click(function (event) {
  var roomName = $("#roomName").val();
  $("#hdRoomName").val(roomName);
  io.socket.get('/subscribe/'+roomName, function (data) {
    $("#divSubscribe").remove();
    $("#lbMessage").text(data.message);
    $("#divChat").show();
  });

  io.socket.get('/subscribe/auto', function (data) {
  });
});

$("#btnSubscribe").click(function (event) {
  var message = $("#txtChat").val();
  var roomName = $("#hdRoomName").val();
  
  var data = {
    roomName: roomName,
    message: message
  }

  io.socket.post('/broadcast', data, function (data) {
    console.log(data)
  });
});

$("#btnOpenTable").click(function (event) {
  $("input:checkbox[name=chkSelectTable]:checked").each(function(){
    var _this = $(this);
    io.socket.post('/table/open', {id: $(this).val()}, function (data) {
      if(data.status == 1) //Success
      {
        //Uncheck all checkbox
        $(_this).prop('checked', false);
        $(_this).prop('disabled', true);
        $.uniform.update();

        successNotify(data.message);
      }
      else //Fail
      {
        failNotify(data.message);
      }
      
    });
  });
});

//Close table
$("#confirmCloseTableModal").click(function (event) {
  var selectedTable = $("input[name='rdoOpenedTable']:checked").val();
  io.socket.post('/cancelTable', {sessionId: selectedTable}, function (data) {
    if(data.status == 1)
    {
      $("input[name='rdoOpenedTable']:checked").parent().parent().parent().parent().remove();
      // reload();
    }
    else
    {
      failNotify(data.message);
    }
  });
});

$("#btnFullScreen").click(function (event) {
  var html = document.documentElement;
  html.webkitRequestFullScreen();
});

$(document).on('change', '.input-quantity', function() {
  var amount = 0;
  if($(this).val() < 0)
  {
    $(this).val(0);
  }
  else
  {
    amount = $(this).val() * $(this).attr("price");
  }
  
  //Calculate amount of the current row
  $(this).parent().parent().children().eq(3).text(amount);

  //Set total to table footer
  setTotalAddedItem();
});

// $('.category').click(function (event) {
//   console.log(this);
//   $('.category').removeClass('active');
//   $(this).addClass('active');
// })






/*******************************************************
*
* Form Submit
*
*******************************************************/