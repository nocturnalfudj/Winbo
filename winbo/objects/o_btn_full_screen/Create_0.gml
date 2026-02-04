// Inherit the parent event
event_inherited();

//Toggle
toggle_enable = true;
button_toggle_set(o_camera.fullscreen);

#region Image
	toggle_sprite_false = spr_btn_full_screen_off;
	toggle_sprite_true = spr_btn_full_screen_on;
	sprite_current = toggle? toggle_sprite_true : toggle_sprite_false;
#endregion

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_tab_settings_display_create_main_scroll;
	state_script[UIState.active][UIStateStage.main] = btn_full_screen_active_main;
#endregion