/// @function game_pause
/// @summary Enter the pause state and open the pause menu.
function game_pause(){
	//Set Previous Game State
	o_master.pause_prev_game_state = global.game_state;

	with(o_audio){
		if(music_snd_id_game != noone && audio_is_playing(music_snd_id_game)){
			audio_pause_sound(music_snd_id_game);
		}
	}
	
	//Go To Pause Game State
	game_state_set_target(GameState.pause);
			
	//Add Pause
	ui_anchor_create(o_anchor_pause,"lyr_pause");
}
