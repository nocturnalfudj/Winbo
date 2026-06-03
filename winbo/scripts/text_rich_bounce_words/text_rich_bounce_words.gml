/// @function text_rich_bounce_words
/// @description Make words bounce in one by one
/// @param {real} [_delay_per_word=0.2] Delay between words in seconds
/// @param {real} [_duration=0.6] Bounce duration per word in seconds
/// @param {real} [_bounce_height=50] How high to bounce (pixels)
/// @param {real} [_initial_delay=0] Overall delay before animation starts in seconds
function text_rich_bounce_words(_delay_per_word, _duration, _bounce_height, _initial_delay) {
	_delay_per_word ??= 0.2;
	_duration ??= 0.6;
	_bounce_height ??= 50;
	_initial_delay ??= 0;
	
	// Convert seconds to steps
	_duration *= SECOND;
	_delay_per_word *= SECOND;
	_initial_delay *= SECOND;
	
	// Start at current position (0), go UP (-bounce_height), then recoil back to rest
	text_rich_animate_words(TransformValue.y, 0, -_bounce_height, _duration, ease_quad_out, _delay_per_word, 0, _initial_delay, 0, -1, true, false, true);
	
	// Mark as animating for rendering optimization
	rich_text_is_animating = true;
	rich_text_transforms_dirty = true;  // Force transform update next frame
}
