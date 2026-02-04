///@param group
///@param instance
function ui_group_set(_group,_inst) {
	with(o_ui){
		var _list = ui_group_list[_group];
		ds_list_add(_list,_inst);
	}
}