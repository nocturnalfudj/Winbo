// Inherit the parent event
event_inherited();

//Fade
fade_factor = 1;

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_advert_create_main;
#endregion