/// @function text_rich_shake
/// @description Shake specific characters (e.g for emphasis/damage)
/// @param {real} _intensity Shake intensity in pixels
/// @param {real} _duration Shake duration in seconds
/// @param {real} [_start_index=0] First character
/// @param {real} [_end_index=-1] Last character (-1 for all)
function text_rich_shake(_intensity, _duration, _start_index, _end_index) {
	_start_index ??= 0;
	_end_index ??= -1;
	
	// Convert seconds to steps (SECOND = 60)
	_duration *= SECOND;
	
	// Calculate end index
	if (_end_index < 0 || _end_index >= rich_character_count) {
		_end_index = rich_character_count - 1;
	}
	
	// Shake each character with random offsets
	for (var _i = _start_index; _i <= _end_index; _i++) {
		var _char_struct = rich_character[_i];
		
		// Random shake offset
		var _shake_x = random_range(-_intensity, _intensity);
		var _shake_y = random_range(-_intensity, _intensity);
		
		// Animate to shake position then back
		with (_char_struct) {
			// Shake X
			transform_animate(
				transform[TransformType.anchor],
				TransformValue.x,
				x,
				x + _shake_x,
				0,
				_duration / 2,
				ease_quad_out,
				true, // Use recoil to bounce back
				true
			);
			
			// Shake Y
			transform_animate(
				transform[TransformType.anchor],
				TransformValue.y,
				y,
				y + _shake_y,
				0,
				_duration / 2,
				ease_quad_out,
				true, // Use recoil to bounce back
				true
			);
		}
	}
	
	// Mark as animating for rendering optimization
	rich_text_is_animating = true;
	rich_text_transforms_dirty = true;  // Force transform update next frame
}
