/// @function console_text_field_edit_main
/// @summary Handle user input when editing a console command.
function console_text_field_edit_main() {
	console_text_field_idle_main();

	if(keyboard_check_pressed(vk_up)){
		var _command_list_size;
		_command_list_size = ds_list_size(command_list);
		if((_command_list_size > 0) && (command_list_pos > 0)){
			var _previous_command;
			_previous_command = "";

			command_list_pos--;
			_previous_command = command_list[| command_list_pos];

			text_string = "";

			//Insert New String into Text Sting
			text_field_text_string_insert(_previous_command);

			keyboard_string = text_string;
		}
	}

	if(keyboard_check_pressed(vk_down)){
		var _previous_command;
		_previous_command = "";

		var _command_list_size;
		_command_list_size = ds_list_size(command_list);
		if((_command_list_size > 0) && (command_list_pos < _command_list_size - 1)){
			command_list_pos++;

			_previous_command = command_list[| command_list_pos];
		}

		text_string = "";

		//Insert New String into Text Sting
		text_field_text_string_insert(_previous_command);

		keyboard_string = text_string;
	}

	command_stage = string_count(" ",text_string);

	//Added a ,
	if((keyboard_lastchar == ",") || (keyboard_check_pressed(vk_backspace))){
		keyboard_lastchar = "";
		//In Arguments Stage
		if(command_stage == 2){
			//Upadte Argument Slot
			console_text_field_autofill_argument_slot_update();
		}
	}

	//Autofill
	if(keyboard_check_pressed(vk_tab)){
		//Enable Help
		with(o_console){
			command_autofill_help_enable = true;
		}

		switch(command_stage){
			case 0:
				#region Subject Autofill
					if(keyboard_check(vk_shift))
						command_subject--;
					else
						command_subject++;

					if(command_subject < 0)
						command_subject = CMDSubject.SIZE-1;

					if(command_subject == CMDSubject.SIZE)
						command_subject = CMDSubject.instance;

					text_string = o_console.command_subject[command_subject].prefix;
					keyboard_string = text_string;

					//Update Text Highlight String
					text_highlight_string = "";

					//Update Edit Position
					text_field_edit_pos_move(string_length(text_string),false);
				#endregion
			break;

			case 1:
				#region Action Autofill
					//Get Position of First Space Character
					var _text_string_space_pos;
					_text_string_space_pos = string_pos(" ",text_string);

					#region Check Subject has been Updated
						var _subject;
						_subject = string_copy(text_string,0,_text_string_space_pos-1);

						command_subject = -1;
						with(o_console){
							for(var _i=CMDSubject.instance;_i<CMDSubject.SIZE;_i++){
								switch(_i){
									case CMDSubject.instance:
										if(string_copy(_subject,0,2) == "i.")
											other.command_subject = _i;
									break;

									case CMDSubject.object:
										if(string_copy(_subject,0,2) == "o.")
											other.command_subject = _i;
									break;

									default:
										if(_subject == command_subject[_i].prefix)
											other.command_subject = _i;
									break;
								}
							}
						}
					#endregion

					//Exit if Subject is Invalid
					if(command_subject == -1)
						exit;

					//Next Action
					if(keyboard_check(vk_shift))
						command_action--;
					else
						command_action++;

					//If Subject is Object or Instance use Instance Object Subject
					var _command_subject;
					_command_subject = command_subject;
					if(command_subject == CMDSubject.object || command_subject == CMDSubject.instance)
						_command_subject = CMDSubject.instance_object;

					//Get the number of Actions for the Subject
					var _command_subject_action_num;
					_command_subject_action_num = o_console.command_subject[_command_subject].action_num;

					//Continue only if Subject has at least one Action
					if(_command_subject_action_num > 0){
						//Loop back to end if gone past the first Action
						if(command_action < 0)
							command_action = _command_subject_action_num -1;

						//Loop back to 0 if gone past the last Action
						if(command_action >= _command_subject_action_num)
							command_action = 0;

						//Set Text to only Subject and Space Character
						text_string = string_copy(text_string,0,_text_string_space_pos);

						//Add on the Action String
						text_string += o_console.command_subject[_command_subject].action_list[| command_action].action_string;
						keyboard_string = text_string;

						//Update Text Highlight String
						text_highlight_string = "";

						//Update Edit Position
						text_field_edit_pos_move(string_length(text_string),false);

						//Upadte Argument Slot
						console_text_field_autofill_argument_slot_update();
					}
				#endregion
			break;

			case 2:
				//Get Position of First Space Character
				var _text_string_space_pos;
				_text_string_space_pos = string_pos(" ",text_string);

				#region Check Subject is Valid
					var _subject;
					_subject = string_copy(text_string,0,_text_string_space_pos-1);

					command_subject = -1;
					with(o_console){
						for(var _i=CMDSubject.instance;_i<CMDSubject.SIZE;_i++){
							switch(_i){
								case CMDSubject.instance:
									if(string_copy(_subject,0,2) == "i.")
										other.command_subject = _i;
								break;

								case CMDSubject.object:
									if(string_copy(_subject,0,2) == "o.")
										other.command_subject = _i;
								break;

								default:
									if(_subject == command_subject[_i].prefix)
										other.command_subject = _i;
								break;
							}
						}
					}

					//Exit if Subject is Invalid
					if(command_subject == -1)
						exit;
				#endregion

				//If Subject is Object or Instance use Instance Object Subject
				var _command_subject;
				_command_subject = command_subject;
				if(command_subject == CMDSubject.object || command_subject == CMDSubject.instance)
					_command_subject = CMDSubject.instance_object;

				//Get the number of Actions for the Subject
				var _command_subject_action_num;
				_command_subject_action_num = o_console.command_subject[_command_subject].action_num;

				//Get Position of Second Space Character
				var _text_string_space_pos_second;
				_text_string_space_pos_second = string_pos_ext(" ",text_string,_text_string_space_pos+1);

				#region Check Action is Valid
					var _action;
					_action = string_copy(text_string,_text_string_space_pos+1,(_text_string_space_pos_second-1) - (_text_string_space_pos));

					command_action = -1;
					with(o_console){
						for(var _i=0;_i<_command_subject_action_num;_i++){
							if(_action == command_subject[_command_subject].action_list[| _i].action_string){
								other.command_action = _i;
								break;
							}
						}
					}

					//Exit if Action is Invalid
					if(command_action == -1)
						exit;
				#endregion

				//Upadte Argument Slot
				console_text_field_autofill_argument_slot_update();

				//Valid Argument Slot
				if(command_argument_slot == -1)
					exit;

				var _argument_autofill_array;
				_argument_autofill_array = o_console.command_subject[_command_subject].action_list[| command_action].argument_autofill;

				//Next Action
				if(keyboard_check(vk_shift))
					command_argument--;
				else
					command_argument++;

				//Get the number of Argument Autofills for the Action
				var _argument_autofill_array_length;
				_argument_autofill_array_length = array_length(_argument_autofill_array[command_argument_slot]);

				//Continue only if Action has at least one Argument Autofill
				if(_argument_autofill_array_length > 0){
					//Loop back to end if gone past the first Arugment Autofill
					if(command_argument < 0)
						command_argument = _argument_autofill_array_length - 1;

					//Loop back to 0 if gone past the last Arugment Autofill
					if(command_argument >= _argument_autofill_array_length)
						command_argument = 0;

					//First Argument
					if(command_argument_slot == 0){
						//Set Text to only Subject, Action and Space Character
						text_string = string_copy(text_string,0,_text_string_space_pos_second);
					}
					else{
						var _text_string_comma_pos_last;
						_text_string_comma_pos_last = string_last_pos(",",text_string);

						//Set Text to only Subject, Action, Existing Arguments and Last Comma Character
						text_string = string_copy(text_string,0,_text_string_comma_pos_last);
					}

					//Add on the Argument Autofill String
					text_string += _argument_autofill_array[command_argument_slot][command_argument];
					keyboard_string = text_string;

					//Update Text Highlight String
					text_highlight_string = "";

					//Update Edit Position
					text_field_edit_pos_move(string_length(text_string),false);
				}
			break;
		}
	}
}
