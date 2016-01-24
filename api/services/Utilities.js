

exports.check = function(len) {
  var buf = []
    , chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
    , charlen = chars.length;

  for (var i = 0; i < len; ++i) {
    buf.push(chars[getRandomInt(0, charlen - 1)]);
  }

  return buf.join('');
};

function isGuest(device) {
	if(!device) {
		return false;
	}

	return device.type == 'guest';
}

function isCashier(device) {
	if(!device) {
		return false;
	}

	return device.type == 'cashier';
}

function isChief(device) {
	if(!device) {
		return false;
	}

	return device.type == 'chief-cook';
}

function isExists(object, objectArray) {
	return objectArray.indexOf(object) != -1 ? true : false;
}

exports.checkRoles = function(context, DeviceIp) {
	var result = {
		authorized: false,
		errorPage: {},
		deviceIp: {}
	}
    
    console.log(context.authorizeRoles);
    
    var res = context.res;
    var req = context.req;
    
	if(!req || !res) {
		return result;
	}
    var ip = req.ip;

    return checkPermission(req, res, DeviceIp, roles);
}

function checkPermission(req, DeviceIp, roles, res) {
    var ip = req.ip;
    ip = ip.substring(ip.lastIndexOf(":")+1, ip.length);

	DeviceIp.findOne({
      ip: ip
    }).populate('device').exec(function (err, deviceIp) {
	  if(err || !deviceIp)
      {
      	return return403(res);
      }
      else if(!isExists(roles,deviceIp.type))
      {
  		return return404(res);
	  }
      
      return deviceIp;
	});
}

function return404(res) {
    return res.view('404', {layout: false});;
}

function return403(res) {
    return res.view('403', {layout: false});;
}