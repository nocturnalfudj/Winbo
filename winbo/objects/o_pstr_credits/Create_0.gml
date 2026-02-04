// Inherit the parent event
event_inherited();

#region Image
	sprite_current = sprite_index;
#endregion

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_tab_credits_create_main;
#endregion