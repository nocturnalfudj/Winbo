/// @function slider_pointer_transform_animate
/// @summary Animate the slider pointer to match its current value.
function slider_pointer_transform_animate() {
	var _target,_time_current,_time_max,_curve;
	if(vertical){
		_target = slider_sprite_height_half - slider_sprite_height*((value_current-value_min)/(value_max-value_min));
	}
	else{
		_target = slider_sprite_width*((value_current-value_min)/(value_max-value_min)) - slider_sprite_width_half;
	}
	_time_current = 1;
	_time_max = 0.2*SECOND;
	_curve = ease_back_out;
	transform_value_animate_from_current(pointer_position,_target,_time_current,_time_max,_curve);
}