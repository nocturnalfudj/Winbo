function transform_value_animate_pause(_transform_value,_pause) {
	with(_transform_value){
		_pause ??= true;
		animating_pause = _pause;
	}
}