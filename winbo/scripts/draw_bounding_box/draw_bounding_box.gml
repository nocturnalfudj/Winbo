function draw_bounding_box(_use_sprite_index) {
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

	draw_rectangle_color(_x1,_y1,_x2,_y2,c_ags_red,c_ags_red,c_ags_red,c_ags_red,true);
	draw_circle_color(x,y,3,c_ags_red,c_ags_red,false);
}