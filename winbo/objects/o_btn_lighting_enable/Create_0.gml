// Inherit the parent event
event_inherited();

//Toggle
toggle_enable = true;
button_toggle_set(o_camera.lighting_enable);

#region Image
	toggle_sprite_false = spr_btn_generic_off;
	toggle_sprite_true = spr_btn_generic_on;
	sprite_current = toggle? toggle_sprite_true : toggle_sprite_false;
#endregion

#region Text
	#region Title
		title_enable = true;
		
		title_text = noone;
		title_string = "Lighting System Toggle";

		title_x = 0;
		title_y = -120
	#endregion
#endregion

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_tab_settings_display_create_main_scroll;
	state_script[UIState.active][UIStateStage.main] = btn_lighting_enable_active_main;
#endregion