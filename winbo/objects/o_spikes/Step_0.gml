//Inherit Actor
event_inherited();

//Game State Switch
switch(global.game_state){
	case GameState.play:
		#region Retractable
			switch(retractable_state){
				case SpikeRetractableState.out_idle:
					//Retractable Enable
					if(retractable_enable){
						//Reset Out Countdown
						retractable_out_countdown = retractable_out_countdown_max;
						
						//Go to Countdown
						retractable_state = SpikeRetractableState.out_countdown;
					}
				break;
				
				case SpikeRetractableState.out_countdown:
					//Run Countdown
					if(retractable_out_countdown > 0){
						retractable_out_countdown -= global.delta_time_factor_scaled;
					}
					else{
						//Go to In Active
						retractable_state = SpikeRetractableState.in_active;
					}
				break;
				
				case SpikeRetractableState.in_active:
					//Animate Down
					transform_animate_from_current(transform[TransformType.anchor],TransformValue.yscale,0,0,SECOND * 0.3,ease_back_in,false);
					//transform_animate_from_current(transform[TransformType.anchor],TransformValue.xscale,0,0,SECOND * 0.3,ease_back_in,false);
				
					//Reset In Countdown
					retractable_in_countdown = retractable_in_countdown_max;
						
					//Go to In Idle
					retractable_state = SpikeRetractableState.in_idle;
				break;
				
				case SpikeRetractableState.in_idle:
					//Retractable Enable
					if(retractable_enable){
						//Reset In Countdown
						retractable_in_countdown = retractable_in_countdown_max;
						
						//Go to Countdown
						retractable_state = SpikeRetractableState.in_countdown;
					}
				break;
				
				case SpikeRetractableState.in_countdown:
					//Run Countdown
					if(retractable_in_countdown > 0){
						retractable_in_countdown -= global.delta_time_factor_scaled;
					}
					else{
						//Go to Out Active
						retractable_state = SpikeRetractableState.out_active;
					}
				break;
				
				case SpikeRetractableState.out_active:
					//Animate Down
					transform_animate_from_current(transform[TransformType.anchor],TransformValue.yscale,1,0,SECOND * 0.3,ease_back_out,false);
					//transform_animate_from_current(transform[TransformType.anchor],TransformValue.xscale,1,0,SECOND * 0.3,ease_back_out,false);
				
					//Reset Out Countdown
					retractable_out_countdown = retractable_out_countdown_max;
						
					//Go to Out Idle
					retractable_state = SpikeRetractableState.out_idle;
				break;
			}
		#endregion
	break;
}