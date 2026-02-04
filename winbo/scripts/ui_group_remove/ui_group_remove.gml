/// @function ui_group_remove
/// @summary Remove an instance from a UI group list.
/// @param group Group identifier index.
/// @param instance Instance to remove from the group.
/// @returns {void} No return value.
function ui_group_remove(_group,_inst) {
	with(o_ui){
		var _list,_lst_sz,_lst_inst;
	
		_list = ui_group_list[_group];
		_lst_sz = ds_list_size(_list);
		
		for(var _j=0;_j<_lst_sz;_j++){
			_lst_inst = _list[_j];
			if(_inst == _lst_inst){
				ds_list_delete(_list,_j);
			}
		}
	}
}