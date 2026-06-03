/// @function text_rich_animate_word
/// @description Animate all instances of a specific word by searching for the word text
/// @param {string} _word_text The word to find and animate (animates ALL instances)
/// @param {real} _transform_value TransformValue enum
/// @param {real} _start Start value
/// @param {real} _target Target value
/// @param {real} _duration Duration in steps
/// @param {function} _ease Ease function
/// @param {real} [_delay_per_char=0] Delay between each character in the word (in steps)
/// @param {bool} [_relative=false] Whether to add to current value
/// @param {bool} [_recoil=false] Whether to recoil back to rest after reaching target
function text_rich_animate_word(_word_text, _transform_value, _start, _target, _duration, _ease, _delay_per_char, _relative, _recoil) {
	// Default parameters
	_delay_per_char ??= 0;
	_relative ??= false;
	_recoil ??= false;
	
	// Find ALL instances of the word and animate them
	var _found_count = 0;
	for (var _i = 0; _i < rich_word_count; _i++) {
		if (rich_word[_i].word_text == _word_text) {
			// Animate this word instance (duration already in steps, no conversion needed)
			text_rich_animate_word_by_index(_i, _transform_value, _start, _target, _duration, _ease, _delay_per_char, _relative, _recoil);
			_found_count++;
		}
	}
	
	if (_found_count == 0) {
		sdm("Warning: Word '" + _word_text + "' not found in rich text");
	} else {
		sdm("Animated " + string(_found_count) + " instance(s) of '" + _word_text + "'");
	}
	
	// Mark as animating for rendering optimization
	rich_text_is_animating = true;
	rich_text_transforms_dirty = true;  // Force transform update next frame
}
