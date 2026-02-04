/// @function cmd_game_spawn_ext
/// @summary Spawn an instance using explicit coordinates and layer.
/// @param _subject Console subject (unused).
/// @param _argument_list Arguments: [x,y,layerName,objectName].
/// @returns {void} No return value.
function cmd_game_spawn_ext(_subject,_argument_list){
	var _x,_y,_layer,_object;
	_x = _argument_list[| 0];
	_y = _argument_list[| 1];
	_layer = _argument_list[| 2];
	_object = _argument_list[| 3];
	
	if(string_is_real(_x)){
		_x = real(_x);
	}
	else{
		sdm("Argument is invalid, must be a number: " + _x,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}
	
	if(string_is_real(_y)){
		_y = real(_y);
	}
	else{
		sdm("Argument is invalid, must be a number: " + _y,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}
	
	if(layer_get_id(_layer) == -1){
		sdm("Argument is invalid, layer not found: " + _layer,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}
	
	var _object_index;
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