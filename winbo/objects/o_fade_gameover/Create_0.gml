// Inherit the parent event
event_inherited();

//Fade
fade_factor = 0.5;

#region Blur
	//Create Blur
	blur_area_id = blur_area_create();
#endregion

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_gameover_create_main;
#endregion