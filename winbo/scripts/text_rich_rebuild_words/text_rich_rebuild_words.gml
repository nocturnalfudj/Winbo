/// @function text_rich_rebuild_words
/// @description Intelligently rebuild word array using diff-based algorithm
/// @description Parses text_final_string to identify words (non-space sequences)
function text_rich_rebuild_words() {
	var _text = text_final_string;
	var _text_length = string_length(_text);
	
	// Early exit if no text
	if (_text_length == 0) {
		// Clear all words
		for (var _i = 0; _i < rich_word_count; _i++) {
			rich_word[_i] = undefined;
		}
		array_resize(rich_word, 0);
		rich_word_count = 0;
		rich_word_rebuild_required = false;
		return;
	}
	
	// Parse text to extract word information
	var _new_words = [];
	var _new_word_count = 0;
	var _current_word_start = -1;
	var _current_word_text = "";
	var _word_index = 0;
	
	// Iterate through each character to find words
	for (var _i = 1; _i <= _text_length; _i++) {
		var _char = string_char_at(_text, _i);
		var _char_index = _i - 1;  // Convert to 0-indexed
		
		if (_char == " " || _char == "\n" || _char == "\t") {
			// Space or whitespace - end current word if any
			if (_current_word_start != -1) {
				// Store completed word
				_new_words[_new_word_count] = {
					text: _current_word_text,
					start: _current_word_start,
					count: _char_index - _current_word_start,
					word_idx: _word_index
				};
				_new_word_count++;
				_word_index++;
				
				// Reset word tracking
				_current_word_start = -1;
				_current_word_text = "";
			}
		}
		else {
			// Non-space character
			if (_current_word_start == -1) {
				// Start new word
				_current_word_start = _char_index;
				_current_word_text = _char;
			}
			else {
				// Continue current word
				_current_word_text += _char;
			}
		}
	}
	
	// Store final word if text doesn't end with space
	if (_current_word_start != -1) {
		_new_words[_new_word_count] = {
			text: _current_word_text,
			start: _current_word_start,
			count: _text_length - _current_word_start,
			word_idx: _word_index
		};
		_new_word_count++;
	}
	
	// Diff-based update: compare new words with existing
	var _old_count = rich_word_count;
	var _min_count = min(_old_count, _new_word_count);
	
	// Update existing words that match
	for (var _i = 0; _i < _min_count; _i++) {
		var _existing_word = rich_word[_i];
		var _new_data = _new_words[_i];
		
		// Check if word changed
		var _word_changed = (_existing_word.word_text != _new_data.text);
		var _position_changed = (_existing_word.char_start_index != _new_data.start) ||
		                         (_existing_word.char_count != _new_data.count);
		
		// Update word data
		if (_word_changed) {
			_existing_word.word_text = _new_data.text;
		}
		
		if (_position_changed) {
			_existing_word.char_start_index = _new_data.start;
			_existing_word.char_count = _new_data.count;
		}
		
		_existing_word.word_index = _new_data.word_idx;
		
		// Update line (get from first character)
		if (_new_data.start < rich_character_count) {
			_existing_word.line = rich_character[_new_data.start].line;
		}
	}
	
	// Handle word array growth (new words added)
	if (_new_word_count > _old_count) {
		for (var _i = _old_count; _i < _new_word_count; _i++) {
			var _new_data = _new_words[_i];
			
			// Create new word struct
			var _new_word = new TextRichWord();
			_new_word.word_text = _new_data.text;
			_new_word.word_index = _new_data.word_idx;
			_new_word.char_start_index = _new_data.start;
			_new_word.char_count = _new_data.count;
			
			// Get line from first character
			if (_new_data.start < rich_character_count) {
				_new_word.line = rich_character[_new_data.start].line;
			}
			
			// Add to rich_word array
			rich_word[_i] = _new_word;
		}
	}
	// Handle word array shrinkage (words removed)
	else if (_new_word_count < _old_count) {
		// Clear references for garbage collection
		for (var _i = _new_word_count; _i < _old_count; _i++) {
			rich_word[_i] = undefined;
		}
		
		// Resize array
		array_resize(rich_word, _new_word_count);
	}
	
	// Update word count
	rich_word_count = _new_word_count;
	
	// Reset rebuild flag
	rich_word_rebuild_required = false;
}
