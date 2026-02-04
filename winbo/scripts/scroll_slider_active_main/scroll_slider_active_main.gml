/// @function scroll_slider_active_main
/// @summary Update slider visuals while the control is active.
function scroll_slider_active_main(){
	//Store Verticality & Value
	var _vertical,_value;
	_vertical = vertical;
	_value = value_current;
	
	with(scroll){
		//Animate Transform
		var _transform,_transform_value,_target,_time_current,_time_max,_curve;
		_transform = transform[TransformType.anchor];
		_transform_value = (_vertical)? TransformValue.y : TransformValue.x;
		_target = _value;
		_time_current = 1;
		_time_max = 0.2*SECOND;
		_curve = ease_back_out;
		transform_animate_from_current(_transform,_transform_value,_target,_time_current,_time_max,_curve);
		
		//Transform Update
		transform_system_update();
	}
}