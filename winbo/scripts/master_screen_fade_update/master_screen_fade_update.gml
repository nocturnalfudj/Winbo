/// master_screen_fade_update()
function master_screen_fade_update() {
	with(o_master){
		if(!screen_fade_active){
			exit;
		}
		
		screen_fade_countdown.Update();
		
		var _progress;
		_progress = 1 - (screen_fade_countdown.time / screen_fade_countdown.time_max);
		_progress = clamp(_progress, 0, 1);
		screen_fade_alpha = lerp(screen_fade_from_alpha, screen_fade_to_alpha, _progress);
		
		if(screen_fade_countdown.trigger_active){
			screen_fade_alpha = screen_fade_to_alpha;
			screen_fade_active = false;
			screen_fade_countdown.SetActive(false);
		}
	}
}
