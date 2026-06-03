/// @function text_rich_stop_animations
/// @description Stop all active animations on characters
/// @param {real} [_start_index=0] First character
/// @param {real} [_end_index=-1] Last character (-1 for all)
function text_rich_stop_animations(_start_index, _end_index) {
	_start_index ??= 0;
	_end_index ??= -1;
	
	// Calculate end index
	if (_end_index < 0 || _end_index >= rich_character_count) {
		_end_index = rich_character_count - 1;
	}
	
	// Stop animations for each character
	for (var _i = _start_index; _i <= _end_index; _i++) {
		var _char_struct = rich_character[_i];
		
		with (_char_struct) {
			// Stop all transform value animations
			for (var _j = 0; _j < TransformValue.SIZE; _j++) {
				with (transform[TransformType.anchor].value[_j]) {
					animating = false;
					time_current = time_max;
					target = current;
				}
			}
			transform[TransformType.anchor].animating = false;
		}
	}
	
	// Clear animation flag when manually stopping
	rich_text_is_animating = false;
}
