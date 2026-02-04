// Inherit the parent event
event_inherited();

sprite_current = sprite_index;

#region Title System
	title_system_create();
	
	#region Title
		title_enable = true;
		title_text = noone;
		title_string = string(o_director.resource[Resource.winbo_lives][Team.player]);
		title_font = fnt_default_64;
		title_colour = c_white;
		title_halign = fa_left;
		title_valign = fa_bottom;
		title_x = 190;
		title_y = 64;
		title_width = 1000;
		
		//Shadow
		title_shadow_enable = false;
		title_shadow_colour = c_black;
		title_shadow_x = 3;
		title_shadow_y = 3;
		title_shadow_alpha = 0.75;
	#endregion
	
	#region Subtitle
		subtitle_enable = true;
		subtitle_text = noone;
		subtitle_string = "x";
		subtitle_font = fnt_default_42;
		subtitle_colour = c_white;
		subtitle_halign = fa_center;
		subtitle_valign = fa_bottom;
		subtitle_x = 160;
		subtitle_y = 60;
		subtitle_width = 1000;
		
		//Shadow
		subtitle_shadow_enable = false;
		subtitle_shadow_colour = c_black;
		subtitle_shadow_x = 3;
		subtitle_shadow_y = 3;
		subtitle_shadow_alpha = 0.75;
	#endregion
#endregion

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_hud_create_main;
#endregion