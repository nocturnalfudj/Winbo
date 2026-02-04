function text_clean_up(_text){
	if(_text != noone){
		var _text_group;
		_text_group = _text.text_group;
		
		with(o_text){
			var _list,_list_position;
			_list = text_list[_text_group];
			if(ds_exists(_list,ds_type_list)){
				_list_position = ds_list_find_index(_list,_text);
			
				ds_list_delete(_list,_list_position);
			}
		}
	}
}