/// @function text_rich_calculate_character_positions
/// @description Calculate position data for each character in the text, handling wrapping and alignment
/// @returns {array} Array of structs with {char, x, y, width, line, index}
function text_rich_calculate_character_positions() {
	var _text = text_final_string;
	var _font = font;
	var _width_max = width_max;  // Use width_max for wrapping, not width_actual
	var _sep = sep;
	var _align_h = alignment_h;
	var _align_v = alignment_v;
	
	// Set font for measurements
	draw_set_font(_font);
	
	var _positions = [];
	var _text_length = string_length(_text);
	
	// Early exit if no text
	if (_text_length == 0) {
		return _positions;
	}
	
	// Track current position
	var _current_x = 0;
	var _current_y = 0;
	var _current_line = 0;
	
	// Calculate line height using string_height_ext to match GameMaker's internal calculation
	// This gives us the actual line height that draw_text_ext uses
	var _line_height = string_height_ext("M", 0, 9999);  // Single character height with no wrapping
	
	// Calculate line separation to match draw_text_ext behavior
	// In draw_text_ext, sep is the line-to-line spacing (origin to origin)
	// When sep = -1, it uses the default font line height
	var _line_sep;
	if (_sep == -1) {
		// Use default font line spacing (matches draw_text_ext with sep=-1)
		_line_sep = _line_height;
	} else if (_sep == 0) {
		// No separation - lines are directly adjacent
		_line_sep = _line_height;
	} else {
		// Use the specified separation as line-to-line distance
		_line_sep = _sep;
	}
	
	// Track lines for alignment
	var _lines = [];
	var _lines_count = 0;
	var _current_line_chars = [];
	var _current_line_width = 0;
	
	// Parse text character by character, but wrap at word boundaries
	for (var _i = 1; _i <= _text_length; _i++) {
		var _char = string_char_at(_text, _i);
		var _char_width = string_width(_char);
		
		// Handle newline
		if (_char == "\n") {
			// Store current line
			_lines[_lines_count] = {
				chars: _current_line_chars,
				width: _current_line_width,
				line: _current_line
			};
			_lines_count++;
			
			// Start new line
			_current_line++;
			_current_line_chars = [];
			_current_line_width = 0;
			_current_x = 0;
			_current_y += _line_sep;
			
			// Still add newline character (for tracking purposes)
			array_push(_current_line_chars, {
				char: _char,
				x: _current_x,
				y: _current_y - _line_sep,
				width: 0,
				line: _current_line - 1,
				index: _i - 1
			});
			
			continue;
		}
		
		// Check if adding this character would exceed width
		if (_width_max > 0 && _current_x + _char_width > _width_max && _current_x > 0) {
			// WORD WRAPPING: Try to break at last space
			var _break_index = -1;
			var _line_char_count = array_length(_current_line_chars);
			
			// Search backwards for the last space
			for (var _j = _line_char_count - 1; _j >= 0; _j--) {
				if (_current_line_chars[_j].char == " ") {
					_break_index = _j;
					break;
				}
			}
			
			// If we found a space, break there
			if (_break_index >= 0) {
				// Split the line at the space
				var _chars_to_move = [];
				var _recalc_width = 0;
				
				// Collect characters after the space to move to next line
				for (var _j = _break_index + 1; _j < _line_char_count; _j++) {
					array_push(_chars_to_move, _current_line_chars[_j]);
					_recalc_width += _current_line_chars[_j].width;
				}
				
				// Trim current line to just before/at the space
				array_resize(_current_line_chars, _break_index + 1);
				
				// Recalculate current line width (up to and including the space)
				_current_line_width = 0;
				for (var _j = 0; _j <= _break_index; _j++) {
					_current_line_width += _current_line_chars[_j].width;
				}
				
				// Store current line
				_lines[_lines_count] = {
					chars: _current_line_chars,
					width: _current_line_width,
					line: _current_line
				};
				_lines_count++;
				
				// Start new line with the moved characters
				_current_line++;
				_current_y += _line_sep;
				_current_x = 0;
				_current_line_chars = [];
				
				// Re-add moved characters with updated y position and line number
				for (var _j = 0; _j < array_length(_chars_to_move); _j++) {
					var _moved_char = _chars_to_move[_j];
					_moved_char.y = _current_y;
					_moved_char.x = _current_x;
					_moved_char.line = _current_line;
					array_push(_current_line_chars, _moved_char);
					_current_x += _moved_char.width;
				}
				_current_line_width = _current_x;
			}
			else {
				// No space found - this is a single long word
				// Wrap at character level (current behavior)
				_lines[_lines_count] = {
					chars: _current_line_chars,
					width: _current_line_width,
					line: _current_line
				};
				_lines_count++;
				
				// Start new line
				_current_line++;
				_current_line_chars = [];
				_current_line_width = 0;
				_current_x = 0;
				_current_y += _line_sep;
			}
		}
		
		// Add character to current line
		array_push(_current_line_chars, {
			char: _char,
			x: _current_x,
			y: _current_y,
			width: _char_width,
			line: _current_line,
			index: _i - 1  // Convert to 0-indexed
		});
		
		_current_x += _char_width;
		_current_line_width = _current_x;
	}
	
	// Store final line
	if (array_length(_current_line_chars) > 0) {
		_lines[_lines_count] = {
			chars: _current_line_chars,
			width: _current_line_width,
			line: _current_line
		};
		_lines_count++;
	}
	
	// Calculate total text height for vertical alignment
	// Total height = (number of lines - 1) * line_sep + height of one line
	var _total_height = (_lines_count > 0) ? (_lines_count - 1) * _line_sep + _line_height : 0;
	
	// Apply alignment offsets and build final positions array
	for (var _i = 0; _i < _lines_count; _i++) {
		var _line_data = _lines[_i];
		var _line_chars = _line_data.chars;
		var _line_width = _line_data.width;
		
		// Calculate line width excluding trailing spaces (for alignment)
		// GameMaker's draw_text_ext ignores trailing spaces when centering/aligning
		var _line_width_for_alignment = _line_width;
		var _char_count = array_length(_line_chars);
		
		// Find the last non-space character
		for (var _j = _char_count - 1; _j >= 0; _j--) {
			if (_line_chars[_j].char != " " && _line_chars[_j].char != "\n") {
				// Calculate width up to and including this character
				_line_width_for_alignment = _line_chars[_j].x + _line_chars[_j].width;
				break;
			}
		}
		
		// Calculate horizontal alignment offset
		// Note: Alignment is relative to the origin (0,0), not within width_max
		// This matches how draw_text_ext works with alignment
		var _offset_x = 0;
		switch (_align_h) {
			case fa_center:
				_offset_x = -_line_width_for_alignment / 2;
				break;
			case fa_right:
				_offset_x = -_line_width_for_alignment;
				break;
			default: // fa_left
				_offset_x = 0;
				break;
		}
		
		// Calculate vertical alignment offset (applied to all lines)
		var _offset_y = 0;
		switch (_align_v) {
			case fa_middle:
				_offset_y = -_total_height / 2;
				break;
			case fa_bottom:
				_offset_y = -_total_height;
				break;
			default: // fa_top
				_offset_y = 0;
				break;
		}
		
		// Apply offsets to all characters in this line
		var _char_count = array_length(_line_chars);
		for (var _j = 0; _j < _char_count; _j++) {
			var _char_data = _line_chars[_j];
			_char_data.x += _offset_x;
			_char_data.y += _offset_y;
			array_push(_positions, _char_data);
		}
	}
	
	return _positions;
}
