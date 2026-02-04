/// @description Regular Finish Check
alarm[0] = HTTP_FINISH_CHECK_CD_MAX;

var _fin,_map,_next_ind;
_next_ind = regular_finish_check_index_current + HTTP_FINISH_CHECK_INDEX_INCR;

for(var _i=regular_finish_check_index_current;(_i<Endpoint.SIZE) && (_i<_next_ind);_i++){
	_fin = api[_i][EndpointProperty.body_map_fin];
	if(_fin == true){
		api[_i][EndpointProperty.body_map_fin] = false;
		
		_map = api[_i][EndpointProperty.body_map];
		
		if(ds_exists(_map,ds_type_map))
			ds_map_destroy(_map);
	}
}

regular_finish_check_index_current = _next_ind;
if(regular_finish_check_index_current >= Endpoint.SIZE)
	regular_finish_check_index_current = 0;