/// director_game_session_start_prepare()
function director_game_session_start_prepare() {
	with(o_director){
		resource[Resource.winbo_lives][Team.player] = PLAYER_LIVES_DEFAULT;
		o_input.user[0].joined = true;
		bonus_room_origin = noone;
		bonus_room_active = false;
		bonus_room_entry_x = 0;
		bonus_room_entry_y = 0;
		level_transitioning = false;
	}
}
