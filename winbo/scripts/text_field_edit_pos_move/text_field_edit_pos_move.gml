/// @function text_field_edit_pos_move
/// @summary Move the edit cursor within the text field.
/// @param _move_value Amount to move or absolute position.
/// @param _add_to_current Whether to add the move amount.
/// @returns {void}
function text_field_edit_pos_move(_move_value,_add_to_current) {
	if(_add_to_current)
		text_edit_pos_current += _move_value;
	else
		text_edit_pos_current = _move_value;
	
	var _len;
	_len = string_length(text_string);
	text_edit_pos_current = clamp(text_edit_pos_current,0,_len);

	var _text_str;
	_text_str = (password_enable)? password_string : text_string;
	text_edit_pos_blink_x = text_x + (string_width(string_copy(_text_str,1,text_edit_pos_current)) - string_width(TEXT_FIELD_EDIT_POS_STRING)/2);
	
	text_edit_pos_blink = true;
	text_edit_pos_blink_countdown = TEXT_FIELD_EDIT_POS_BLINK_COUNTDOWN;
				
	text_highlight_active = false;
	text_highlight_start = text_edit_pos_current;
	text_highlight_middle = text_edit_pos_current;
	text_highlight_end = text_edit_pos_current;
}