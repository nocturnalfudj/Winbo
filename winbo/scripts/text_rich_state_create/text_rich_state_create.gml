/// @function text_rich_state_create
/// @summary Prepare text_rich for display, build characters, and switch to idle
function text_rich_state_create() {
	//Transform Update Scale
	transform_system_update_scale();
	
	//Update Text Strings
	text_ui_text_strings_update();
	
	//Dimensions
	text_ui_set_width_height_pre_scale();
	text_poster_dimensions();
	
	//Build initial rich character structs
	rich_character_rebuild_required = true;
	text_rich_rebuild_characters();
	
	//Camera Visible Dimensions
	camera_visible_dimensions();

	//State to Idle
	ui_object_state_set(UIState.idle);

	//Custom Script
	ui_object_state_script_stage_execute(UIState.create,UIStateStage.main);
	ui_object_state_script_stage_execute(UIState.create,UIStateStage.stop);
}