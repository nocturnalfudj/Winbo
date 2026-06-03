/// @function text_rich_rainbow
/// @description Enable/update rainbow color cycle on characters
/// @param {bool} _enable Whether to enable rainbow effect
/// @param {real} [_cycle_duration=3] Duration for full rainbow cycle in seconds
/// @param {real} [_offset_per_char=30] Hue offset between characters (0-360)
function text_rich_rainbow(_enable, _cycle_duration, _offset_per_char) {
	_cycle_duration ??= 3;
	_offset_per_char ??= 30;
	
	// Store rainbow parameters
	rainbow_enabled = _enable;
	rainbow_cycle_duration = _cycle_duration;
	rainbow_offset_per_char = _offset_per_char;
	
	if (!_enable) {
		rainbow_time = 0;
	}
}
