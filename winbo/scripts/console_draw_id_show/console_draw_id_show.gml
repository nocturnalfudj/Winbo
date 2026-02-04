function console_draw_id_show(_subject) {
	var _x,_colour,_alpha;
	
	var _gui_scale;
	_gui_scale = o_ui.gui_scale;
	
	draw_set_halign(ID_SHOW_ALIGN_H);
	draw_set_valign(ID_SHOW_ALIGN_V);
	draw_set_font(ID_SHOW_FONT);

	var _string_instance,_string_object,_string_object_name;
	_string_instance = ID_SHOW_INSTANCE_ID_STRING;//"Instance id : "
	_string_object = ID_SHOW_OBJECT_ID_STRING;//"Object id : "
	_string_object_name = ID_SHOW_OBJECT_NAME_STRING;//"Object name : "

	var _string_width,_string_width_next,_string_colour;
	_string_colour = ID_SHOW_COLOUR;
	_alpha = ID_SHOW_BACKGROUND_ALPHA;
	_colour = ID_SHOW_BACKGROUND_COLOUR;

	var _string_y_instance,_string_y_object,_string_y_object_name;
	var _x1,_x2,_y1,_y2,_alpha,_colour;

	var _id_show_sep_message;
	_id_show_sep_message = id_show_sep_message;

	with(_subject){
		_x = x;
		_string_y_instance = y;
	
		with(o_camera){
			_x = (_x - x)*(1/(width/width_ini)) + width_ini_half;
			_string_y_instance = (_string_y_instance - y)*(1/(height/height_ini)) + height_ini_half;
		}
	
		_string_y_object = _string_y_instance-_id_show_sep_message;
		_string_y_object_name = _string_y_object-_id_show_sep_message;
			
		_string_instance = _string_instance + string(id);
		_string_object = _string_object + string(object_index);
		_string_object_name = _string_object_name + object_get_name(object_index);
			
		_string_width = string_width(_string_instance);
		_string_width_next = string_width(_string_object);
		if(_string_width_next > _string_width) _string_width = _string_width_next;
		_string_width_next = string_width(_string_object_name);
		if(_string_width_next > _string_width) _string_width = _string_width_next;
			
		draw_set_color(_colour);
		draw_set_alpha(_alpha);
			
		_x1 = (_x - 15)*_gui_scale;
		_x2 = (_x + 15 + _string_width)*_gui_scale;
		_y1 = (_string_y_instance+30)*_gui_scale;
		_y2 = (_string_y_object_name-30)*_gui_scale;
		draw_rectangle(_x1,_y1,_x2,_y2,false);
			
		draw_set_color(_string_colour);
		draw_set_alpha(1);
		_x1 = _x*_gui_scale;
		_y1 = _string_y_instance*_gui_scale;
		draw_text_ext_transformed(_x1,_y1,_string_instance,_id_show_sep_message,_string_width,_gui_scale,_gui_scale,0);
		_x1 = _x*_gui_scale;
		_y1 = _string_y_object*_gui_scale;
		draw_text_ext_transformed(_x1,_y1,_string_object,_id_show_sep_message,_string_width,_gui_scale,_gui_scale,0);
		_x1 = _x*_gui_scale;
		_y1 = _string_y_object_name*_gui_scale;
		draw_text_ext_transformed(_x1,_y1,_string_object_name,_id_show_sep_message,_string_width,_gui_scale,_gui_scale,0);
	}
}