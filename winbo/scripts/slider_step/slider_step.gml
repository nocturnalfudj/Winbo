/// @function slider_step
/// @summary Per-step update logic for basic sliders.
function slider_step() {
	//State Switch
	switch(state){
		case UIState.deactivate:
			instance_deactivate_object(id);
		break;

		case UIState.activate:
			ui_object_state_set(UIState.idle);

			//Custom Script
			ui_object_state_script_stage_execute(UIState.activate,UIStateStage.main);
		break;

		case UIState.create:
			slider_state_create();
		break;

		case UIState.idle:
			slider_state_idle();
		break;

		case UIState.hover:
			slider_state_hover();
		break;

		case UIState.down:
			slider_state_down();
		break;

		case UIState.active:
			//State to Idle
			ui_object_state_set(UIState.idle);

			//Custom Script
			ui_object_state_script_stage_execute(UIState.active,UIStateStage.main);
		break;

		case UIState.destroy:
			//Custom Script
			ui_object_state_script_stage_execute(state,UIStateStage.main);
		break;
	}

	//Update Title & Subtitle Strings
	title_system_update();

	//Value Update
	slider_val_update();

	//Transform Update
	slider_transform_update();
}