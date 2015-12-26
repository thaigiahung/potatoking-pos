$( document ).ready(function() {
  // $('#addedItemTable').DataTable();  
});



/*******************************************************
*
* Socket IO
*
*******************************************************/
io.socket.on('connect', function () {
  //TODO: call api update device status
  io.socket.post('/device/connect', function (deviceData) {    
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
        var img = $("#table"+newDeviceConnectedData.data.table).parent().parent().parent().children("img").eq(0);
        img.attr('src', imgSrc);
      });

      io.socket.on('deviceDisconnected', function (deviceDisconnectedData) {
        //Find img tag & change img source
        var img = $("#table"+deviceDisconnectedData.table).parent().parent().parent().children("img").eq(0);
        img.attr('src','/img/device-status/black.png');
      });

      io.socket.on('opened', function (openedData) {
        //Find img tag & change img source
        var img = $("#table"+openedData.table).parent().parent().parent().children("img").eq(0);
        img.attr('src','/img/device-status/yellow.png');
      });

      io.socket.on('cancelled', function (cancelledData) {
        $("#table"+cancelledData).prop('disabled', false);
        $.uniform.update();
        //Find img tag & change img source
        var img = $("#table"+cancelledData).parent().parent().parent().children("img").eq(0);
        img.attr('src','/img/device-status/green.png');
      });      

      io.socket.on('addToDivOpenedTable', function (data) {        
        $("#divOpenedTable").append(
          '<div>' +
            '<div style="clear:both"></div>' +
            '<label>' +
              '<input type="radio" name="rdoOpenedTable" value="'+data.session+'"> Bàn ' + data.table +
            '</label>' +
          '</div>'
        );
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
              moment(openedData.session.startTime).format("DD/MM/YYYY hh:mm:ss a") +
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
        $.gritter.add({
          // (string | mandatory) the heading of the notification
          title: 'Bàn ' + msg.table,
          // (string | mandatory) the text inside the notification
          text: msg.message,
          sticky: true,
          fade_out_speed: 100
        });
      });
    }

    //Page: Kitchen Overview
    if($('#kitchenOverviewPage').length > 0)
    {
      io.socket.get('/subscribe/device', function (message) {});

      io.socket.on('removeKitchenOverview', function (result) {
        $("#sessionDetail"+result.sessionDetailId).remove();
      });
    }

    //Page: Dishes
    if($('#dishesPage').length > 0)
    {      
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

      //Listen for event add item
      io.socket.on('addItem', function (message) {
        $('#addedItemTableBody').prepend(
          '<tr class="dish' + message.msg.sessionDetail.dish + '">' +
            '<td>' +
              message.msg.name +
            '</td>' +
            '<td>' +
              '<input type="button" onclick="removeItem('+message.msg.sessionDetail.id+')" value="Xóa"' +
            '</td>' +
          '</tr>'
        );
      });

      //Listen for event remove item
      io.socket.on('removeItem', function (message) {
        var firstTR = $(".dish"+message.msg.sessionDetail.dish.id).first();
        if(firstTR.length > 0)
        {
          firstTR.remove();
        }
      });

      //Listen for event order item
      io.socket.on('ordered', function (message) {        
        redirect(message.msg);
      });

      io.socket.on('item-delivered', function (msg) {
        $.gritter.add({
          // (string | mandatory) the heading of the notification
          title: 'Món ' + msg.dishName,
          // (string | mandatory) the text inside the notification
          text: msg.message,
          sticky: true,
          fade_out_speed: 100
        });
      });
    }

    //Page: Ordered
    if($('#orderedPage').length > 0)
    {      
      //Subscribe to original room table
      io.socket.get('/subscribe/table'+deviceData.data.table, function (message) {
        //Save originalTable (field table in Device) to localStorage
        localStorage.originalTable = deviceData.data.table;     
      });

      //Subscribe to current room table (Necessary for reloading page)
      io.socket.get('/subscribe/table'+localStorage.currentTable, function (message) {});

      //Listen for event cancel table
      io.socket.on('cancelled', function (message) {
        if(localStorage.originalTable != message)
        {
          io.socket.get('/unsubscribe/table'+localStorage.message, function (message) {});
          redirect('/');
        }
      });

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

      //Listen for event order item
      io.socket.on('ordered', function (message) {        
        reload();
      });

      io.socket.on('item-delivered', function (msg) {
        $.gritter.add({
          // (string | mandatory) the heading of the notification
          title: 'Món ' + msg.dishName,
          // (string | mandatory) the text inside the notification
          text: msg.message,
          sticky: true,
          fade_out_speed: 100
        });

        $("#tdSessionDetail"+msg.sessionDetailId).text(msg.message);
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
      $("#divDishPageAlert").prepend('<div class="alert alert-error">' +
                                      '<button type="button" class="close" data-dismiss="alert">×</button>' +
                                      result.message +
                                    '</div>');
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
      $("#divDishPageAlert").prepend('<div class="alert alert-error">' +
                                      '<button type="button" class="close" data-dismiss="alert">×</button>' +
                                      result.message +
                                    '</div>');
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
      $("#divDishPageAlert").prepend('<div class="alert alert-error">' +
                                      '<button type="button" class="close" data-dismiss="alert">×</button>' +
                                      result.message +
                                    '</div>');
    }
  });
}

function checkout (sessionId) 
{
  var data = {
    sessionId: sessionId
  }

  io.socket.post('/checkout', data, function (result) {
    if(result.status == 1)
    {
      $("#divOrderedPageAlert").prepend('<div class="alert alert-success">' +
                                      '<button type="button" class="close" data-dismiss="alert">×</button>' + result.message +
                                      '</div>')
    }
    else
    {
      $("#divOrderedPageAlert").prepend('<div class="alert alert-error">' +
                                      '<button type="button" class="close" data-dismiss="alert">×</button>' +
                                      result.message +
                                    '</div>');
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
      $("#divKitchenOverviewPageAlert").prepend('<div class="alert alert-error">' +
                                      '<button type="button" class="close" data-dismiss="alert">×</button>' +
                                      result.message +
                                    '</div>');
    }
  });
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

$("#btnMergeAndOpenTable").click(function (event) {
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
      

      //TODO: update style      
      $("#divDeviceListAlert").prepend('<div class="alert alert-success">' +
                                      '<button type="button" class="close" data-dismiss="alert">×</button>' + data.message +
                                      '</div>')
    }
    else //Fail
    {
      $("#divDeviceListAlert").prepend('<div class="alert alert-error">' +
                                      '<button type="button" class="close" data-dismiss="alert">×</button>' + data.message +
                                      '</div>')
    }
    $('#mergeTableModal').modal('hide');
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

        //TODO: update style
        $("#divDeviceListAlert").prepend('<div class="alert alert-success">' +
                                        '<button type="button" class="close" data-dismiss="alert">×</button>' + data.message +
                                        '</div>')
      }
      else //Fail
      {
        $("#divDeviceListAlert").prepend('<div class="alert alert-error">' +
                                        '<button type="button" class="close" data-dismiss="alert">×</button>' + data.message +
                                        '</div>')
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
      $("input[name='rdoOpenedTable']:checked").parent().remove();
    }
    else
    {
      $("#divOpenedTable").prepend('<div class="alert alert-error">' +
                                      '<button type="button" class="close" data-dismiss="alert">×</button>' + data.message +
                                      '</div>');
    }
  });
});









/*******************************************************
*
* Form Submit
*
*******************************************************/