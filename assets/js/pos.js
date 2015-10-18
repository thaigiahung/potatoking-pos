$( document ).ready(function() {
  
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
    if($('#divActiveDevice').length > 0)
    {
      io.socket.get('/subscribe/device', function (message) {
        console.log("Subscribed to device");
      });

      io.socket.on('newDeviceConnected', function (newDeviceConnectedData) {
        if(newDeviceConnectedData.status == 0)
        {
          $("#divUnauthorisedDevice").append(newDeviceConnectedData.ip + "<br>");  
        }
        else
        {
          if(newDeviceConnectedData.data.status == 'enable')
          {
            if($("#table"+newDeviceConnectedData.data.table).length == 0)
            {
              $("#divActiveDevice").append('<input type="checkbox" id="table'+newDeviceConnectedData.data.table+'" value="'+newDeviceConnectedData.data.table+'"> Bàn '+newDeviceConnectedData.data.table);
            }        
          }
          else
          {
            $("#divInactiveDevice").append(newDeviceConnectedData.ip + "<br>");
          }
        }    
      });
    }
    //Page: Dishes
    if($('#dishesPage').length > 0)
    {      
      //Subscribe to room table
      io.socket.get('/subscribe/table'+deviceData.data.table, function (message) {
        console.log("Subscribed to room table"+deviceData.data.table);
      });

      //Listen for event open table
      io.socket.on('opened', function (message) {
        console.log(message);
        $("#divDishPageAlert").append('<div class="alert alert-success">' +
                                      '<button type="button" class="close" data-dismiss="alert">×</button>' +
                                      message.message +
                                    '</div>')
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
});

$("#btnOpenTable").click(function (event) {
  $("input:checkbox[name=chkSelectTable]:checked").each(function(){
    io.socket.post('/table/open', {id: $(this).val()}, function (data) {
      if(data.status == 1) //Success
      {
        $("#divDeviceListAlert").append('<div class="alert alert-success">' +
                                        '<button type="button" class="close" data-dismiss="alert">×</button>' + data.message +
                                        '</div>')
      }
      else //Fail
      {
        $("#divDeviceListAlert").append('<div class="alert alert-error">' +
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