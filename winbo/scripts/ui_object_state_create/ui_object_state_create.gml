function ui_object_state_create() {
	//Transform Update Scale
	transform_system_update_scale();
	
	//Dimensions
	dimensions_system_update(sprite_current);
	
	//Camera Visible Dimensions
	camera_visible_dimensions();

	//State to Idle
	ui_object_state_set(UIState.idle);

	//Custom Script
	ui_object_state_script_stage_execute(UIState.create,UIStateStage.main);
	ui_object_state_script_stage_execute(UIState.create,UIStateStage.stop);
}