/// @function text_rich_button_state_create
/// @summary Create state for rich text buttons
/// @returns {void}
function text_rich_button_state_create() {
	// Use text_button create logic as base
	text_button_state_create();
	
	// Additional rich text setup (if needed)
	rich_character_rebuild_required = true;
	rich_word_rebuild_required = true;
}
