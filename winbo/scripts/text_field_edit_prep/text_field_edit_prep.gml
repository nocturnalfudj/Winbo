/// @function text_field_edit_prep
/// @summary Prepare a text field for editing.
/// @returns {void}
function text_field_edit_prep() {
	//State to Edit
	ui_object_state_set(UIState.edit);
		
	if(text_edit_empty)
		text_string = "";
		
	text_field_edit_pos_move(max(1,string_length(text_string)),false);
		
	keyboard_lastkey = -1;
		
	//Reset Keyboard String
	keyboard_string = text_string;
	keyboard_string_length_prev = string_length(keyboard_string);
		
	//Show Mobile Keyboard
	if(IS_MOBILE && !IS_BROWSER){
		keyboard_virtual_show(kbv_type_default,kbv_returnkey_default,kbv_autocapitalize_none,true);
	}
		
	//Other TextxtFldields to Idle
	with(o_text_field){
		if(id!=other.id){
			//State to Idle
			ui_object_state_set(UIState.idle);
		}
	}
}