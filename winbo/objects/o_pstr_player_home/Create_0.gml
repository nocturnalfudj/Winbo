// Inherit the parent event
event_inherited();

#region Image
	sprite_current = sprite_index;
	
	//Image System
	image_system_create();
	image_system_setup(sprite_current, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
#endregion

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_tab_home_create_main;
	state_script[UIState.idle][UIStateStage.main] = pstr_player_home_idle_main;
#endregion
