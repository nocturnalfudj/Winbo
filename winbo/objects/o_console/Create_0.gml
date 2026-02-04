//State
enum ConsoleState{
	create,
	idle,
	active
}
state = ConsoleState.create;

#region Game State Operate
	//Full Step in All Game States
	for(var _i=0;_i<GameState.SIZE;_i++){
		game_state_operate[_i] = UIGameStateOperate.full_step;
	}
#endregion

//Remove Sprite
image_index = noone;

//X & Y Position
x = 0;
y = display_get_gui_height();

//Create Dimensions System
dimension_system_create();

//Camera Visible System
camera_visible_system_create();

#region Transform
	//Create Transform System
	transform_system_create();

	//Transform Child
transform_system_new_transform_child();
	
	//Transform Update Scale
	transform_system_update_scale();

	//Set to Black
	transform_set(transform[TransformType.anchor],TransformValue.colour,c_black,false);
#endregion

//Dimensions
dimensions_system_update(spr_console_text_field);
bounding_box_height = display_get_gui_height();
height = bounding_box_height * image_yscale;

#region Log
	log = ds_list_create();
	log_colour = ds_list_create();
	
	#macro CONSOLE_LOG_MAX 500
		
	#macro CONSOLE_LOG_FONT fnt_bahnschrift_16
	#macro CONSOLE_LOG_ALIGN_H fa_left
	#macro CONSOLE_LOG_ALIGN_V fa_top

	draw_set_font(CONSOLE_LOG_FONT);
	draw_set_halign(CONSOLE_LOG_ALIGN_H);
	draw_set_valign(CONSOLE_LOG_ALIGN_V);
	log_sep = string_height_ext("|T",0,1000);
	log_sep_message = log_sep/4;

	log_save_quit = false;
	log_save_quit_num = 0;
	
	log_draw_start_pos = 0;
	
	#macro LOG_COLOUR_COMMAND			c_flat_green_malachite
	#macro LOG_COLOUR_COMMAND_ERROR		c_ags_red
	#macro LOG_COLOUR_COMMAND_ANALYSE	c_flat_blue_deep_sky_blue
	#macro LOG_COLOUR_COMMAND_SUCCESS	c_flat_purple_electric_purple
#endregion

#region Text Field
	#macro CONSOLE_TXTFLD_ENABLE true
	#macro CONSOLE_TXTFLD_LOG_BUFF_Y 10
	text_field_id = noone;
	text_field_height = 0;
	
	if(CONSOLE_TXTFLD_ENABLE){		
		var _x,_y,_console_transform_child;
		_x = 0;
		_y = -sprite_get_height(spr_console_text_field)/2;
		text_field_id = instance_create_layer(_x,_y,layer,o_console_text_field);
		_console_transform_child = transform_child[0];
		
		with(text_field_id){
			transform_parent = _console_transform_child;
		}
		
		text_field_height = _y*2;
	}
#endregion

#region Scroll
	scroll = new Scroll(x,y);
	scroll.position_clamp_enable_y = false;
	scroll.transform_parent = transform_child[0];
	
	scroll_drag_start_log_pos = 0;
#endregion

//Autofill Help
command_autofill_help_enable = false;

#region Commands
	command_text = "";

	command_analyse = false;

	command_subject_list = ds_list_create();
	command_action_list = ds_list_create();
	command_argument_list = ds_list_create();

	#region Subject Types
		enum CMDSubject{
			instance_object,
			instance,
			object,
			app,
			game,
			player,
			settings,
			camera,
			rm,
			
			SIZE
		}
		
		command_subject[CMDSubject.instance_object] = new CommandSubject("");
		command_subject[CMDSubject.instance] = new CommandSubject("i.");
		command_subject[CMDSubject.object] = new CommandSubject("o.");
		command_subject[CMDSubject.app] = new CommandSubject("app");
		command_subject[CMDSubject.game] = new CommandSubject("game");
		command_subject[CMDSubject.player] = new CommandSubject("player");
		command_subject[CMDSubject.settings] = new CommandSubject("settings");
		command_subject[CMDSubject.camera] = new CommandSubject("camera");
		command_subject[CMDSubject.rm] = new CommandSubject("room");
	#endregion

	#region Actions
		var _action,_string,_script,_argument_num,_argument_slot;
	
		#region Instance/Object Actions
			with(command_subject[CMDSubject.instance_object]){
				#region set_var
					_string = "set_var";
					_script = cmd_instance_object_set_var;
					_argument_num = 2;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region set_x
					_string = "set_x";
					_script = cmd_instance_object_set_x;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion

				#region set_y
					_string = "set_y";
					_script = cmd_instance_object_set_y;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Destroy
					_string = "destroy";
					_script = cmd_instance_object_destroy;
					_argument_num = 0;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Camera Follow
					_string = "camera_follow";
					_script = cmd_instance_object_camera_follow;
					_argument_num = 0;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Image Sprite
					_string = "image_sprite";
					_script = cmd_instance_object_image_sprite;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Image Animate
					_string = "image_animate";
					_script = cmd_instance_object_image_animate;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "true";
						argument_autofill[_argument_slot][1] = "false";
					}
				#endregion
				
				#region Image Loop
					_string = "image_loop";
					_script = cmd_instance_object_image_loop;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "true";
						argument_autofill[_argument_slot][1] = "false";
					}
				#endregion
				
				#region Image FPS
					_string = "image_fps";
					_script = cmd_instance_object_image_fps;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Transform Set
					_string = "transform_set";
					_script = cmd_instance_object_transform_set;
					_argument_num = 4;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "anchor";
						argument_autofill[_argument_slot][1] = "relative";
						
						_argument_slot = 1;
						argument_autofill[_argument_slot][0] = "x";
						argument_autofill[_argument_slot][1] = "y";
						argument_autofill[_argument_slot][2] = "xscale";
						argument_autofill[_argument_slot][3] = "yscale";
						argument_autofill[_argument_slot][4] = "alpha";
						argument_autofill[_argument_slot][5] = "angle";
						argument_autofill[_argument_slot][6] = "colour";
						
						_argument_slot = 3;
						argument_autofill[_argument_slot][0] = "true";
						argument_autofill[_argument_slot][1] = "false";
					}
				#endregion
				
				#region Transform Recoil
					_string = "transform_recoil";
					_script = cmd_instance_object_transform_recoil;
					_argument_num = 2;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "anchor";
						argument_autofill[_argument_slot][1] = "relative";
						
						_argument_slot = 1;
						argument_autofill[_argument_slot][0] = "x";
						argument_autofill[_argument_slot][1] = "y";
						argument_autofill[_argument_slot][2] = "xscale";
						argument_autofill[_argument_slot][3] = "yscale";
						argument_autofill[_argument_slot][4] = "alpha";
						argument_autofill[_argument_slot][5] = "angle";
						argument_autofill[_argument_slot][6] = "colour";
					}
				#endregion
				
				#region Movement Accelerate
					_string = "move_accelerate";
					_script = cmd_instance_object_move_accelerate;
					_argument_num = 2;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Movement Acceleration Max
					_string = "move_acceleration_max";
					_script = cmd_instance_object_move_acceleration_max;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Movement Velocity
					_string = "move_velocity";
					_script = cmd_instance_object_move_velocity;
					_argument_num = 2;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Movement Velocity Retention
					_string = "move_velocity_retention";
					_script = cmd_instance_object_move_velocity_retention;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Movement Gravity
					_string = "move_gravity";
					_script = cmd_instance_object_move_gravity;
					_argument_num = 2;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Movement Gravity Enable
					_string = "move_gravity_enable";
					_script = cmd_instance_object_move_gravity_enable;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "true";
						argument_autofill[_argument_slot][1] = "false";
					}
				#endregion
				
				#region Movement Gravity Rise Fall Enable
					_string = "move_gravity_rise_fall_enable";
					_script = cmd_instance_object_move_gravity_rise_fall_enable;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "true";
						argument_autofill[_argument_slot][1] = "false";
					}
				#endregion
				
				#region Movement Gravity Rise
					_string = "move_gravity_rise";
					_script = cmd_instance_object_move_gravity_rise;
					_argument_num = 2;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Movement Gravity Rise Lerp
					_string = "move_gravity_rise_lerp";
					_script = cmd_instance_object_move_gravity_rise_lerp;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Movement Gravity Fall
					_string = "move_gravity_fall";
					_script = cmd_instance_object_move_gravity_fall;
					_argument_num = 2;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Movement Gravity Fall Lerp
					_string = "move_gravity_fall_lerp";
					_script = cmd_instance_object_move_gravity_fall_lerp;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Movement Effects Percent Max
					_string = "move_effects_percent_max";
					_script = cmd_instance_object_move_effects_percent_max;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Movement Speed Stretch Scale
					_string = "move_speed_stretch_scale";
					_script = cmd_instance_object_move_speed_stretch_scale;
					_argument_num = 2;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Movement Speed Stretch Enable
					_string = "move_speed_stretch_enable";
					_script = cmd_instance_object_move_speed_stretch_enable;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "true";
						argument_autofill[_argument_slot][1] = "false";
					}
				#endregion
				
				#region Movement Speed Stretch Scale
					_string = "move_wobble_scale";
					_script = cmd_instance_object_move_wobble_scale;
					_argument_num = 2;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Movement Wobble Enable
					_string = "move_wobble_enable";
					_script = cmd_instance_object_move_wobble_enable;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "true";
						argument_autofill[_argument_slot][1] = "false";
					}
				#endregion
				
				action_num = ds_list_size(action_list);
			}
		#endregion

		#region Instance Actions
			with(command_subject[CMDSubject.instance]){
				
				action_num = ds_list_size(action_list);
			}
		#endregion

		#region Object Actions
			with(command_subject[CMDSubject.object]){
				
				action_num = ds_list_size(action_list);
			}
		#endregion
	
		#region App Actions
			with(command_subject[CMDSubject.app]){
				#region Close
					_string = "close";
					_script = cmd_app_close;
					_argument_num = 0;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion

				#region Restart
					_string = "restart";
					_script = cmd_app_restart;
					_argument_num = 0;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion

				#region Freeze
					_string = "freeze";
					_script = cmd_app_freeze;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "true";
						argument_autofill[_argument_slot][1] = "false";
					}
				#endregion

				#region ID Show
					_string = "id_show";
					_script = cmd_app_id_show;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "true";
						argument_autofill[_argument_slot][1] = "false";
						argument_autofill[_argument_slot][2] = "mouse";
						argument_autofill[_argument_slot][3] = "all";
					}
				#endregion

				#region Command Analysis
					_string = "command_analyse";
					_script = cmd_app_command_analyse;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "true";
						argument_autofill[_argument_slot][1] = "false";
					}
				#endregion

				#region Text Sheet Print
					_string = "text_sheet_print";
					_script = cmd_app_text_sheet_print;
					_argument_num = 3;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "ui";
						
						_argument_slot = 1;
						argument_autofill[_argument_slot][0] = "current";
						argument_autofill[_argument_slot][1] = "default";
					}
				#endregion

				#region Text Sheet Save
					_string = "text_sheet_save";
					_script = cmd_app_text_sheet_save;
					_argument_num = 2;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "ui";
						argument_autofill[_argument_slot][1] = "all";
						
						_argument_slot = 1;
						argument_autofill[_argument_slot][0] = "current";
						argument_autofill[_argument_slot][1] = "default";
					}
				#endregion

				#region Log Save
					_string = "log_save";
					_script = cmd_app_log_save;
					_argument_num = 2;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "all";
						
						_argument_slot = 1;
						argument_autofill[_argument_slot][0] = "now";
						argument_autofill[_argument_slot][1] = "close";
					}
				#endregion

				#region Log Clear
					_string = "log_clear";
					_script = cmd_app_log_clear;
					_argument_num = 0;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				action_num = ds_list_size(action_list);
			}
		#endregion
	
		#region Game Actions
			with(command_subject[CMDSubject.game]){
				#region HUD Enable
					_string = "hud";
					_script = cmd_game_hud;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "true";
						argument_autofill[_argument_slot][1] = "false";
					}
				#endregion
				
				#region Spawn
					_string = "spawn";
					_script = cmd_game_spawn;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Spawn EXT
					_string = "spawn_ext";
					_script = cmd_game_spawn_ext;
					_argument_num = 4;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
			#region Level Start
				_string = "level_start";
				_script = cmd_game_level_start;
				_argument_num = 1;
				_action = new CommandAction(_string,_script,_argument_num);
				ds_list_add(action_list,_action);
				// Autofill populated dynamically by level_select_register
			#endregion
			
			#region Level Unlock
				_string = "level_unlock";
				_script = cmd_game_level_unlock;
				_argument_num = 1;
				_action = new CommandAction(_string,_script,_argument_num);
				ds_list_add(action_list,_action);
				with(_action){
					_argument_slot = 0;
					argument_autofill[_argument_slot][0] = "all";
				}
				// Additional autofill populated dynamically by level_select_register
			#endregion
			
			#region Level Stats
					_string = "level_stats";
					_script = cmd_game_level_stats;
					_argument_num = 0;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Level Stat Set
					_string = "level_stat_set";
					_script = cmd_game_level_stat_set;
					_argument_num = 2;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "orbs_collected";
						argument_autofill[_argument_slot][1] = "lives_collected";
						argument_autofill[_argument_slot][2] = "talismans_collected";
						argument_autofill[_argument_slot][3] = "enemies_defeated_melee";
						argument_autofill[_argument_slot][4] = "enemies_defeated_ranged";
						argument_autofill[_argument_slot][5] = "enemies_defeated_flying";
						argument_autofill[_argument_slot][6] = "hits_taken";
						argument_autofill[_argument_slot][7] = "deaths";
					}
				#endregion
				
				#region Level Stats Reset
					_string = "level_stats_reset";
					_script = cmd_game_level_stats_reset;
					_argument_num = 0;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Level Score
					_string = "level_score";
					_script = cmd_game_level_score;
					_argument_num = 0;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Level Score Config
					_string = "level_score_config";
					_script = cmd_game_level_score_config;
					_argument_num = 0;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
			
				
			
				action_num = ds_list_size(action_list);
			}
		#endregion
	
		#region Player Actions
			with(command_subject[CMDSubject.player]){
				
				action_num = ds_list_size(action_list);
			}
		#endregion
	
		#region Settings Actions
			with(command_subject[CMDSubject.settings]){
				#region VSync
					_string = "vsync";
					_script = cmd_settings_vsync;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "true";
						argument_autofill[_argument_slot][1] = "false";
					}
				#endregion
				
				#region Anti Aliasing
					_string = "anti_aliasing";
					_script = cmd_settings_anti_aliasing;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "0";
						argument_autofill[_argument_slot][1] = "2";
						argument_autofill[_argument_slot][2] = "4";
						argument_autofill[_argument_slot][3] = "8";
					}
				#endregion
				
				#region Resolution
					_string = "resolution";
					_script = cmd_settings_resolution;
					_argument_num = 2;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Fullscreen
					_string = "fullscreen";
					_script = cmd_settings_fullscreen;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "true";
						argument_autofill[_argument_slot][1] = "false";
					}
				#endregion
				
				#region Language
					_string = "language";
					_script = cmd_settings_language;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region PFX
					_string = "pfx";
					_script = cmd_settings_pfx;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Audio Volume
					_string = "audio_volume";
					_script = cmd_settings_audio_volume;
					_argument_num = 2;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "master";
						argument_autofill[_argument_slot][1] = "music";
						argument_autofill[_argument_slot][2] = "sfx";
						
						_argument_slot = 1;
						argument_autofill[_argument_slot][0] = "0";
						argument_autofill[_argument_slot][1] = "25";
						argument_autofill[_argument_slot][2] = "50";
						argument_autofill[_argument_slot][3] = "75";
						argument_autofill[_argument_slot][4] = "100";
					}
				#endregion
				
				#region Audio Mute
					_string = "audio_mute";
					_script = cmd_settings_audio_mute;
					_argument_num = 2;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "master";
						argument_autofill[_argument_slot][1] = "music";
						argument_autofill[_argument_slot][2] = "sfx";
						
						_argument_slot = 1;
						argument_autofill[_argument_slot][0] = "true";
						argument_autofill[_argument_slot][1] = "false";
					}
				#endregion
				
				action_num = ds_list_size(action_list);
			}
		#endregion
		
		#region Camera Actions
			with(command_subject[CMDSubject.camera]){
				#region State
					_string = "state";
					_script = cmd_camera_state;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "idle";
						argument_autofill[_argument_slot][1] = "follow";
						argument_autofill[_argument_slot][2] = "stationary";
						argument_autofill[_argument_slot][2] = "move";
					}
				#endregion
				
				#region Shake
					_string = "shake";
					_script = cmd_camera_shake;
					_argument_num = 2;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Shake Factor
					_string = "shake_factor";
					_script = cmd_camera_shake_factor;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Follow Offset
					_string = "follow_offset";
					_script = cmd_camera_follow_offset;
					_argument_num = 2;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Follow Method
					_string = "follow_method";
					_script = cmd_camera_follow_method;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "lerp";
						argument_autofill[_argument_slot][1] = "curve";
					}
				#endregion
				
				#region Transform Set
					_string = "transform_set";
					_script = cmd_instance_object_transform_set;
					_argument_num = 4;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "anchor";
						argument_autofill[_argument_slot][1] = "relative";
						
						_argument_slot = 1;
						argument_autofill[_argument_slot][0] = "x";
						argument_autofill[_argument_slot][1] = "y";
						argument_autofill[_argument_slot][2] = "xscale";
						argument_autofill[_argument_slot][3] = "yscale";
						argument_autofill[_argument_slot][4] = "alpha";
						argument_autofill[_argument_slot][5] = "angle";
						argument_autofill[_argument_slot][6] = "colour";
						
						_argument_slot = 3;
						argument_autofill[_argument_slot][0] = "true";
						argument_autofill[_argument_slot][1] = "false";
					}
				#endregion
				
				#region Transform Recoil
					_string = "transform_recoil";
					_script = cmd_instance_object_transform_recoil;
					_argument_num = 2;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "anchor";
						argument_autofill[_argument_slot][1] = "relative";
						
						_argument_slot = 1;
						argument_autofill[_argument_slot][0] = "x";
						argument_autofill[_argument_slot][1] = "y";
						argument_autofill[_argument_slot][2] = "xscale";
						argument_autofill[_argument_slot][3] = "yscale";
						argument_autofill[_argument_slot][4] = "alpha";
						argument_autofill[_argument_slot][5] = "angle";
						argument_autofill[_argument_slot][6] = "colour";
					}
				#endregion
				
				#region Zoom Set
					_string = "zoom_set";
					_script = cmd_camera_zoom_set;
					_argument_num = 3;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "anchor";
						argument_autofill[_argument_slot][1] = "relative";
						
						_argument_slot = 2;
						argument_autofill[_argument_slot][0] = "true";
						argument_autofill[_argument_slot][1] = "false";
					}
				#endregion
				
				#region Zoom Recoil
					_string = "zoom_recoil";
					_script = cmd_camera_zoom_recoil;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "anchor";
						argument_autofill[_argument_slot][1] = "relative";
					}
				#endregion
				
				#region Movement Accelerate
					_string = "move_accelerate";
					_script = cmd_instance_object_move_accelerate;
					_argument_num = 2;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Movement Acceleration Max
					_string = "move_acceleration_max";
					_script = cmd_instance_object_move_acceleration_max;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Movement Velocity
					_string = "move_velocity";
					_script = cmd_instance_object_move_velocity;
					_argument_num = 2;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Movement Velocity Retention
					_string = "move_velocity_retention";
					_script = cmd_instance_object_move_velocity_retention;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				action_num = ds_list_size(action_list);
			}
		#endregion
	
		#region Room Actions
			with(command_subject[CMDSubject.rm]){
				#region Go To
					_string = "go_to";
					_script = cmd_room_go_to;
					_argument_num = 1;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
					with(_action){
						_argument_slot = 0;
						argument_autofill[_argument_slot][0] = "r_game";
					}
				#endregion
				
				#region Restart
					_string = "restart";
					_script = cmd_room_restart;
					_argument_num = 0;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Next
					_string = "next";
					_script = cmd_room_next;
					_argument_num = 0;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				#region Previous
					_string = "previous";
					_script = cmd_room_previous;
					_argument_num = 0;
					_action = new CommandAction(_string,_script,_argument_num);
					ds_list_add(action_list,_action);
				#endregion
				
				action_num = ds_list_size(action_list);
			}
		#endregion
	#endregion
#endregion

#region ID Show
	enum IDShow{
		off,
		everything,
		mouse
	}
	
	id_show = IDShow.off;
	
	id_show_inst = noone;
	id_show_inst_ui = noone;

	#macro ID_SHOW_BACKGROUND_COLOUR c_black
	#macro ID_SHOW_BACKGROUND_ALPHA 0.5
	
	#macro ID_SHOW_INSTANCE_ID_STRING	"instance id: "
	#macro ID_SHOW_OBJECT_ID_STRING		"object id: "
	#macro ID_SHOW_OBJECT_NAME_STRING	"object name: "
	
	#macro ID_SHOW_FONT fnt_bahnschrift_16
	#macro ID_SHOW_ALIGN_H fa_left
	#macro ID_SHOW_ALIGN_V fa_middle
	#macro ID_SHOW_COLOUR c_white
	
	draw_set_font(ID_SHOW_FONT);
	draw_set_halign(ID_SHOW_ALIGN_H);
	draw_set_valign(ID_SHOW_ALIGN_V);
	id_show_sep = string_height_ext("|T",0,1000);
	id_show_sep_message = id_show_sep*1.1;
	
	#macro EPO_CHKYR return 2025;
	#macro EPO_CHKMN return 4;
	#macro EPO_CHK game_end();
	epoch_update();
#endregion

//Remove Sprite
sprite_index = noone;