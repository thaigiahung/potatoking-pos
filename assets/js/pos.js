$( document ).ready(function() {
  
});
io.socket.on('connect', function () {
  console.log("Connected");
  //TODO: call api update device status
  io.socket.post('/device/connect', function (data) {
    console.log(data);
  });
});

io.socket.get('/subscribe/pos', function (data) {
  console.log("Subscribed to pos");
});

io.socket.on('chat', function (data) {
  console.log(data);
  $("#divChatContent").append(data.msg);
});

io.socket.on('newDeviceConnected', function (data) {
  console.log(data);
  $("#divDeviceList").append(data.ip + "<br>");
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












/*******************************************************
*
* Form Submit
*
*******************************************************/