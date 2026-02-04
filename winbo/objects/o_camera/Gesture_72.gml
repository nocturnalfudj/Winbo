if(CAMERA_ZOOM_ENABLE && zoom_control_enable && zoom_control_pinch_active){
	var _pos_1_x,_pos_1_y,_pos_2_x,_pos_2_y;
	_pos_1_x = event_data[? "guiposX1"];
	_pos_1_y = event_data[? "guiposY1"];
	_pos_2_x = event_data[? "guiposX2"];
	_pos_2_y = event_data[? "guiposY2"];

	var _pinch_distance,_pinch_scale;
	_pinch_distance = point_distance(_pos_1_x,_pos_1_y,_pos_2_x,_pos_2_y);
	_pinch_scale = zoom_control_pinch_start_distance/_pinch_distance;

	var _target;
	_target = zoom_control_pinch_start_value * _pinch_scale;
			
	if(zoom_control_clamp_enable)
		_target = clamp(_target,zoom_control_clamp_min,zoom_control_clamp_max);

	transform_value_animate_from_current(zoom_anchor,_target,1,0.15*SECOND,ease_quart_out,false);
}