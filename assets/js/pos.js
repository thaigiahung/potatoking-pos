$( document ).ready(function() {
  // $('#addedItemTable').DataTable();
});



/*******************************************************
*
* Socket IO
*
*******************************************************/
io.socket.on('connect', function () {
  console.log("Connected");
  //TODO: call api update device status
  io.socket.post('/device/connect', function (deviceData) {    
    //Subscribe to global room named 'pos'
    io.socket.get('/subscribe/pos', function (message) {
      console.log("Subscribed to pos");
    });

    /*******************************************************
    *
    * Pages
    *
    *******************************************************/
    //Page: Devices
    if($('#devicesPage').length > 0)
    {
      io.socket.get('/subscribe/device', function (message) {
        console.log("Subscribed to device");
      });

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
    }

    //Page: Dishes
    if($('#dishesPage').length > 0)
    {      
      //Subscribe to room table
      io.socket.get('/subscribe/table'+deviceData.data.table, function (message) {
        //Save originalTable (field table in Device) to localStorage
        localStorage.originalTable = deviceData.data.table;
        console.log("Subscribed to room table"+deviceData.data.table);        
      });

      //Listen for event open table
      io.socket.on('opened', function (message) {
        console.log(message)
        //Single table (not merged to any others) => currentTable will be original table
        localStorage.currentTable = deviceData.data.table;

        //Store current session id in localStorage
        localStorage.sessionId = message.sessionId;

        $("#divDishPageAlert").prepend('<div class="alert alert-success">' +
                                      '<button type="button" class="close" data-dismiss="alert">×</button>' +
                                      message.message +
                                    '</div>');
      });

      //Listen for event merge table
      io.socket.on('merged', function (mergedMessage) {
        io.socket.get('/subscribe/'+mergedMessage.room, function (message) {
          //Table is merged => currentTable will be the return value from API
          localStorage.currentTable = mergedMessage.table;

          //Store current session id in localStorage
          localStorage.sessionId = mergedMessage.sessionId;

          $('#divDishPageAlert').prepend('<div class="alert alert-success">' +
                                        '<button type="button" class="close" data-dismiss="alert">×</button>' +
                                        mergedMessage.message +
                                      '</div>');
        });
      });

      //Listen for event add item
      io.socket.on('addItem', function (message) {
        console.log(message);
        $('#addedItemTableBody').prepend(
          '<tr>' +
            '<td>' +
              message.msg.name +
            '</td>' +
            '<td>' +
              '<input type="button" onclick="removeItem('+message.msg.sessionDetailId+')" value="Xóa"' +
            '</td>' +
          '</tr>'
        );
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
  console.log(id);
  console.log(name);
  console.log(localStorage.currentTable);
  console.log(localStorage.sessionId);
  

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
    console.log(result)
    if(result.status == 0)
    {
      $("#divDishPageAlert").prepend('<div class="alert alert-error">' +
                                      '<button type="button" class="close" data-dismiss="alert">×</button>' +
                                      result.message +
                                    '</div>');
    }
  });
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
  console.log(arrSelectedTable);
  console.log(selectedMergeTable);
  io.socket.post('/table/openAndOpen', {
                                        arrSelectedTable: JSON.stringify(arrSelectedTable), 
                                        selectedMergeTable: selectedMergeTable
  }, function (data) {
    if(data.status == 1) //Success
    {
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
    io.socket.post('/table/open', {id: $(this).val()}, function (data) {
      if(data.status == 1) //Success
      {
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











/*******************************************************
*
* Form Submit
*
*******************************************************/