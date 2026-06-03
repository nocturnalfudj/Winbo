/// @function TextRichWord
/// @description Constructor for a word in rich text, tracking character references
/// @returns {struct} TextRichWord instance
function TextRichWord() constructor {
	// Word data
	word_text = "";              // The word string (for searching/matching)
	word_index = 0;              // Word number in the text (0-indexed)
	
	// Character references
	char_start_index = 0;        // Starting index in rich_character array
	char_count = 0;              // Number of characters in this word
	
	// Layout
	line = 0;                    // Line the word starts on (first char's line)
}
