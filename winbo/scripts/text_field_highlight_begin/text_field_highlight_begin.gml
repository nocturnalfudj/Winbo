/// @function text_field_highlight_begin
/// @summary Start selecting text inside the active text field.
/// @returns {void} No return value.
function text_field_highlight_begin() {
	text_highlight_active = true;
	text_highlight_start = text_edit_pos_current;
	text_highlight_middle = text_edit_pos_current;
	text_highlight_end = text_edit_pos_current;
}