/// @function text_rich_animate_word_by_index
/// @description Animate a word by its index in the rich_word array
/// @param {real} _word_index Index of word in rich_word array
/// @param {real} _transform_value TransformValue enum
/// @param {real} _start Start value
/// @param {real} _target Target value
/// @param {real} _duration Duration in steps
/// @param {function} _ease Ease function
/// @param {real} [_delay_per_char=0] Delay between each character (in steps)
/// @param {bool} [_relative=false] Whether to add to current value
/// @param {bool} [_recoil=false] Whether to recoil back to rest after reaching target
function text_rich_animate_word_by_index(_word_index, _transform_value, _start, _target, _duration, _ease, _delay_per_char, _relative, _recoil) {
	// Default parameters
	_delay_per_char ??= 0;
	_relative ??= false;
	_recoil ??= false;
	
	// Validate word index
	if (_word_index < 0 || _word_index >= rich_word_count) {
		sdm("Warning: Word index " + string(_word_index) + " out of bounds");
		return;
	}
	
	var _word = rich_word[_word_index];
	
	// Animate all characters in this word
	for (var _i = 0; _i < _word.char_count; _i++) {
		var _char_index = _word.char_start_index + _i;
		
		// Skip if character index is out of bounds
		if (_char_index >= rich_character_count) continue;
		
		var _char_struct = rich_character[_char_index];
		var _char_delay = _i * _delay_per_char;
		
		// Animate this character using proper helper functions
		with (_char_struct) {
			if (_relative) {
				// Use transform_animate_relative_to_rest for animations with start + target offsets
				transform_animate_relative_to_rest(
					transform[TransformType.anchor],
					_transform_value,
					_start,
					_target,
					-_char_delay,
					_duration,
					_ease,
					_recoil,
					true
				);
			} else {
				// Use standard animate function for absolute values
				transform_animate(
					transform[TransformType.anchor],
					_transform_value,
					_start,
					_target,
					-_char_delay,
					_duration,
					_ease,
					_recoil,
					true
				);
			}
		}
	}
	
	// Mark as animating for rendering optimization
	rich_text_is_animating = true;
	rich_text_transforms_dirty = true;  // Force transform update next frame
}
