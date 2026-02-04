/// @desc Handles ticking logic for bombs that count down before detonation
function bomb_state_countdown() {
	//Run Countdown
	if(countdown > 0){
		countdown -= global.delta_time_factor_scaled;
	}
	//Countdown Finished
	else{
		//Flash
		flash_alpha = 1;
		
		//State to Detonate
		state = BombState.detonate;
				
		//Audio
		if(detonate_snd != noone)
			audio_sound_play(detonate_snd,AudioChannel.sfx,false,0);
				
		//PFX
		//pfx[pfx_bomb.detonate_cloud][part.brst_active] = 1;
		//pfx[pfx_bomb.detonate_exp][part.brst_active] = 1;
				
		//fx_part_execute();
	}
}