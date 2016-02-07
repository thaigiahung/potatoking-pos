var counting = false;
var countdownDuration = 3;
var autoHideNotifyPosition = 'top left';
var notifyPosition = 'top right';

function beginCountdown(target) {
	var counting = true;

	var targetText = $('#'+target).text() + ' ';

	var deleteBtnText = "Xóa ";

	(function myLoop (duration) {          
	   setTimeout(function () {  
	   	  var textResult = countdownDuration--;
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
	})(countdownDuration);

	  	$(button).text(deleteBtnText + self.deleteCountdown);
	$(button).attr('disabled', 'disabled');
	$(modal).modal('show');
}

function successNotify(message) {
	$.notify(message, { 
		position: autoHideNotifyPosition, 
		className: 'success' 
	});
}

var failNotify = function(message) {
	$.notify( message, { 
		position: autoHideNotifyPosition, 
		className: 'error' 
	});
}

var errorNotify = function(message) {
	$.notify( message, {
		position: notifyPosition,
		className: 'error',
		autoHide: false
	});
}
