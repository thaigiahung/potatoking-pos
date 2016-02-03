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
	return objectArray.indexOf(object) != -1;
}

exports.apply = function(context, callback) {
    var res = context.res;
    var req = context.req;
    var deviceIp = context.deviceIp;
    var roles = context.authorizeRoles;
    
    var ip = req.ip;
    ip = ip.substring(ip.lastIndexOf(":")+1, ip.length);
    
    console.log("Device Ip : " + ip);

	DeviceIp.findOne({
      ip: ip
    }).populate('device').exec(function (err, deviceIp) {
	  if(err || !deviceIp)
      {
      	return HandleUnauthorized(res);
      }
      else if(!isExists(roles,deviceIp.type))
      {
  		return HandleNotFound(res);
	  }
      console.log("Authorized");
      callback(deviceIp);
	});
}

exports.NotFound = function(res) {
  return HandleNotFound(res);
}

exports.Unauthorized = function(res) {
  return HandleUnauthorized(res);
}

function HandleNotFound(res) {
    return res.view('404', {layout: false});;
}

function HandleUnauthorized(res) {
    return res.view('403', {layout: false});;
}