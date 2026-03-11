/// master_screen_fade_set_immediate()
/// @param {real} _alpha Fade alpha to apply immediately.
function master_screen_fade_set_immediate(_alpha) {
	with(o_master){
		_alpha = clamp(_alpha, 0, 1);
		screen_fade_alpha = _alpha;
		screen_fade_from_alpha = _alpha;
		screen_fade_to_alpha = _alpha;
		screen_fade_active = false;
		screen_fade_countdown.Set(0, max(1, screen_fade_countdown.time_max));
		screen_fade_countdown.SetActive(false);
	}
}
