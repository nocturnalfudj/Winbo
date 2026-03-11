/// master_screen_fade_begin()
/// @param {real} _from_alpha Fade start alpha.
/// @param {real} _to_alpha Fade end alpha.
/// @param {real} _duration_steps Fade duration in steps.
function master_screen_fade_begin(_from_alpha, _to_alpha, _duration_steps) {
	with(o_master){
		_from_alpha = clamp(_from_alpha, 0, 1);
		_to_alpha = clamp(_to_alpha, 0, 1);
		
		if(_duration_steps <= 0 || _from_alpha == _to_alpha){
			master_screen_fade_set_immediate(_to_alpha);
			exit;
		}
		
		screen_fade_from_alpha = _from_alpha;
		screen_fade_to_alpha = _to_alpha;
		screen_fade_alpha = _from_alpha;
		screen_fade_active = true;
		screen_fade_countdown.Set(_duration_steps, _duration_steps);
		screen_fade_countdown.SetActive(true);
	}
}
