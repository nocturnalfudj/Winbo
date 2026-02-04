/// @function console_extraction
/// @summary Parse command text into subject, action and arguments.
function console_extraction() {
	var _section_separator,_section_end_pos;
	_section_separator = " ";
	
	var _working_string;
	
	#region Subject/Action/Argument Strings
		var _subject_string,_action_string,_argStr;

		//Subjects
		_working_string = command_text;
		_section_end_pos = string_pos(_section_separator,_working_string);
		if(_section_end_pos==0) _section_end_pos = string_length(_working_string)+1;
		_subject_string = string_copy(_working_string,1,_section_end_pos-1);
		//Command Analysis - Subject String
		if(command_analyse)	sdm("Subject String : " + _subject_string,LOG_COLOUR_COMMAND_ANALYSE);
	
		//Actions
		_working_string = string_delete(_working_string,1,_section_end_pos);
		_section_end_pos = string_pos(_section_separator,_working_string);
		if(_section_end_pos==0) _section_end_pos = string_length(_working_string)+1;
		_action_string = string_copy(_working_string,1,_section_end_pos-1);
		//Command Analysis - Action String
		if(command_analyse)	sdm("Action String : " + _action_string,LOG_COLOUR_COMMAND_ANALYSE);

		//Arguments
		_working_string = string_delete(_working_string,1,_section_end_pos);
		_section_end_pos = string_pos(_section_separator,_working_string);
		if(_section_end_pos==0) _section_end_pos = string_length(_working_string)+1;
		_argStr = string_copy(_working_string,1,_section_end_pos-1);
		//Command Analysis - Subject Argument
		if(command_analyse)	sdm("Argument String : " + _argStr,LOG_COLOUR_COMMAND_ANALYSE);
	#endregion
	
	#region Subjects
		var _subject;
	
		_section_separator = ",";
	
		_working_string = _subject_string;
		_section_end_pos = string_pos(_section_separator,_working_string);
	
		while(_section_end_pos!=0){
			_subject = string_copy(_working_string,1,_section_end_pos-1);
	
			if(string_length(_subject) > 0)
				ds_list_add(command_subject_list,_subject);
		
			//Command Analysis - Subject
			if(command_analyse)	sdm("Subject : " + _subject,LOG_COLOUR_COMMAND_ANALYSE);
		
			_working_string = string_delete(_working_string,1,_section_end_pos);
			_section_end_pos = string_pos(_section_separator,_working_string);
		}
	
		_subject = _working_string;
		if(string_length(_subject) > 0)
			ds_list_add(command_subject_list,_subject);
	
		//Command Analysis - Subject
		if(command_analyse)	sdm("Subject : " + _subject,LOG_COLOUR_COMMAND_ANALYSE);
	#endregion
	
	#region Actions
		var _action;
	
		_section_separator = ",";
	
		_working_string = _action_string;
		_section_end_pos = string_pos(_section_separator,_working_string);
	
		while(_section_end_pos!=0){
			_action = string_copy(_working_string,1,_section_end_pos-1);
	
			if(string_length(_action) > 0)
				ds_list_add(command_action_list,_action);
		
			//Command Analysis - Action
			if(command_analyse)	sdm("Action : " + _action,LOG_COLOUR_COMMAND_ANALYSE);
		
			_working_string = string_delete(_working_string,1,_section_end_pos);
			_section_end_pos = string_pos(_section_separator,_working_string);
		}
	
		_action = _working_string;
		if(string_length(_action) > 0)
			ds_list_add(command_action_list,_action);
	
		//Command Analysis - Action
		if(command_analyse)	sdm("Action : " + _action,LOG_COLOUR_COMMAND_ANALYSE);
	#endregion
	
	#region Arguments
		var _arg;
	
		_section_separator = ",";
	
		_working_string = _argStr;
		_section_end_pos = string_pos(_section_separator,_working_string);
	
		while(_section_end_pos!=0){
			_arg = string_copy(_working_string,1,_section_end_pos-1);
	
			if(string_length(_arg) > 0)
				ds_list_add(command_argument_list,_arg);
		
			//Command Analysis - Argument
			if(command_analyse)	sdm("Argument : " + _arg,LOG_COLOUR_COMMAND_ANALYSE);
		
			_working_string = string_delete(_working_string,1,_section_end_pos);
			_section_end_pos = string_pos(_section_separator,_working_string);
		}
	
		_arg = _working_string;
		if(string_length(_arg) > 0)
			ds_list_add(command_argument_list,_arg);
	
		//Command Analysis - Argument
		if(command_analyse)	sdm("Argument : " + _arg,LOG_COLOUR_COMMAND_ANALYSE);
	#endregion
}