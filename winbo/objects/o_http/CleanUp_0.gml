//Destroy Holder Maps
var _map;
for(var _i=0;_i<Endpoint.SIZE;_i++){
	_map = api[_i][EndpointProperty.body_map];
	if(ds_exists(_map,ds_type_map))
		ds_map_destroy(_map);
}