/// @function cmd_app_text_sheet_print
/// @summary Print a string from a text sheet through the console.
/// @param _subject       Command caller (unused).
/// @param _argument_list Arguments array: [group, language, id].
function cmd_app_text_sheet_print(_subject,_argument_list) {
	var _text_group,_text_group_valid,_language,_language_valid,_text_id,_text_id_valid;
	_text_group = _argument_list[| 0];
	_language = _argument_list[| 1];
	_text_id = _argument_list[| 2];

	_text_group_valid = false;
	_language_valid = false;
	_text_id_valid = false;

	#region Text Group
		if(_text_group == "ui"){
			_text_group = TextGroup.ui;
			_text_group_valid = true;
		}
		else{
			sdm("Text Group argument is invalid : " + _text_group,LOG_COLOUR_COMMAND_ERROR);
		}
	#endregion

	#region Language
		var _language_column;
		if(_language == "current"){
			_language_column= 1;
		}
		else if(_language == "default"){
			_language_column= 2;
		}
		else{
			_language_column = text_language_column_get(_text_group,_language);
		}

		if(_language_column==-1){
			sdm("Language does not exist : " + _language,LOG_COLOUR_COMMAND_ERROR);
		}
		else
			_language_valid = true;
	#endregion

	#region Text ID
		if(string_length(string_digits(_text_id)) == string_length(_text_id)){
			_text_id = real(string_digits(_text_id));
			_text_id_valid = true;
		}
		else{
			sdm("Argument is invalid, must only contain numbers : " + _text_id,LOG_COLOUR_COMMAND_ERROR);
		}
	#endregion

	#region All Pass
		if(_text_group_valid && _language_valid && _text_id_valid){
			var _string = text_grid_string_get(_text_group,_text_id,_language_column);
			if(_string!=undefined){
				sdm(_string);
				
				sdm("Text printed",LOG_COLOUR_COMMAND_SUCCESS);
			}
			else
				sdm("Text ID does not exist : " + string(_text_id),LOG_COLOUR_COMMAND_ERROR);
		}
	#endregion
}