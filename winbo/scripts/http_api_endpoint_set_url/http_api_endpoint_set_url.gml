///@param Endpoint
///@param url
function http_api_endpoint_set_url(_endpoint,_url) {
	if(is_string(_url))
		api[_endpoint][EndpointProperty.url] = SERVER_URL + _url;
}