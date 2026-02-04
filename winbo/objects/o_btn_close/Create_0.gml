// Inherit the parent event
event_inherited();

#region Image
	sprite_current = spr_btn_close;
#endregion

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_tab_home_create_main;
	state_script[UIState.active][UIStateStage.main] = btn_close_active_main;
#endregion