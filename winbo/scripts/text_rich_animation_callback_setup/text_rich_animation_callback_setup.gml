/// @function text_rich_animation_callback_setup
/// @description Set up a callback to trigger when all character animations complete
/// @param {function} _callback Script to execute when animations finish
function text_rich_animation_callback_setup(_callback) {
	animation_callback = _callback;
	animation_callback_detecting = true;
	animation_was_animating = rich_text_is_animating;
}
