/// @function http_request_ags
/// @summary Send an HTTP request using the AGS API table.
/// @param Endpoint Endpoint enum defining the request URL.
/// @param header_auth Include bearer token header when true.
/// @param body JSON body string to send.
/// @returns {real} Request ID from http_request.
/// Example:
/// ```gml
/// var id = http_request_ags(Endpoint.login, true, json_encode(payload));
/// ```
function http_request_ags(_endpoint,_header_auth,_body) {
	var _ret_id;
	_ret_id = noone;

	with(o_http){
		var _header,_url,_method;
		_header = ds_map_create();
		_header[? "Content-Type"] = "application/json";
	
		if((_header_auth) && (auth_access_token != noone) && (auth_access_token != undefined)){
			_header[? "Authorization"] = "Bearer " + auth_access_token;
		}
	
	
		_url = api[_endpoint][EndpointProperty.url];
		_method = api[_endpoint][EndpointProperty.method];
	
	
		sdm("");
		sdm("_url: " + string(_url));
		sdm("_method: " + string(_method));
		sdm("_header: " + string(json_encode(_header)));
		sdm("_body: " + string(_body));
		sdm("");
	
		_ret_id = http_request(_url,_method,_header,_body);
		api[_endpoint][EndpointProperty.request_id] = _ret_id;
	
		ds_map_destroy(_header);
	}

	return _ret_id;
}