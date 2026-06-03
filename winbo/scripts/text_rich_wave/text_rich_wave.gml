/// @function text_rich_wave
/// @description Enable/update continuous wave effect on Y position
/// @param {bool} _enable Whether to enable the wave
/// @param {real} [_amplitude=20] Wave height in pixels
/// @param {real} [_offset_per_char=0.3] Time offset between characters (creates wave propagation)
function text_rich_wave(_enable, _amplitude, _offset_per_char) {
	_amplitude ??= 20;
	_offset_per_char ??= 0.3;
	
	// Store wave parameters
	wave_enabled = _enable;
	wave_amplitude = _amplitude;
	wave_offset_per_char = _offset_per_char;
}
