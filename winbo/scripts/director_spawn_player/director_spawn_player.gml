/// @function director_spawn_player
/// @summary Create a player instance for the given user if one doesn't exist.
/// @param _user The user struct to spawn a player for.
/// @param _x Optional x position to spawn at.
/// @param _y Optional y position to spawn at.
/// @returns {id} The created player instance.
function director_spawn_player(_user,_x,_y){
	//Check if Player Already Exists
	with(o_player){
		if(user_id == _user.user_id)
			exit;
	}
	
	//Define Player Start Position
	var _player_start_x,_player_start_y;
	_player_start_x = room_width/2;
	_player_start_y = room_height/2;
	
	// Check if returning from bonus room - restore saved position
	if (o_director.bonus_room_entry_x != 0 || o_director.bonus_room_entry_y != 0) {
		_player_start_x = o_director.bonus_room_entry_x;
		_player_start_y = o_director.bonus_room_entry_y;
		
		// Clear entry position now that we've used it
		o_director.bonus_room_entry_x = 0;
		o_director.bonus_room_entry_y = 0;
	}
	else {
		// Normal spawn logic
		with(o_player_start){
			_player_start_x = x;
			_player_start_y = y;
		}
		
		with(o_checkpoint){
			if(checkpoint_active){
				_player_start_x = x;
				_player_start_y = y - 300;
			}
		}
	}
	
	_x ??= _player_start_x;
	_y ??= _player_start_y;
	
	//Create Player
	var _player_instance;
	_player_instance = instance_create_layer(_x,_y,"lyr_player",o_player);
	with(_player_instance){
		player_user_setup(_user.user_id);
	}
	
	with(_player_instance){
		#region Target
			input_aim_target_x = x + lengthdir_x(GAMEPAD_DIST_MIN,0);
			input_aim_target_y = y + lengthdir_y(GAMEPAD_DIST_MIN,0);
	
			var _user_id;
			_user_id = user_id;
			with(o_input){
				gamepad_aim_x[_user_id] = other.input_aim_target_x;
				gamepad_aim_y[_user_id] = other.input_aim_target_y;
			}
		#endregion
	}
	
	#region Make Camera Follow Player
		with(o_camera){
			//State to Follow
			state = CameraState.follow;
			
			//Follow Target ID set to player object so that multiplayer works properly
			follow_target_id = o_player;
		}
	#endregion
	
	//Return the newly created player
	return _player_instance
}