/// @function text_rich_reset_transforms
/// @description Reset all character transforms to their base positions
/// @param {real} [_transform_value=-1] Specific value to reset, or -1 for all
/// @param {bool} [_animate=false] Whether to animate back or snap
/// @param {real} [_duration=0.3] Animation duration if animate=true (in seconds, will be converted to steps)
/// @param {function} [_ease=ease_quad_out] Ease function if animate=true
function text_rich_reset_transforms(_transform_value, _animate, _duration, _ease) {
	_transform_value ??= -1;
	_animate ??= false;
	_duration ??= 0.3;
	_ease ??= ease_quad_out;
	
	// Convert seconds to steps (SECOND = 60)
	_duration *= SECOND;
	
	// Reset all characters
	for (var _i = 0; _i < rich_character_count; _i++) {
		var _char_struct = rich_character[_i];
		
		with (_char_struct) {
			// If specific transform value, reset only that
			if (_transform_value >= 0) {
				var _rest_value = transform[TransformType.anchor].value[_transform_value].rest;
				
				if (_animate) {
					// Animate from current to rest position (offset of 0 from rest)
					transform_value_animate_from_current_relative_to_rest(
						transform[TransformType.anchor].value[_transform_value],
						0,  // Target is rest position (offset of 0)
						0,  // No delay
						_duration,
						_ease,
						false,
						true
					);
				} else {
					// Snap to rest value
					transform_set(transform[TransformType.anchor], _transform_value, _rest_value, false);
				}
			} else {
				// Reset all transform values
				if (_animate) {
					// Animate all values back to their rest positions
					transform_value_animate_from_current_relative_to_rest(transform[TransformType.anchor].value[TransformValue.x], 0, 0, _duration, _ease, false, true);
					transform_value_animate_from_current_relative_to_rest(transform[TransformType.anchor].value[TransformValue.y], 0, 0, _duration, _ease, false, true);
					transform_value_animate_from_current_relative_to_rest(transform[TransformType.anchor].value[TransformValue.xscale], 0, 0, _duration, _ease, false, true);
					transform_value_animate_from_current_relative_to_rest(transform[TransformType.anchor].value[TransformValue.yscale], 0, 0, _duration, _ease, false, true);
					transform_value_animate_from_current_relative_to_rest(transform[TransformType.anchor].value[TransformValue.alpha], 0, 0, _duration, _ease, false, true);
					transform_value_animate_from_current_relative_to_rest(transform[TransformType.anchor].value[TransformValue.colour], 0, 0, _duration, _ease, false, true);
					transform_value_animate_from_current_relative_to_rest(transform[TransformType.anchor].value[TransformValue.angle], 0, 0, _duration, _ease, false, true);
				} else {
					// Snap all values to their rest positions
					transform_set(transform[TransformType.anchor], TransformValue.x, transform[TransformType.anchor].value[TransformValue.x].rest, false);
					transform_set(transform[TransformType.anchor], TransformValue.y, transform[TransformType.anchor].value[TransformValue.y].rest, false);
					transform_set(transform[TransformType.anchor], TransformValue.xscale, transform[TransformType.anchor].value[TransformValue.xscale].rest, false);
					transform_set(transform[TransformType.anchor], TransformValue.yscale, transform[TransformType.anchor].value[TransformValue.yscale].rest, false);
					transform_set(transform[TransformType.anchor], TransformValue.alpha, transform[TransformType.anchor].value[TransformValue.alpha].rest, false);
					transform_set(transform[TransformType.anchor], TransformValue.colour, transform[TransformType.anchor].value[TransformValue.colour].rest, false);
					transform_set(transform[TransformType.anchor], TransformValue.angle, transform[TransformType.anchor].value[TransformValue.angle].rest, false);
				}
			}
		}
	}
}
