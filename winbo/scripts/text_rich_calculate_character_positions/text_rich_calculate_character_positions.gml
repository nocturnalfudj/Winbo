/// @function text_rich_calculate_character_positions
/// @description Calculate character positions for rich text using one stable line layout.
/// @returns {array} Array of structs with {char, x, y, width, line, index}
function text_rich_calculate_character_positions() {
	var _text = text_final_string;
	var _font = font;
	var _wrap_width = width_max;
	var _sep = sep;
	var _align_h = alignment_h;
	var _align_v = alignment_v;

	draw_set_font(_font);

	var _positions = [];
	var _text_length = string_length(_text);
	if (_text_length == 0) {
		return _positions;
	}

	var _line_height = string_height_ext("M", -1, 9999);
	var _line_sep = _sep;
	if (_line_sep <= 0) {
		_line_sep = _line_height;
	}

	var _lines = [];
	var _lines_count = 0;
	var _current_line_chars = [];
	var _current_line_text = "";
	var _current_line_width = 0;
	var _current_line = 0;
	var _current_y = 0;

	for (var _i = 1; _i <= _text_length; _i++) {
		var _char = string_char_at(_text, _i);
		var _char_index = _i - 1;

		if (_char == "\n") {
			array_push(_current_line_chars, {
				char: _char,
				x: _current_line_width,
				y: _current_y,
				width: 0,
				line: _current_line,
				index: _char_index
			});

			_lines[_lines_count] = {
				chars: _current_line_chars,
				width: _current_line_width,
				text: _current_line_text,
				line: _current_line
			};
			_lines_count++;

			_current_line++;
			_current_y += _line_sep;
			_current_line_chars = [];
			_current_line_text = "";
			_current_line_width = 0;
			continue;
		}

		var _soft_wrapped;
		_soft_wrapped = false;

		var _candidate_text;
		var _candidate_width;
		_candidate_text = _current_line_text + _char;
		_candidate_width = string_width(_candidate_text);

		if ((_wrap_width > 0) && (_current_line_text != "") && (_candidate_width > _wrap_width)) {
			var _break_index = -1;
			var _line_char_count = array_length(_current_line_chars);

			for (var _j = _line_char_count - 1; _j >= 0; _j--) {
				if (_current_line_chars[_j].char == " ") {
					_break_index = _j;
					break;
				}
			}

			if (_break_index >= 0) {
				var _chars_to_move = [];
				for (var _j = _break_index + 1; _j < _line_char_count; _j++) {
					array_push(_chars_to_move, _current_line_chars[_j]);
				}

				array_resize(_current_line_chars, _break_index + 1);

				_current_line_text = "";
				for (var _j = 0; _j < array_length(_current_line_chars); _j++) {
					if (_current_line_chars[_j].char != "\n") {
						_current_line_text += _current_line_chars[_j].char;
					}
				}
				_current_line_width = string_width(_current_line_text);

				_lines[_lines_count] = {
					chars: _current_line_chars,
					width: _current_line_width,
					text: _current_line_text,
					line: _current_line
				};
				_lines_count++;

				_current_line++;
				_current_y += _line_sep;
				_current_line_chars = [];
				_current_line_text = "";
				_current_line_width = 0;
				_soft_wrapped = true;

				for (var _j = 0; _j < array_length(_chars_to_move); _j++) {
					var _moved_char = _chars_to_move[_j];
					var _moved_prefix_width = string_width(_current_line_text);
					var _moved_glyph_width = string_width(_moved_char.char);
					_moved_char.x = _moved_prefix_width;
					_moved_char.y = _current_y;
					_moved_char.width = _moved_glyph_width;
					_moved_char.line = _current_line;
					array_push(_current_line_chars, _moved_char);
					_current_line_text += _moved_char.char;
					_current_line_width = string_width(_current_line_text);
				}
			}
			else {
				_lines[_lines_count] = {
					chars: _current_line_chars,
					width: _current_line_width,
					text: _current_line_text,
					line: _current_line
				};
				_lines_count++;

				_current_line++;
				_current_y += _line_sep;
				_current_line_chars = [];
				_current_line_text = "";
				_current_line_width = 0;
				_soft_wrapped = true;
			}
		}

		if (_soft_wrapped && (_current_line_text == "") && (_char == " ")) {
			array_push(_current_line_chars, {
				char: _char,
				x: 0,
				y: _current_y,
				width: 0,
				line: _current_line,
				index: _char_index
			});
			continue;
		}

		var _prefix_width = string_width(_current_line_text);
		var _glyph_width = string_width(_char);
		array_push(_current_line_chars, {
			char: _char,
			x: _prefix_width,
			y: _current_y,
			width: _glyph_width,
			line: _current_line,
			index: _char_index
		});

		_current_line_text += _char;
		_current_line_width = string_width(_current_line_text);
	}

	if (array_length(_current_line_chars) > 0) {
		_lines[_lines_count] = {
			chars: _current_line_chars,
			width: _current_line_width,
			text: _current_line_text,
			line: _current_line
		};
		_lines_count++;
	}

	var _total_height = (_lines_count > 0) ? (_lines_count - 1) * _line_sep + _line_height : 0;

	for (var _i = 0; _i < _lines_count; _i++) {
		var _line_data = _lines[_i];
		var _line_chars = _line_data.chars;
		var _line_text_for_alignment = _line_data.text;

		while ((string_length(_line_text_for_alignment) > 0) && (string_char_at(_line_text_for_alignment, string_length(_line_text_for_alignment)) == " ")) {
			_line_text_for_alignment = string_copy(_line_text_for_alignment, 1, string_length(_line_text_for_alignment) - 1);
		}

		var _line_width_for_alignment = string_width(_line_text_for_alignment);
		var _offset_x = 0;
		switch (_align_h) {
			case fa_center:
				_offset_x = -_line_width_for_alignment / 2;
			break;

			case fa_right:
				_offset_x = -_line_width_for_alignment;
			break;
		}

		var _offset_y = 0;
		switch (_align_v) {
			case fa_middle:
				_offset_y = -_total_height / 2;
			break;

			case fa_bottom:
				_offset_y = -_total_height;
			break;
		}

		for (var _j = 0; _j < array_length(_line_chars); _j++) {
			var _char_data = _line_chars[_j];
			_char_data.x += _offset_x;
			_char_data.y += _offset_y;
			array_push(_positions, _char_data);
		}
	}

	return _positions;
}
