/// @function text_rich_jitter
/// @description Enable/update random jitter to character positions
/// @param {bool} _enable Whether to enable jitter
/// @param {real} [_intensity=2] Maximum pixel offset
/// @param {real} [_speed=0.1] How fast characters jitter (lower = faster)
function text_rich_jitter(_enable, _intensity, _speed) {
	_intensity ??= 2;
	_speed ??= 0.1;
	
	// Store jitter parameters
	jitter_enabled = _enable;
	jitter_intensity = _intensity;
	jitter_speed = _speed;
}
