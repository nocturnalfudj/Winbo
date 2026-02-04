/// @function http_request_sdm_pass
/// @summary Log a successful HTTP request with its status code.
/// @param {string} _name Request endpoint name.
function http_request_sdm_pass(_name) {
	var _status_code;
	_status_code = async_load[? "http_status"];
	sdm("HTTP Request Passed: Endpoint - " + _name + ", status_code - " + string(_status_code));
}