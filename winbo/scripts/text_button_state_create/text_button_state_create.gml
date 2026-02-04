function text_button_state_create() {
	//Remove Sprite Index
	sprite_index = noone;
	
	//Transform Update Scale
	transform_system_update_scale();
	
	//Update Text Strings
	text_ui_text_strings_update();
	
	//Dimensions
	text_ui_set_width_height_pre_scale();
	text_button_dimensions();
	
	//Camera Visible Dimensions
	camera_visible_dimensions();

	//State to Idle
	ui_object_state_set(UIState.idle);

	//Custom Script
	ui_object_state_script_stage_execute(UIState.create,UIStateStage.main);
	ui_object_state_script_stage_execute(UIState.create,UIStateStage.stop);
}