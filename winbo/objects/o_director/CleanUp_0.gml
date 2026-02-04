#region Save
	var _map;
	_map = save_map;
	if(ds_exists(_map,ds_type_map)){
		ds_map_destroy(_map);
	}	
#endregion