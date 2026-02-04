/// @function transform_set
/// @summary Set or offset a transform value and mark it animating.
/// @param _transform Transform struct to modify.
/// @param _transform_value Index of the value to change.
/// @param _value New value or delta.
/// @param {bool} _add_to_current Whether to add to the current value.
function transform_set(_transform,_transform_value,_value,_add_to_current) {
	with(_transform){
		var _animating_pass;
		_animating_pass = false;
		with(value[_transform_value]){
			if(_add_to_current){
				var _new_current;
				_new_current = current + _value;

				if(_new_current != current){
					animating = true;
					current = _new_current;
				}
			}
			else{
				if(_value != current){
					animating = true;
					current = _value;
				}
			}
			target = current;
			target_start_difference = 0;
			time_current = time_max;
			_animating_pass = animating;
		}
		
		if(!animating)
			animating = _animating_pass;
	}
}