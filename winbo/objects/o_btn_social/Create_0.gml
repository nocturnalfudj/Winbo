// Inherit the parent event
event_inherited();

#region Image
	sprite_current = sprite_index;
#endregion

//URL
url = "";

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_tab_home_create_main;
	state_script[UIState.active][UIStateStage.main] = btn_social_active_main;
#endregion