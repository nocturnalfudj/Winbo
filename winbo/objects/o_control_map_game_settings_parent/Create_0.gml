// Inherit the parent event
event_inherited();

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_tab_settings_input_create_main;
#endregion