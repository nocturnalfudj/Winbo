/// @function cmd_app_freeze
/// @summary Pause or unpause gameplay from the console.
/// @param _subject Placeholder argument from console.
/// @param _argument_list Array of command parameters.
function cmd_app_freeze(_subject,_argument_list) {
	var _val;
	_val = _argument_list[| 0];

	if(string_lower(_val) == "true"){
		with(o_master){
			freeze_game_state_prev = global.game_state;
			game_state_set_target(GameState.freeze);
		}
	}
	else if(string_lower(_val) == "false"){
		if(global.game_state == GameState.freeze){
			with(o_master){
				game_state_set_target(freeze_game_state_prev);
			}
		}
	}
	else if(string_is_real(_val)){
		_val = real(_val);
		game_freeze(_val);
		
		sdm("App frozen for " + string(_val),LOG_COLOUR_COMMAND_SUCCESS);
	}
	else{
		sdm("Argument is invalid, must be true/false or a number : " + _val,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}
}