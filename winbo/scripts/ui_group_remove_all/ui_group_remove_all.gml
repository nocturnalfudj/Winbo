///@param instance
function ui_group_remove_all(_inst) {
	with(o_ui){
		var _list,_lst_sz,_lst_inst;
	
		for(var _i=0;_i<UIGroup.SIZE;_i++){
			_list = ui_group_list[_i];
		
			if(ds_exists(_list,ds_type_list)){
				_lst_sz = ds_list_size(_list);
		
				for(var _j=0;_j<_lst_sz;_j++){
					_lst_inst = _list[| _j];
					if(_inst == _lst_inst){
						ds_list_delete(_list,_j);
					}
				}
			}
		}
	}
}