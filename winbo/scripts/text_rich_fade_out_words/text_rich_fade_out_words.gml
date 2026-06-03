/// @function text_rich_fade_out_words
/// @description Fade out text word by word
/// @param {real} [_delay_per_word=0.15] Delay between words in seconds
/// @param {real} [_duration=0.5] Fade duration per word in seconds
/// @param {real} [_delay_per_char=0] Optional character stagger within words in seconds
/// @param {real} [_initial_delay=0] Overall delay before animation starts in seconds
function text_rich_fade_out_words(_delay_per_word, _duration, _delay_per_char, _initial_delay) {
	_delay_per_word ??= 0.15;
	_duration ??= 0.5;
	_delay_per_char ??= 0;
	_initial_delay ??= 0;
	
	// Convert seconds to steps
	_duration *= SECOND;
	_delay_per_word *= SECOND;
	_delay_per_char *= SECOND;
	_initial_delay *= SECOND;
	
	text_rich_animate_words(TransformValue.alpha, 1, 0, _duration, ease_quad_out, _delay_per_word, _delay_per_char, _initial_delay);
	
	// Mark as animating for rendering optimization
	rich_text_is_animating = true;
	rich_text_transforms_dirty = true;  // Force transform update next frame
}
