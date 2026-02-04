/// @function text_field_text_string_insert
/// @summary Insert a string into the text field at the current edit cursor.
/// @param _key_string The characters to insert.
/// @returns {void} No return value.
function text_field_text_string_insert(_key_string) {
	var _strNew,_key_string_len,_key_string_part,_key_string_part_pos,_width,_len;
	_key_string_len = string_length(_key_string);

	_key_string_part_pos = 1;
	_key_string_part = string_copy(_key_string,_key_string_part_pos,1);

	_strNew = text_string + _key_string_part;
	_width = string_width(_strNew);
	_len = string_length(_strNew);
				
        // Add characters one at a time while the text fits within the field
        while((_width < text_width) && (_key_string_part_pos <= _key_string_len)){
		text_edit_pos_current++;
		text_string = string_insert(_key_string_part,text_string,text_edit_pos_current);
	
		_key_string_part_pos++;
		_key_string_part = string_copy(_key_string,_key_string_part_pos,1);

		_strNew = text_string + _key_string_part;
		_width = string_width(_strNew);
		_len = string_length(_strNew);
	}

	text_password_string_update();

	text_edit_pos_current = clamp(text_edit_pos_current,0,_len);
	text_edit_pos_blink = true;
	text_edit_pos_blink_countdown = TEXT_FIELD_EDIT_POS_BLINK_COUNTDOWN;

	var _text_str;
	_text_str = (password_enable)? password_string : text_string;
	text_edit_pos_blink_x = text_x + (string_width(string_copy(_text_str,1,text_edit_pos_current)) - string_width(TEXT_FIELD_EDIT_POS_STRING)/2);
}