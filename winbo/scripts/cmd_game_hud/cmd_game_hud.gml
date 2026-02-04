function cmd_game_hud(_subject,_argument_list){
	var _val;
	_val = _argument_list[| 0];

	if((string_lower(_val) == "false") || (_val == "0")){
		with(o_ui){
			hud_enable = false;
			
			sdm("Hud disabled",LOG_COLOUR_COMMAND_SUCCESS);
		}
	}
	else if((string_lower(_val) == "true") || (_val == "1")){
		with(o_ui){
			hud_enable = true;
			
			sdm("Hud enabled",LOG_COLOUR_COMMAND_SUCCESS);
		}
	}
	else
		sdm("Argument is invalid, must be true/false or 1/0 : " + _val,LOG_COLOUR_COMMAND_ERROR);
}