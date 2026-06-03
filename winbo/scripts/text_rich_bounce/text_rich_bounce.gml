/// @function text_rich_bounce
/// @description Make text bounce in character by character
/// @param {real} [_delay_per_char=0.02] Stagger delay in seconds
/// @param {real} [_duration=0.5] Bounce duration in seconds
/// @param {real} [_bounce_height=50] How high to bounce (pixels)
/// @param {real} [_initial_delay=0] Overall delay before animation starts in seconds
function text_rich_bounce(_delay_per_char, _duration, _bounce_height, _initial_delay) {
	_delay_per_char ??= 0.02;
	_duration ??= 0.5;
	_bounce_height ??= 50;
	_initial_delay ??= 0;
	
	// Convert seconds to steps
	_duration *= SECOND;
	_delay_per_char *= SECOND;
	_initial_delay *= SECOND;
	
	// Start at current position (0), go UP (-bounce_height), then recoil back to rest
	text_rich_animate_characters(TransformValue.y, 0, -_bounce_height, _duration, ease_quad_out, _delay_per_char, _initial_delay, 0, -1, true, false, true);
	
	// Mark as animating for rendering optimization
	rich_text_is_animating = true;
	rich_text_transforms_dirty = true;  // Force transform update next frame
}
