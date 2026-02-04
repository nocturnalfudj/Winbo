function text_field_highlight_update() {
	var _text_str;
	_text_str = (password_enable)? password_string : text_string;

	var _len;
	_len = string_length(_text_str);

	text_highlight_end = clamp(text_highlight_end,0,_len);
	text_highlight_x2 = text_x + string_width(string_copy(_text_str,1,text_highlight_end));

	text_highlight_middle = clamp(text_highlight_middle,0,_len);
	text_highlight_x1 = text_x + string_width(string_copy(_text_str,1,text_highlight_middle));	

	text_highlight_string = string_copy(text_string,text_highlight_middle+1,(text_highlight_end-text_highlight_middle));
}