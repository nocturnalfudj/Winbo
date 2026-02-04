//Set Freeze Alarm
if((freeze_active == true) && (alarm[MasterAlarm.freeze] == -1)){
	alarm[MasterAlarm.freeze] = freeze_time;
	freeze_game_state_prev = global.game_state;
	game_state_set_target(GameState.freeze);
	global.game_state = GameState.freeze;
}