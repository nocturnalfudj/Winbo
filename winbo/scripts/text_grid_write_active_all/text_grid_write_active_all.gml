function text_grid_write_active_all() {
	var _text_group,_text_grid,_file;
	_file = "language/saved_text_sheets/";

	_text_group = TextGroup.ui;
	_text_grid = o_text.text_grid[_text_group];
	text_grid_write_active(_text_grid,_file+"ui");
}