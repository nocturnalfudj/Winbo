///@param {string} lang
function text_grid_write_language_all(_language) {
	var _text_group,_text_grid,_file;
	_file = "language/saved_text_sheets/";

	_text_group = TextGroup.ui;
	_text_grid = o_text.text_grid[_text_group];
	text_grid_write_language(_text_grid,_language,_text_group,_file+"ui");
}