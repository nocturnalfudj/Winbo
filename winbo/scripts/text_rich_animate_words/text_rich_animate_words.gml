/// @function text_rich_animate_words
/// @description Animate a specific transform property for all words with optional stagger delay between words
/// @param {real} _transform_value TransformValue enum (x, y, xscale, yscale, alpha, colour, angle)
/// @param {real} _start Start value
/// @param {real} _target Target value
/// @param {real} _duration Duration in steps per word
/// @param {function} _ease Ease function (e.g ease_sine_out)
/// @param {real} [_delay_per_word=0] Delay between each word starting in steps
/// @param {real} [_delay_per_char_in_word=0] Optional stagger within each word in steps
/// @param {real} [_initial_delay=0] Overall delay before animation starts (applies to all words)
/// @param {real} [_start_word_index=0] First word to animate
/// @param {real} [_end_word_index=-1] Last word to animate (-1 for all)
/// @param {bool} [_relative=false] Whether to add to current value instead of setting absolute
/// @param {bool} [_reverse=false] Whether to stagger words in reverse order
/// @param {bool} [_recoil=false] Whether to recoil back to rest after reaching target
function text_rich_animate_words(_transform_value, _start, _target, _duration, _ease, _delay_per_word, _delay_per_char_in_word, _initial_delay, _start_word_index, _end_word_index, _relative, _reverse, _recoil) {
	// Default parameters
	_delay_per_word ??= 0;
	_delay_per_char_in_word ??= 0;
	_initial_delay ??= 0;
	_start_word_index ??= 0;
	_end_word_index ??= -1;
	_relative ??= false;
	_reverse ??= false;
	_recoil ??= false;
	
	// Calculate end index
	if (_end_word_index < 0 || _end_word_index >= rich_word_count) {
		_end_word_index = rich_word_count - 1;
	}
	
	// Clamp start index
	_start_word_index = clamp(_start_word_index, 0, rich_word_count - 1);
	
	// Animate each word
	for (var _i = _start_word_index; _i <= _end_word_index; _i++) {
		var _word = rich_word[_i];
		
		// Calculate delay for this word
		var _word_delay = _reverse ? 
			(_end_word_index - _i) * _delay_per_word : 
			(_i - _start_word_index) * _delay_per_word;
		
		// Animate all characters in this word
		for (var _j = 0; _j < _word.char_count; _j++) {
			var _char_index = _word.char_start_index + _j;
			
			// Skip if character index is out of bounds
			if (_char_index >= rich_character_count) continue;
			
		var _char_struct = rich_character[_char_index];
		
		// Optional internal character stagger within the word (initial delay + word delay + char stagger)
		var _char_delay = _initial_delay + _word_delay + (_j * _delay_per_char_in_word);
			
			// Animate this character using proper helper functions
			with (_char_struct) {
				if (_relative) {
					// Use transform_animate_relative_to_rest for animations with start + target offsets
					// This animates from (rest + _start) to (rest + _target)
					transform_animate_relative_to_rest(
						transform[TransformType.anchor],
						_transform_value,
						_start,       // Offset from rest for start position
						_target,      // Offset from rest for target position
						-_char_delay,
						_duration,
						_ease,
						_recoil,      // Pass recoil parameter
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
						_recoil,      // Pass recoil parameter
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
