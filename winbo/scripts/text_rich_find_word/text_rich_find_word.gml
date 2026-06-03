/// @function text_rich_find_word
/// @description Find a word in the rich text by text string
/// @param {string} _search_text The word text to search for (case-sensitive)
/// @returns {struct|noone} TextRichWord struct if found, noone if not found
function text_rich_find_word(_search_text) {
	// Search through all words
	for (var _i = 0; _i < rich_word_count; _i++) {
		if (rich_word[_i].word_text == _search_text) {
			return rich_word[_i];
		}
	}
	
	// Not found
	return noone;
}
