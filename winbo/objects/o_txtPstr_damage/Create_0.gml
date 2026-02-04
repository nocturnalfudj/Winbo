// Inherit the parent event
event_inherited();

if(o_ui.game_text_poster_damage_enable == false)
	instance_destroy();

gui = false;

//Colour
transform_set(transform[TransformType.anchor],TransformValue.colour,c_flat_red_monza);

#region Dimensions
	width_max = 100;

	width_min = 0;
	height_min = 0;

	width_buff = 10;
	height_buff = 10;
#endregion

#region Text
	//Text
	text = noone;//new Text(TextGroup.ui,200);		//"IDLE"
	text_string = "1";//text.value;
	text_string_prev = text_string + "a";
	
	//Prefix
	prefix = noone;		//new Text(TextGroup.ui,200);		//"IDLE"
	prefix_string = "-";//text.value;
	prefix_string_prev = prefix_string + "a";
	
	//Final
	text_final_string = prefix_string + text_string + suffix_string;
	text_final_string_prev = text_final_string;
	
	//Font
	font = fnt_default_38;
	alignment_h = fa_center;
	alignment_v = fa_middle;
	
	sep = -1;

	//Shadow
	shadow_enable = true;
	shadow_x = -3;
	shadow_y = 3;
	shadow_c = c_black;//c_flat_red_monza;

	//Dimensions
	text_ui_set_width_height_pre_scale();
	width = width_pre_scale* image_xscale;
	height = height_pre_scale * image_yscale;
#endregion


//Flash
flash_alpha = 0;

#region Appear Animation
	transform_animate_grow_and_appear(0.15*SECOND,ease_back_out);
	appear_y_distance = -200;
	transform_animate_from_current_relative(transform[TransformType.anchor],TransformValue.y,appear_y_distance,0,SECOND*1,ease_quad_in,false,true);
#endregion

//Critical
critical = false;
critical_super = false;

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_game_create_main;
	
	state_script[UIState.idle][UIStateStage.main] = txtPstr_damage_idle_main;
	
	state_script[UIState.destroy][UIStateStage.main] = txtPstr_damage_destroy_main;
#endregion

//Light
tracking_light = lighting_light_create_track(spr_light_circular,c_white,"lyr_lighting",0.5,0.5,0,0,0,1);