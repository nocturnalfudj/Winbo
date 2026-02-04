/// @function text_button_toggle_text_update
/// @summary Swap displayed text based on the button toggle state.
function text_button_toggle_text_update(){
	text	= toggle? text_on	: text_off;
	prefix	= toggle? prefix_on	: prefix_off;
	suffix	= toggle? suffix_on	: suffix_off;

	text_string		= toggle? text_string_on	: text_string_off;
	prefix_string	= toggle? prefix_string_on	: prefix_string_off;
	suffix_string	= toggle? suffix_string_on	: suffix_string_off;

	//Update Text Strings
	text_ui_text_strings_update();
}