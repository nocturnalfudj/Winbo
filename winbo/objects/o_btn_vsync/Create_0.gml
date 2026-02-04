// Inherit the parent event
event_inherited();

//Toggle
toggle_enable = true;
button_toggle_set(o_camera.vsync);

#region Image
	toggle_sprite_false = spr_btn_vsync_off;
	toggle_sprite_true = spr_btn_vsync_on;
	sprite_current = toggle? toggle_sprite_true : toggle_sprite_false;
#endregion

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_tab_settings_display_create_main_scroll;
	state_script[UIState.active][UIStateStage.main] = btn_vsync_active_main;
#endregion