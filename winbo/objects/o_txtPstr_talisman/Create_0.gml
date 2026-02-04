// Inherit the parent event
event_inherited();

if(o_ui.game_text_poster_heal_enable == false)
	instance_destroy();

gui = false;

//Colour
transform_set(transform[TransformType.anchor],TransformValue.colour,c_flat_blue_deep_sky_blue);

#region Dimensions
	width_max = 1000;

	width_min = 0;
	height_min = 0;

	width_buff = 10;
	height_buff = 10;
#endregion

#region Text
	//Text
	text = noone;//new Text(TextGroup.ui,200);		//"IDLE"
	text_string = "Talisman found!";//text.value;
	text_string_prev = text_string + "a";
	
	//Final
	text_final_string = prefix_string + text_string + suffix_string;
	text_final_string_prev = text_final_string;
	
	//Font
	font = fnt_default_38;
	alignment_h = fa_center;
	alignment_v = fa_middle;

	//Shadow
	shadow_enable = true;
	shadow_x = -5;
	shadow_y = 5;
	shadow_c = c_black;//c_flat_red_monza;

	//Dimensions
	text_ui_set_width_height_pre_scale();
	width = width_pre_scale* image_xscale;
	height = height_pre_scale * image_yscale;
#endregion

//Appear
transform_animate_grow_and_appear(0.15*SECOND,ease_back_out);
transform_animate_from_current_relative(transform[TransformType.anchor],TransformValue.y,-100,0,SECOND*0.5,ease_quad_in,false,true);

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_game_create_main;
	
	state_script[UIState.idle][UIStateStage.main] = txtPstr_talisman_idle_main;
#endregion

//Light
lighting_light_create_track(spr_light_circular,c_flat_yellow_energy_yellow,"lyr_lighting",0.5,0.5,0,0,0,1);