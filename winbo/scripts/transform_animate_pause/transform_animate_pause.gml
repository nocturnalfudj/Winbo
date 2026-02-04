/// @function transform_animate_pause
/// @summary Pause or resume animation of a transform value.
/// @param _transform Transform struct containing the value.
/// @param _transform_value Index of the value to pause.
/// @param {bool} _pause Whether to pause (default true).
/// @returns {void} No return value.
function transform_animate_pause(_transform,_transform_value,_pause) {
	with(_transform){
		with(value[_transform_value]){
			_pause ??= true;
			animating_pause = _pause;
		}
	}
}