//Inherit Actor
event_inherited();

//Game State Switch
switch(global.game_state){
	case GameState.play:
		switch(state){
			case PickupState.create:
				//State to Idle
				state = PickupState.idle;
			break;
			
			case PickupState.idle:
				if(hover_enable){
					var _wave;
					_wave = global.wave_sine_1_scaled;
				
					adjustment_x = 0;
					adjustment_y = -15 * _wave;
					adjustment_scale_x = 0.08 * _wave;
					adjustment_scale_y = -0.08 * _wave;
				}
			break;
			
			case PickupState.collect:
				//Execute Collect Script
				if(collect_script != noone){
					script_execute(collect_script);
				}
			
				//State to Death
				state = PickupState.death;
			break;
			
			case PickupState.death:
				//Shrink & Fade
				transform_animate_from_current_shrink_and_fade(0.2*SECOND);
			
				//State to Destroy
				state = PickupState.destroy;
			break;
			
			case PickupState.destroy:
				//Destroy instance when Transform is at rest
				transform_updated_check();
	
				if(!transform_updated){
					instance_destroy();
				}
			break;
		}
	
		//Transform Update
		transform_system_update();
	break;
	
	case GameState.gameover:
		//Transform Update
		transform_system_update();
	break;
	
	case GameState.stop:
	case GameState.menu:
		//Transform Update
		transform_system_update();
	break;
}