function text_field_state_edit() {
	var _state_stop,_state_current;
	_state_stop = false;
	_state_current = state;
	
	draw_set_font(text_font);
	draw_set_halign(text_alignment_h);
	draw_set_valign(text_alignment_v);

	#region Text Position Blink
	if(text_edit_pos_blink_countdown <= 0){
		text_edit_pos_blink = !text_edit_pos_blink;
		text_edit_pos_blink_countdown = TEXT_FIELD_EDIT_POS_BLINK_COUNTDOWN;

	}
	else{
		text_edit_pos_blink_countdown-= global.delta_time_factor;
	}
	#endregion

	#region Keyboard
		var _key,_len,_dif,_keyboard_string;
		_key = keyboard_lastkey;
		_len = string_length(text_string);
		_keyboard_string = keyboard_string;
		_dif = string_length(_keyboard_string) - string_length(text_string);

		if(_dif > 0){
			#region Characters
				//Delete Highlighted
				if(text_highlight_active){
					text_field_highlight_delete();
				}	
				
				var _dif_str;
				_dif_str = string_copy(_keyboard_string,string_length(_keyboard_string)-_dif+1,_dif);
		
				//Insert New String into Text Sting
				text_field_text_string_insert(_dif_str);
				
				keyboard_string = text_string;
			#endregion	
		}
		else if(_dif < 0){
			#region Backspace
				repeat (abs(_dif)){
					if(_len > 0){
						//Delete Highlighted
						if(text_highlight_active){
							text_field_highlight_delete();
						}
						else{
							text_string = string_delete(text_string,text_edit_pos_current,1);
							text_password_string_update();
						
							text_field_edit_pos_move(-1,true);
						}
					}
				
					text_edit_pos_blink = true;
					text_edit_pos_blink_countdown = TEXT_FIELD_EDIT_POS_BLINK_COUNTDOWN;
				
					keyboard_string = text_string;
				}
			#endregion
		}
		else if(((!IS_MOBILE) || (IS_MOBILE && TESTING_MOBILE_ON_DESKTOP)) && (_dif == 0) && (is_real(_key)) && (_key >= 1)){
			#region Interaction
				var _key_string;
				_key_string = global.keyboard_keycode_list[| _key];
		
				switch(_key_string){		
					case "End":
						#region End
							if(keyboard_check(vk_shift) || keyboard_check(vk_lshift)){
								if(text_highlight_enable){
									if(!text_highlight_active)
										text_field_highlight_begin();
					
									text_highlight_end = _len;
								
									//Update Highlighted
									text_field_highlight_update();
								}
							}
							else
								text_field_edit_pos_move(_len,false);
						#endregion
					break;
		
					case "Home":
						#region Home
							if(keyboard_check(vk_shift) || keyboard_check(vk_lshift)){
								if(text_highlight_enable){
									if(!text_highlight_active)
										text_field_highlight_begin();
					
									text_highlight_middle = 0;
								
									//Update Highlighted
									text_field_highlight_update();
								}
							}
							else
								text_field_edit_pos_move(0,false);
						#endregion
					break;
		
					case "Left":
						#region Left
							if(keyboard_check(vk_shift) || keyboard_check(vk_lshift)){
								if(text_highlight_enable){
									if(!text_highlight_active)
										text_field_highlight_begin();
					
									if(text_highlight_end > text_highlight_start){
										text_highlight_end = max(text_highlight_start,text_highlight_end-1);
									}
									else{
										text_highlight_middle = max(0,text_highlight_middle-1);
									
									}
								
									//Update Highlighted
									text_field_highlight_update();
								}
							}
							else{
								if(text_highlight_active){
									text_edit_pos_current = text_highlight_middle;
								}
							
								text_field_edit_pos_move(-1,true);
							}
						#endregion
					break;
		
					case "Right":
						#region Right
							if(keyboard_check(vk_shift) || keyboard_check(vk_lshift)){
								if(text_highlight_enable){
									if(!text_highlight_active)
										text_field_highlight_begin();
					
									if(text_highlight_middle < text_highlight_start){
										text_highlight_middle = max(0,text_highlight_middle+1);
									}
									else{
										text_highlight_end = max(text_highlight_start,text_highlight_end+1);
									}
								
									//Update Highlighted
									text_field_highlight_update();
								}
							}
							else{
								if(text_highlight_active){
									text_edit_pos_current = text_highlight_end;
								}
							
								text_field_edit_pos_move(1,true);
							}
						#endregion
					break;

					#region N/A Keys
						case "Backspace":
						case "Tab":
						case "Numpad 5 (nmlk off)":
						case "Shift":
						case "Pause":
						case "Caps lock":
						case "Page up":
						case "Page down":
						case "Up":
						case "Down":
						case "Insert":
						case "Delete":
						case "Windows":
						case "Numpad 0":
						case "Numpad 1":
						case "Numpad 2":
						case "Numpad 3":
						case "Numpad 4":
						case "Numpad 5":
						case "Numpad 6":
						case "Numpad 7":
						case "Numpad 8":
						case "Numpad 9":
						case "Numpad *":
						case "Numpad +":
						case "Numpad -":
						case "Numpad .":
						case "Numpad /":
						case "F1":
						case "F2":
						case "F3":
						case "F4":
						case "F5":
						case "F6":
						case "F7":
						case "F8":
						case "F9":
						case "F10":
						case "F11":
						case "F12":
						case "Num lock":
						case "Scroll lock":
						case "Shift (left)":
						case "Shift (right)":
						case "Ctrl (left)":
						case "Ctrl (right)":
						case "Alt (left)":
						case "Alt (right)":
						case "Undefined":
						break;
					#endregion
			
					default:
						#region Control Shortcuts
							if((keyboard_check(vk_control)) || (keyboard_check(vk_lcontrol))){
								//Update Highlighted
								text_field_highlight_update();
								
								#region Character Check
									//Copying
									if(keyboard_check(ord("C"))){
										clipboard_set_text(text_highlight_string);
									}
								
									//Pasting
									if(keyboard_check(ord("V"))){
										//Delete Highlighted
										if(text_highlight_active){
											text_field_highlight_delete();
										}
									
										_key_string = clipboard_get_text();
									
										//Insert New String into Text Sting
										text_field_text_string_insert(_key_string);
									
										keyboard_string = text_string;
									}
				
									//Cutting
									if(keyboard_check(ord("X"))){
										//Delete Highlighted
										if(text_highlight_active){
											text_field_highlight_delete();
										}
									
										clipboard_set_text(text_highlight_string);
									
										keyboard_string = text_string;
									}
								}
							#endregion
						#endregion
					break;
				}
			#endregion
		}
	
		keyboard_lastkey = -1;
	#endregion

	if(live){
		//Custom Script
		ui_object_state_script_stage_execute(UIState.active,UIStateStage.main);
	}

	if(keyboard_check_pressed(vk_enter)){
		//State to Active
		ui_object_state_set(UIState.active);
			
		//Finished with State
		_state_stop = true;
	}

	if(keyboard_check_pressed(vk_escape)){
		//State to Active
		ui_object_state_set(UIState.idle);
	
		//Finished with State
		_state_stop = true;
	}

	if(_state_stop){
		//Hide Mobile Keyboard
		if(IS_MOBILE && !IS_BROWSER){
			keyboard_virtual_hide();
		}
	}

	//Custom Script
	var _stage;
	_stage = (_state_stop)? UIStateStage.stop : UIStateStage.main;
	ui_object_state_script_stage_execute(_state_current,_stage);
}