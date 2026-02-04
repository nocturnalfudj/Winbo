/// @function cmd_game_spawn
/// @summary Spawn the given object near the player location.
/// @param _subject Console subject (unused).
/// @param _argument_list Array of arguments: [objectName].
/// @returns {void} No return value.
function cmd_game_spawn(_subject,_argument_list){
	var _player_x,_player_y,
	_player_x = mouse_x;
	_player_y = mouse_y;
	with(o_player){
		_player_x = x;
		_player_y = y;
	}
	
	var _x,_y;
	_x = _player_x + irandom_range(-1000,1000);
	_y = _player_y + irandom_range(-1000,1000);
	for(var _i=0;_i<200;_i++){
		if(collision_circle(_x,_y,100,o_solid,false,false)){
			_x = _player_x + irandom_range(-1000,1000);
			_y = _player_y + irandom_range(-1000,1000);
		}
		else{
			break;
		}
	}
	
	var _layer;
	_layer = "lyr_player";
	
	var _object,_object_index;
	_object = _argument_list[| 0];
	_object_index = asset_get_index(_object);
	if(object_exists(_object_index)){
		_object = _object_index;
	}
	else{
		sdm("Argument is invalid, object not found: " + _object,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}
	
	instance_create_layer(_x,_y,_layer,_object);
	
	sdm("Instance of " + string(_object) + " created at " + string(_x) + "," + string(_y) + " on layer " + string(_layer),LOG_COLOUR_COMMAND_SUCCESS);
}