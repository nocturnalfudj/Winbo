function text_field_highlight_delete() {
	text_string = string_delete(text_string,text_highlight_middle+1,(text_highlight_end-text_highlight_middle));

	//Update Text Highlight String
	text_highlight_string = "";

	text_field_edit_pos_move(text_highlight_middle,false);
}