/// @function cmd_app_text_sheet_save
/// @summary Export the text sheet to an external file.
/// @param _subject Placeholder argument from console.
/// @param _argument_list Array of command parameters.
function cmd_app_text_sheet_save(_subject,_argument_list) {
	var _text_group,_text_group_all,_text_group_string,_folder,_language,_language_type;
	_text_group = _argument_list[| 0];
	_text_group_all = false;
	_text_group_string = _text_group;

	_language = _argument_list[| 1];
	_language_type = 0;

	#region Text Group
		switch(_text_group){
			case "ui":
				_text_group = TextGroup.ui;
				_folder = "ui";
			break;
		
			case "all":
				_text_group = 0;
				_text_group_all = true;
			break;
		
			default:
				sdm("Text Group argument is invalid : " + _text_group,LOG_COLOUR_COMMAND_ERROR);
				exit;
			break;
		}
	#endregion

	#region Language
		var _language_column;
		_language_column = -1;
	
		switch(_language){
			case "active":
				_language_type = 1;
			break;
		
			case "template":
				_language_type = 2;
			break;
		
			default:
				_language_column = text_language_column_get(_text_group,_language);
	
				if(_language_column==-1){
					sdm("Language does not exist : " + _language,LOG_COLOUR_COMMAND_ERROR);
					exit;
				}
				else{
					_language_type = 3;
				}
			break;
		}
	#endregion

	#region All Pass
		if(_language_type!=0){
			var _grid;
			_grid = o_text.text_grid[_text_group];
	
			switch(_language_type){
				//Active Text Sheets
				case 1:
					//All
					if(_text_group_all){
						text_grid_write_active_all();
						
						sdm("All active text sheets saved",LOG_COLOUR_COMMAND_SUCCESS);
					}
					//Specific
					else{
						text_grid_write_active(_grid,"language/saved_text_sheets/"+_folder);
						
						sdm(string(_folder) + " active text sheets saved",LOG_COLOUR_COMMAND_SUCCESS);
					}
				break;
			
				//Template Text Sheet
				case 2:
					//All
					if(_text_group_all){
						text_grid_write_template_all();
						
						sdm("All template text sheets saved",LOG_COLOUR_COMMAND_SUCCESS);
					}
					//Specific
					else{
						text_grid_write_template(_grid,_text_group,"language/saved_text_sheets/"+_folder);
						
						sdm(string(_folder) + " template text sheets saved",LOG_COLOUR_COMMAND_SUCCESS);
					}
				break;
			
				//Language Text Sheet
				case 3:
					//All
					if(_text_group_all){
						text_grid_write_language_all(_language);
						
						sdm("All " + string(_language) + " text sheets saved",LOG_COLOUR_COMMAND_SUCCESS);
					}
					//Specific
					else{
						text_grid_write_language(_grid,_language,_text_group,"language/saved_text_sheets/"+_folder);
						
						sdm(string(_folder) + " " + string(_language) + " text sheets saved",LOG_COLOUR_COMMAND_SUCCESS);
					}
				break;
			}
		}
	#endregion
}