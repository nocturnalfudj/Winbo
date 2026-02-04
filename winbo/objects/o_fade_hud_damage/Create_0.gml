// Inherit the parent event
event_inherited();

gui = false;

//Fade
fade_factor = 0;
fade_full_screen = true;
fade_follow_camera = true;

fade_factor_target = 0;
fade_factor_target_active = 0.25;

transform_set(transform[TransformType.anchor],TransformValue.colour,c_flat_red_monza,false);

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_hud_create_main;
#endregion