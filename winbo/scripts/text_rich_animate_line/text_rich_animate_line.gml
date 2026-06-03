/// @function text_rich_animate_line
/// @description Animate all characters on a specific line
/// @param {real} _line_number Line number to animate
/// @param {real} _transform_value TransformValue enum
/// @param {real} _start Start value
/// @param {real} _target Target value
/// @param {real} _duration Duration in steps
/// @param {function} _ease Ease function
/// @param {real} [_delay_per_char=0] Delay between each character in steps
/// @param {real} [_initial_delay=0] Overall delay before animation starts (applies to all characters)
/// @param {bool} [_relative=false] Whether to add to current value
/// @param {bool} [_recoil=false] Whether to recoil back to rest after reaching target
function text_rich_animate_line(_line_number, _transform_value, _start, _target, _duration, _ease, _delay_per_char, _initial_delay, _relative, _recoil) {
	// Default parameters
	_delay_per_char ??= 0;
	_initial_delay ??= 0;
	_relative ??= false;
	_recoil ??= false;
	
	// Find all characters on this line and animate them
	var _char_in_line = 0;
	for (var _i = 0; _i < rich_character_count; _i++) {
		var _char_struct = rich_character[_i];
		
		// Skip if not on the target line
		if (_char_struct.line != _line_number) continue;
		
		var _char_delay = _initial_delay + (_char_in_line * _delay_per_char);
		_char_in_line++;
		
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
	
	// Mark as animating for rendering optimization
	rich_text_is_animating = true;
	rich_text_transforms_dirty = true;  // Force transform update next frame
}
