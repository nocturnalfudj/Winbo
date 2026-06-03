/// @function text_rich_animate_characters
/// @description Animate a specific transform property for characters with optional stagger delay
/// @param {real} _transform_value TransformValue enum (x, y, xscale, yscale, alpha, colour, angle)
/// @param {real} _start Start value
/// @param {real} _target Target value
/// @param {real} _duration Duration in steps
/// @param {function} _ease Ease function (e.g ease_sine_out)
/// @param {real} [_delay_per_char=0] Delay between each character in steps
/// @param {real} [_initial_delay=0] Overall delay before animation starts (applies to all characters)
/// @param {real} [_start_index=0] First character to animate
/// @param {real} [_end_index=-1] Last character to animate (-1 for all)
/// @param {bool} [_relative=false] Whether to add to current value instead of setting absolute
/// @param {bool} [_reverse=false] Whether to stagger in reverse order
/// @param {bool} [_recoil=false] Whether to recoil back to rest after reaching target
function text_rich_animate_characters(_transform_value, _start, _target, _duration, _ease, _delay_per_char, _initial_delay, _start_index, _end_index, _relative, _reverse, _recoil) {
	// Default parameters
	_delay_per_char ??= 0;
	_initial_delay ??= 0;
	_start_index ??= 0;
	_end_index ??= -1;
	_relative ??= false;
	_reverse ??= false;
	_recoil ??= false;
	
	// Calculate end index
	if (_end_index < 0 || _end_index >= rich_character_count) {
		_end_index = rich_character_count - 1;
	}
	
	// Clamp start index
	_start_index = clamp(_start_index, 0, rich_character_count - 1);
	
	// Animate each character
	for (var _i = _start_index; _i <= _end_index; _i++) {
		var _char_struct = rich_character[_i];
		
		// Calculate delay for this character (initial delay + stagger offset)
		var _char_delay = _initial_delay + (_reverse ? 
			(_end_index - _i) * _delay_per_char : 
			(_i - _start_index) * _delay_per_char);
		
		// Animate this character's transform using proper helper functions
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
