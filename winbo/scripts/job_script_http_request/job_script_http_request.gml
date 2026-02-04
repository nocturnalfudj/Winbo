/// @function job_script_http_request
/// @summary Perform an HTTP request using the provided job arguments.
/// @param arg_list Argument list containing endpoint, auth and body fields.
/// @returns {void} No return value.
function job_script_http_request(_arg_lst) {
	var _endpoint,_auth,_body;
	_endpoint = _arg_lst[| HTTPRequestJobArgument.endpoint];
	_auth = _arg_lst[| HTTPRequestJobArgument.auth];
	_body = _arg_lst[| HTTPRequestJobArgument.body];

	_arg_lst[| HTTPRequestJobArgument.request_id] = http_request_ags(_endpoint,_auth,_body);
}