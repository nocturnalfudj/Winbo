//Mouse Collision List
var _lst = mouse_collision_list;
if(ds_exists(_lst,ds_type_list)){
	ds_list_destroy(_lst);
	if(DEBUG_CLEANUP) sdm("Mouse Collision list destroyed id : " + string(_lst));
}

//UI Group Lists
var _lst;
for(var _i=0;_i<UIGroup.SIZE;_i++){
	_lst = ui_group_list[_i];
	ds_list_destroy(_lst);
	if(DEBUG_CLEANUP) sdm("UI Group list destroyed id : " + string(_lst));
}

#region Save
	var _map;
	_map = save_map;
	if(ds_exists(_map,ds_type_map)){
		ds_map_destroy(_map);
	}	
#endregion