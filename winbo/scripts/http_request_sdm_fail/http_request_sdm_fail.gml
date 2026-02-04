/// @function http_request_sdm_fail
/// @summary Log a failed HTTP request using the sdm console helper.
/// @param name Name of the endpoint that failed
function http_request_sdm_fail(_name) {
	var _status_code;
	_status_code = async_load[? "http_status"];
	sdm("HTTP Request Failed: Endpoint - " + _name + ", status_code - " + string(_status_code));
}