/// @function text_rich_animation_callback_clear
/// @description Clear any active animation callbacks
function text_rich_animation_callback_clear() {
	animation_callback = noone;
	animation_callback_detecting = false;
	animation_was_animating = false;
}
