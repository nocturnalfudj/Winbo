/// @function text_rich_fade_out
/// @description Fade text out character by character
/// @param {real} [_delay_per_char=0.02] Stagger delay in seconds
/// @param {real} [_duration=0.3] Fade duration in seconds
/// @param {real} [_initial_delay=0] Overall delay before animation starts in seconds
function text_rich_fade_out(_delay_per_char, _duration, _initial_delay) {
	_delay_per_char ??= 0.02;
	_duration ??= 0.3;
	_initial_delay ??= 0;
	
	// Convert seconds to steps
	_duration *= SECOND;
	_delay_per_char *= SECOND;
	_initial_delay *= SECOND;
	
	text_rich_animate_characters(TransformValue.alpha, 1, 0, _duration, ease_linear, _delay_per_char, _initial_delay);
	
	// Mark as animating for rendering optimization
	rich_text_is_animating = true;
	rich_text_transforms_dirty = true;  // Force transform update next frame
}
