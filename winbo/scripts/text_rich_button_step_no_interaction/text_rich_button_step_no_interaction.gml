/// @function text_rich_button_step_no_interaction
/// @summary Step logic for rich text buttons when interaction is disabled
/// @returns {void}
function text_rich_button_step_no_interaction() {
	//Update Text Strings
	text_ui_text_strings_update();
	
	//Check if text changed - trigger rebuild (RICH TEXT)
	if(text_final_string != text_final_string_prev){
		rich_character_rebuild_required = true;
		rich_word_rebuild_required = true;
		text_ui_set_width_height_pre_scale();
		calculate_dimensions = true;
	}
	
	//Handle character rebuild BEFORE transform update (RICH TEXT)
	if(rich_character_rebuild_required){
		text_rich_rebuild_characters();
	}
	
	// Process continuous effects (RICH TEXT)
	text_rich_step_continuous_effects();
	
	//Transform system update (parent)
	transform_system_update();
	
	//Update each rich character's own transform (RICH TEXT)
	for(var _i = 0; _i < rich_character_count; _i++){
		with(rich_character[_i]){
			transform_system_update();
		}
	}
	
	//Updated Transform So Dimensions Need to be Recalculated
	if(transform_updated){
		calculate_dimensions = true;
	}

	//Recalculate Dimensions
	if(calculate_dimensions){
		text_button_dimensions();  // TEXT BUTTON dimensions
		
		//Camera Visible Dimensions
		camera_visible_dimensions();
	}

	//Set Previous Text Strings
	text_ui_text_strings_prev_update();
}
