function draw_bounding_box_gui(_use_sprite_index) {
	if(is_undefined(_use_sprite_index))
		_use_sprite_index = false;
	else
		_use_sprite_index = true;

	var _x1,_x2,_y1,_y2;

	if(_use_sprite_index){
		_x1 = bbox_left;
		_x2 = bbox_right;
		_y1 = bbox_top;
		_y2 = bbox_bottom;
	}
	else{
		_x1 = x - width_half;
		_x2 = x + width_half;
		_y1 = y - height_half;
		_y2 = y + height_half;
	}
	
	var _gui_scale;
	_gui_scale = o_ui.gui_scale;
	
	_x1 *= _gui_scale;
	_x2 *= _gui_scale;
	_y1 *= _gui_scale;
	_y2 *= _gui_scale;
	
	draw_rectangle_color(_x1,_y1,_x2,_y2,c_ags_red,c_ags_red,c_ags_red,c_ags_red,true);
	draw_circle_color(x*_gui_scale,y*_gui_scale,3,c_ags_red,c_ags_red,false);
}