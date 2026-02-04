/// @function bomb_game_state_play
/// @summary Main state machine for bomb objects.
function bomb_game_state_play() {
	//State Switch
	switch(state){
		case BombState.create:
			bomb_state_create();
		break;
	
		case BombState.countdown:
			bomb_state_countdown();
		break;
	
		case BombState.detonate:
			bomb_state_detonate();
		break;
	
		case BombState.explode:
			bomb_state_explode();
		break;
	
		case BombState.fade:
			bomb_state_fade();
		break;
	
		case BombState.death:
			bomb_state_death();
		break;
	
		case BombState.destroy:
			bomb_state_destroy();
		break;
	}
	
	#region Movement
		#region Homing
			//If Homing Target Set & Homing Acceleration Larger than 0
			if((homing_target_object != noone) && (homing_acceleration > 0)){
				//Homing Target Exists
				if(instance_exists(homing_target)){
					//Get Homing Target Position
					var _homing_target_x,_homing_target_y;
					with(homing_target){
						_homing_target_x = x;
						_homing_target_y = y;
					}
				
					//Calculate Direction to Homing Target
					var _homing_target_dir;
					_homing_target_dir = point_direction(x,y,_homing_target_x,_homing_target_y);
				
					//Accelerate Towards Homing Target
					acceleration.AddMagnitudeDirection(homing_acceleration + acceleration_max/1000,_homing_target_dir);
				}
				//If Bullet Should Find a New Target
				else if(homing_find_new_target){
					//Target Nearest Homing Target Object
					homing_target = instance_nearest(x,y,homing_target_object);
				}
				else{
					homing_acceleration = 0;
				}
			}
		#endregion
	
		//Movement Update
		movement_system_update();
	#endregion

	//Postion Update
	transform_system_update();
	
	//Image Update
	image_system_update();
	
	//PFX System Execute
	//pfx_system_execute();
}