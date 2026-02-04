function ui_group_set_state(_ui_group,_ui_state){
	with(o_ui){
		var _ui_group_list,_ui_group_list_size;
		_ui_group_list = ui_group_list[_ui_group];
		_ui_group_list_size = ds_list_size(_ui_group_list);
		for(var _i=0;_i<_ui_group_list_size;_i++){
			with(_ui_group_list[| _i]){
				ui_object_state_set(_ui_state);
			}
		}
	}
}