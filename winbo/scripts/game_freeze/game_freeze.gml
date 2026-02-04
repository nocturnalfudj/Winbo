///@param length
function game_freeze(_len) {
	if(global.game_state != GameState.freeze){
		if(_len > 0){
			with(o_master){
				if(freeze_countdown.trigger_active){
					freeze_active = true;
					freeze_time = _len;
				}
			}
		}
	}
}
