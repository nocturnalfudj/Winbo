/// @function text_rich_scale_pop_words
/// @description Pop each word with a scale animation
/// @param {real} [_delay_per_word=0.15] Delay between words in seconds
/// @param {real} [_duration=0.5] Pop duration per word in seconds
/// @param {real} [_scale_from=0] Starting scale
/// @param {real} [_scale_to=1] Target scale
/// @param {real} [_initial_delay=0] Overall delay before animation starts in seconds
function text_rich_scale_pop_words(_delay_per_word, _duration, _scale_from, _scale_to, _initial_delay) {
	_delay_per_word ??= 0.15;
	_duration ??= 0.5;
	_scale_from ??= 0;
	_scale_to ??= 1;
	_initial_delay ??= 0;
	
	// Convert seconds to steps
	_duration *= SECOND;
	_delay_per_word *= SECOND;
	_initial_delay *= SECOND;
	
	// Animate both xscale and yscale
	text_rich_animate_words(TransformValue.xscale, _scale_from, _scale_to, _duration, ease_back_out, _delay_per_word, 0, _initial_delay);
	text_rich_animate_words(TransformValue.yscale, _scale_from, _scale_to, _duration, ease_back_out, _delay_per_word, 0, _initial_delay);
	
	// Mark as animating for rendering optimization
	rich_text_is_animating = true;
	rich_text_transforms_dirty = true;  // Force transform update next frame
}
