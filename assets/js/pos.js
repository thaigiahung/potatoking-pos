$( document ).ready(function() {
  
});
io.socket.on('connect', function socketConnected() {
  console.log("Connected");
  //TODO: call api update device status
});

io.socket.on('chat', function onServerSentEvent (data) {
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