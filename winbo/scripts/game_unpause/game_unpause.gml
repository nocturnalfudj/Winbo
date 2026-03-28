/// @function game_unpause
/// @summary Resume gameplay from a paused state.
function game_unpause(){
	with(o_audio){
		if(music_snd_id_game != noone && audio_is_paused(music_snd_id_game)){
			audio_resume_sound(music_snd_id_game);
		}
	}

	//Go to Previous GameState
	game_state_set_target(o_master.pause_prev_game_state);
			
	//Remove Pause
	ui_anchor_remove(o_anchor_pause);
}
