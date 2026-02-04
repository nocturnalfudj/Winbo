
// Inherit the parent event
event_inherited();

//Enable Transform Relative
transform_system_relative_enable();

//Team
team = noone;
is_player = false;

//Name
name = random_name_generator_character("human",choose(false,true));
character_name = "CHARACTER";

#region Face
	face_horizontal = 1;
	face_vertical = 1;

	face_horizontal_update_enable = true;
	face_vertical_update_enable = true;

	face_horizontal_draw_enable = true;
	face_vertical_draw_enable = false;

	// Sprite facing direction: 1 = sprites face RIGHT by default, -1 = sprites face LEFT by default
	sprite_face_direction = 1;
#endregion

#region Movement
	//Gravity
	movement_gravity_enable();
	move_gravity_rise_fall_enable = true;
	move_gravity_rise_lerp = 0.4;
	move_gravity_fall_lerp = 0.05;
	move_gravity_dash_lerp = 0.5;
	move_gravity_float_lerp = 0.5;
	move_gravity_rise = new Vector2(0,0.5);
	move_gravity_fall = new Vector2(0,7);
	move_gravity_dash = new Vector2(0,0);
	move_gravity_float = new Vector2(0,0.4);
	
	//Grounded
	move_grounded_check = true;
	move_grounded_close_check = true;
	
	//Effects
	movement_effects_enable();
	move_effects_velocity_percent_max = 1;
	wobble_enable = true;
	speed_stretch_scale.Set(0.2,-0.2);
	//acceleration_sway_enable = true;
	//acceleration_sway_max = 5;
	//acceleration_sway_lerp_val = 0.3;
	
	//Trapped
	move_trapped_check = false;
	move_trapped_free_self = true;
	move_trapped_acceleration_direction = 1;
	
	//Pushback
	pushback_enable = true;
	pushback_radius = 1000;
	pushback_acceleration = 3;
	
	//Stationary
	stationary = false;
	stationary_time = 0;
	
	//Roam
	roam_active = true;
	roam_active_countdown_max = SECOND * 1;
	roam_active_countdown_min = SECOND * 0.5;
	roam_active_countdown = roam_active_countdown_max * 2;
	roam_x = random(100);
	roam_increase = 0.5;
	
	//Jump Hold
	jump_hold_enable = false;
	jump_hold_allow_countdown_max = SECOND * 0.2;
	jump_hold_allow_countdown = jump_hold_allow_countdown_max;
	
	//Float
	float_countdown_max = SECOND * 2;
	float_countdown = float_countdown_max;
	
	//Spring
	spring_countdown = 0;
	#macro SPRING_COUNTDOWN_MAX 0.2 * SECOND
#endregion

#region Input
	//Aim Direction
	input_aim_direction = 0;
	input_aim_magnitude = 0;
	input_aim_target_x = x + lengthdir_x(GAMEPAD_DIST_MAX,input_aim_direction);
	input_aim_target_y = y + lengthdir_y(GAMEPAD_DIST_MAX,input_aim_direction);
#endregion

#region Dash
	dash_enable = false;
	dash_state = noone;

	//Duration
	dash_countdown = 0;
	dash_countdown_max = 0.035 * SECOND;
	
	//Cooldown
	dash_cooldown = 0;
	dash_cooldown_max = 0.1 * SECOND;
	dash_cooldown_invincible_duration = 0.1 * SECOND;
	
	//Movement
	dash_velocity_retention = 0.9;
	dash_acceleration = 30;
	
	//Combat
	dash_damage = 5;
	dash_range = 300;
	dash_knockback = 100;
	
	//Stamina
	dash_stamina_max = 90;
	dash_stamina = dash_stamina_max;
	dash_stamina_cost = 30;
	dash_stamina_recovery_rate = dash_stamina_cost / SECOND;
	dash_stamina_depleted = false;
	
	//Hold
	dash_hold_enable = false;
	dash_hold_check_countdown_max = SECOND*0.1;
	dash_hold_check_countdown = dash_hold_check_countdown_max;
	dash_hold_allow_countdown_max = SECOND * 0.2;
	dash_hold_allow_countdown = dash_hold_allow_countdown_max;
	
	//Icon
	dash_icon_enable = false;
	dash_icon_x = 150;
	dash_icon_y = - 250;
	dash_icon_scale = 0;
	dash_icon_animation_start = 0;
	dash_icon_animation_target = 0;
	dash_icon_animation_time_current = 0;
	dash_icon_animation_time_max = 0.3 * SECOND;
	dash_icon_flash_alpha = 0;
	dash_icon_flash_alpha_target = 0;
	dash_icon_flash_colour = c_white;
	dash_icon_flash_lerp_val = 0.25;
	dash_icon_width = sprite_get_width(spr_character_dash_fill);
	dash_icon_height = sprite_get_height(spr_character_dash_fill);
#endregion

#region Health
	//HP System
	hp_system_create();

	hp_enable = true;
	hp = 30;
	hp_set_max(hp,true);
	hp_percent = hp/hp_max;
	
	hp_regen_circle_sprite = noone;
	hp_regen_circle_scale = 0;
	hp_regen_circle_scale_target = 0;
#endregion

#region Interact
	//Create the System
	interact_system_create();
	
	//Disable Interact by Default
	interact_enable = false;
	
	//Interactor
	interact_system_create_interactor();
#endregion

#region Status Effects
	//Create System
	status_effect_system_create();
	
	//Fire
	fire_damage_resistance = 0;
	fire_spread_range_factor = 1;
#endregion

#region PFX
	//Create System
	pfx_system_create();
#endregion

//Torch
torch_light = noone;

#region Info Bar
	info_bar_enable = true;
	
	info_bar_section_enable[InfoBarSection.hp_bar] = true;
#endregion

//Draw Adjustment
draw_adjustment_x = 0;
draw_adjustment_y = 0;