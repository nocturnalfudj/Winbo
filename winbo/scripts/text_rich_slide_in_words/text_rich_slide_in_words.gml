/// @function text_rich_slide_in_words
/// @description Slide words in from a direction
/// @param {real} _offset_x X offset to slide from (e.g -100 for left, 100 for right)
/// @param {real} _offset_y Y offset to slide from (e.g -50 for above, 50 for below)
/// @param {real} [_delay_per_word=0.15] Delay between words in seconds
/// @param {real} [_duration=0.5] Slide duration per word in seconds
/// @param {function} [_ease=ease_expo_out] Ease function
function text_rich_slide_in_words(_offset_x, _offset_y, _delay_per_word, _duration, _ease) {
	_delay_per_word ??= 0.15;
	_duration ??= 0.5;
	_ease ??= ease_expo_out;
	
	// Set initial offset positions for all characters
	for (var _i = 0; _i < rich_character_count; _i++) {
		var _char = rich_character[_i];
		with (_char) {
			if (_offset_x != 0) {
				var _rest_x = transform[TransformType.anchor].value[TransformValue.x].rest;
				transform_set(transform[TransformType.anchor], TransformValue.x, _rest_x + _offset_x, false);
			}
			if (_offset_y != 0) {
				var _rest_y = transform[TransformType.anchor].value[TransformValue.y].rest;
				transform_set(transform[TransformType.anchor], TransformValue.y, _rest_y + _offset_y, false);
			}
		}
	}
	
	// Convert duration to steps
	var _duration_steps = _duration * SECOND;
	var _delay_per_word_steps = _delay_per_word * SECOND;
	
	// Now animate from current (offset) to rest using transform_animate_from_current_relative_to_rest
	for (var _word_idx = 0; _word_idx < rich_word_count; _word_idx++) {
		var _word = rich_word[_word_idx];
		var _word_delay = _word_idx * _delay_per_word_steps;
		
		// Animate all characters in this word
		for (var _j = 0; _j < _word.char_count; _j++) {
			var _char_index = _word.char_start_index + _j;
			if (_char_index >= rich_character_count) continue;
			
			var _char = rich_character[_char_index];
			
			with (_char) {
				// Animate from current (offset) to rest (0)
				if (_offset_x != 0) {
					transform_animate_from_current_relative_to_rest(
						transform[TransformType.anchor],
						TransformValue.x,
						0,  // Target is rest + 0 = rest
						-_word_delay,
						_duration_steps,
						_ease,
						false,
						true
					);
				}
				if (_offset_y != 0) {
					transform_animate_from_current_relative_to_rest(
						transform[TransformType.anchor],
						TransformValue.y,
						0,  // Target is rest + 0 = rest
						-_word_delay,
						_duration_steps,
						_ease,
						false,
						true
					);
				}
			}
		}
	}
	
	// Mark as animating for rendering optimization
	rich_text_is_animating = true;
	rich_text_transforms_dirty = true;  // Force transform update next frame
}
