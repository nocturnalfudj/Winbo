/// @function console_execution
/// @summary Parse and execute a text command from the developer console.
/// @returns {void} No return value.
function console_execution() {
	var _valid_subject,_valid_action;
	var _list_size_subjects,_list_size_actions,_list_size_arguments;
	var _section_end_pos;
	var _prefix,_subject,_subject_value,_subject_type;
	var _action,_action_num,_action_struct,_action_string,_action_script,_action_argument_num;

	_list_size_subjects = ds_list_size(command_subject_list);
	for(var _i=0;_i<_list_size_subjects;_i++){
		_valid_subject = false;
	
		#region Subject Validation & Location
			_subject = command_subject_list[| _i];
	
			_section_end_pos = string_pos(".",_subject);
			if(_section_end_pos == 0)
				_prefix = _subject;
			else
				_prefix = string_copy(_subject,1,_section_end_pos);
				
			#region Classification
				for(var _j=0;_j<CMDSubject.SIZE;_j++){
					if(_prefix == command_subject[_j].prefix){
						switch(_j){
							case CMDSubject.instance:
								#region Instance ID
									_subject_type = CMDSubject.instance;
									_subject_value = string_delete(_subject,1,_section_end_pos);
			
									if(string_length(_subject_value) != 0){
										if(string_length(string_digits(_subject_value)) == string_length(_subject_value)){
											_subject_value = real(string_digits(_subject_value));
			
											if(instance_exists(_subject_value)){
												_valid_subject = true;
												sdm("Instance found",LOG_COLOUR_COMMAND_SUCCESS);
											}
											else{
												sdm("Instance not found : " + _subject,LOG_COLOUR_COMMAND_ERROR);
											}
										}
										else{
											sdm("Instance id invalid, must only contain numbers : " + _subject,LOG_COLOUR_COMMAND_ERROR);
										}
									}
									else{
										sdm("Instance id invalid, cannot be empty : " + _subject,LOG_COLOUR_COMMAND_ERROR);
									}
								#endregion
							break;
						
							case CMDSubject.object:
								#region Object ID
									_subject_type = CMDSubject.object;
									_subject_value = string_delete(_subject,1,_section_end_pos);
			
									if(string_length(_subject_value) != 0){
										if(string_length(string_digits(_subject_value)) == string_length(_subject_value)){
											_subject_value = real(string_digits(_subject_value));
				
											if(instance_exists(_subject_value)){
												_valid_subject = true;
												sdm("Instance found",LOG_COLOUR_COMMAND_SUCCESS);
											}
											else{
												sdm("Instance of object not found : " + _subject,LOG_COLOUR_COMMAND_ERROR);
											}
										}
										else{
											sdm("Object id invalid, must only contain numbers : " + _subject,LOG_COLOUR_COMMAND_ERROR);
										}
									}
									else{
										sdm("Object id invalid, cannot be empty : " + _subject,LOG_COLOUR_COMMAND_ERROR);
									}
								#endregion
							break;
						
							default:
								_subject_type = _j;
								_subject_value = _subject;
								_valid_subject = true;
							break;
						}
					}
				
					if(_valid_subject)
						break;
				}
				
				if((!_valid_subject) && (_prefix == "on.")){
					#region Object Name
						_subject_type = CMDSubject.object;
						_subject_value = string_delete(_subject,1,_section_end_pos);
						_subject_value = asset_get_index(_subject_value);
			
						if(_subject_value != -1){
							sdm("Object asset found",LOG_COLOUR_COMMAND_SUCCESS);
				
							if(instance_exists(_subject_value)){
								_valid_subject = true;
								sdm("At least one instance of object found",LOG_COLOUR_COMMAND_SUCCESS);
							}
							else{
								sdm("Instance of object not found : " + _subject,LOG_COLOUR_COMMAND_ERROR);
							}
						}
						else{
							sdm("Object asset not found : " + _subject,LOG_COLOUR_COMMAND_ERROR);
						}
					#endregion
				}
			#endregion

			if(_valid_subject){
				_subject = _subject_value;
			}
			else{
				sdm("Subject invalid : " + _subject,LOG_COLOUR_COMMAND_ERROR);
			}
		#endregion
	
		if(_valid_subject){
			_list_size_actions = ds_list_size(command_action_list);
			for(var _j=0;_j<_list_size_actions;_j++){
				_valid_action = false;
			
				#region Action Validation & Location
					_action = command_action_list[| _j];
					
					with(command_subject[_subject_type]){
						_action_num = action_num;
						
						for(var _k=0;_k<_action_num;_k++){
							_action_struct = action_list[| _k];
							_action_string = _action_struct.action_string;
				
							if(_action_string == _action){
								_valid_action = true;
								break;
							}
						}
					}
			
					if((_subject_type == CMDSubject.object) || (_subject_type == CMDSubject.instance)){
						with(command_subject[CMDSubject.instance_object]){
							_action_num = action_num;
						
							for(var _k=0;_k<_action_num;_k++){
								_action_struct = action_list[| _k];
								_action_string = _action_struct.action_string;
				
								if(_action_string == _action){
									_valid_action = true;
									break;
								}
							}
						}
					}
			
					if(_valid_action){
						_action_script = _action_struct.action_script;
						_action_argument_num = _action_struct.argument_num;
					}
					else{
						sdm("Action invalid : " + _action,LOG_COLOUR_COMMAND_ERROR);
					}
				#endregion
			
				if(_valid_action){
				
					_list_size_arguments = ds_list_size(command_argument_list);
				
					if(_list_size_arguments < _action_argument_num){
						sdm("Too few arguments",LOG_COLOUR_COMMAND_ERROR);
					}
					else if(_list_size_arguments > _action_argument_num){
						sdm("Too many arguments",LOG_COLOUR_COMMAND_ERROR);
					}
					else if(_list_size_arguments == _action_argument_num){
						if(_action_script != noone){
							script_execute(_action_script,_subject,command_argument_list);
						}
						else{
							sdm("Internal error : action script doesn't exist",LOG_COLOUR_COMMAND_ERROR);
						}
					}
				}
			}
		}
	}
}