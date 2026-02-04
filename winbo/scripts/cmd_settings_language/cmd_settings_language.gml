/// @function cmd_settings_language
/// @summary Console command handler for changing the game language.
/// @param _subject Calling subject (unused).
/// @param _argument_list List containing the desired language.
/// @returns {void} No return value.
function cmd_settings_language(_subject,_argument_list) {
	var _language,_language_set_success;
	_language = _argument_list[| 0];

	_language_set_success = text_language_set(_language);

	if(_language_set_success == -1){
		sdm("Language does not exist : " + _language,LOG_COLOUR_COMMAND_ERROR);
	}
	else{
		sdm("Language set to " + string(_language),LOG_COLOUR_COMMAND_SUCCESS);
	}
}