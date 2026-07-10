// Inherit the parent event
event_inherited();

#region State
	enum PlayerState{
		create,
		stage_entrance,
		bonus_room_enter,
		idle,
		move,
		dash,
		float,
		dive_spring,
		hit,
		death,
		destroy
	}

	state = PlayerState.create;
	
	//States
	move_state = PlayerState.move;
	death_state = PlayerState.death;
	float_state = PlayerState.float;
#endregion

//Character Name
character_name = "PLAYER";

//Team
team = Team.player;
is_player = true;

#region Image
	sprite_idle				= spr_player_idle;			//director_get_custom_sprite(spr_player_idle);
	sprite_walk				= spr_player_walk;			//director_get_custom_sprite(spr_player_idle);
	sprite_dash				= spr_player_dash;			//director_get_custom_sprite(spr_player_dash);
	sprite_fall				= spr_player_fall;			//director_get_custom_sprite(spr_player_fall);
	sprite_fall_sideways	= spr_player_fall_sideways;	//director_get_custom_sprite(sprite_fall_sideways);
	sprite_jump				= spr_player_jump;			//director_get_custom_sprite(spr_player_jump);
	sprite_jump_sideways	= spr_player_jump_sideways;	//director_get_custom_sprite(spr_player_jump_sideways);
	sprite_air_spin			= spr_player_air_spin;
	sprite_land				= spr_player_land;			//director_get_custom_sprite(spr_player_land);
	sprite_land_sideways	= spr_player_land_sideways;	//director_get_custom_sprite(spr_player_land_sideways);
	sprite_float			= spr_player_float;			//director_get_custom_sprite(spr_player_float);
	sprite_bump				= spr_player_bump;			//director_get_custom_sprite(spr_player_bump);
	sprite_dive_spring		= spr_player_dive_spring;
	sprite_dive_spring_fail	= spr_player_dive_spring_fail;
	sprite_dive_spring_effect_lines = spr_player_dive_spring_effect_lines;
	sprite_sitdown			= spr_player_sitdown;		//director_get_custom_sprite(spr_player_sitdown);
	sprite_dialogue_idle	= spr_player_dialogue_idle;
	sprite_stage_entrance	= spr_player_stage_entrance;
	sprite_bonus_room_enter	= spr_player_bonus_room_enter;
	sprite_frolic			= spr_player_frolic;
	sprite_secret_idle		= spr_player_secret_idle;
	sprite_secret_idle_bubble_out = spr_player_secret_idle_bubble_out;
	sprite_take_damage_0	= spr_player_take_damage_0;	//director_get_custom_sprite(spr_player_take_damage_0);
	sprite_take_damage_1	= spr_player_take_damage_1;	//director_get_custom_sprite(spr_player_take_damage_1);
	sprite_death			= spr_player_death;			//director_get_custom_sprite(spr_player_death);

	secret_idle_thought_sprites = [
		spr_player_secret_idle_thought_1,
		spr_player_secret_idle_thought_2,
		spr_player_secret_idle_thought_3,
		spr_player_secret_idle_thought_5,
		spr_player_secret_idle_thought_6,
		spr_player_secret_idle_thought_7,
		spr_player_secret_idle_thought_8,
		spr_player_secret_idle_thought_9,
		spr_player_secret_idle_thought_10
	];
	
	//Transition Sprites
	sprite_transition_walk_to_walk_other_direction		= spr_player_transition_walk_to_walk_other_direction;
	sprite_transition_walk_to_frolic					= spr_player_transition_walk_to_frolic;
	sprite_transition_idle_to_frolic					= spr_player_transition_idle_to_frolic;
	sprite_transition_float_to_fall						= spr_player_transition_float_to_fall;
	sprite_transition_float_to_fall_sideways			= spr_player_transition_float_to_fall_sideways;
	sprite_transition_bump_to_fall						= spr_player_transition_bump_to_fall;
	sprite_transition_bump_to_fall_sideways				= spr_player_transition_bump_to_fall_sideways;
	sprite_transition_jump_sideways_to_fall_sideways	= spr_player_transition_jump_sideways_to_fall_sideways;
	
	//Idle Sprite
	image_system_setup(sprite_idle,ANIMATION_FPS_DEFAULT,true,true,0,IMAGE_LOOP_FULL);
#endregion

#region Info Bar
	//Disable for player
	info_bar_enable = false;
#endregion

#region Transform
	var _transform;
	_transform = transform[TransformType.anchor];
	transform_set(_transform,TransformValue.xscale,0,false);
	transform_set(_transform,TransformValue.yscale,0,false);
	transform_set(_transform,TransformValue.alpha,0,false);
#endregion

#region Input
	//User
	player_user_setup(0);
	
	//Create Input Control System
	input_control_system_create();
	
	#region Mobile
		//Device
		input_mobile_mouse_device = 0;
		
		//Thumbstick
		input_mobile_thumbstick_start_x = 0;
		input_mobile_thumbstick_start_y = 0;
		
		//Mobile Landscape Mode
		if((IS_MOBILE) && (o_camera.orientation == Orientation.landscape)){
			mobile_landscape_input = true;
		}
		else{
			mobile_landscape_input = false;
		}
	#endregion
#endregion

#region Movement
	#macro PLAYER_INPUT_ACCELERATION_DEFAULT 3

	movement_velocity_retention_and_acceleration_max_set(0.7,5000);
	movement_input_move_acceleration_default_set(PLAYER_INPUT_ACCELERATION_DEFAULT);
	
	move_trapped_check = false;
	
	//Jump
	input_move_acceleration_jump = PLAYER_INPUT_ACCELERATION_DEFAULT * 15;
	
	//Jump Hold
	jump_hold_enable = true;
	jump_hold_allow_countdown_max = SECOND * 0.2;
	jump_hold_allow_countdown = jump_hold_allow_countdown_max;
	
	//Movement Effects
	wobble_enable = false;
	speed_stretch_enable = false;
	acceleration_sway_enable = false;
	acceleration_sway_max = 5;
	acceleration_sway_lerp_val = 0.3;
	quick_smoke_fx_enable = false;
	
	//Float
	float_countdown_max = SECOND * 1;
	float_countdown = float_countdown_max;
	
	//Liquid Collision
	liquid_collision_instance = noone;

	//Idle
	stationary = true;
	stationary_time = 0;
	spawn_context = PlayerSpawnContext.none;
	stage_entrance_hp_vulnerable_previous = true;
	stage_entrance_user_hp_vulnerable_previous = true;
	stage_entrance_draw_adjustment_y = 0;
	bonus_room_enter_target_room = noone;
	bonus_room_enter_start_x = 0;
	bonus_room_enter_start_y = 0;
	bonus_room_enter_target_x = 0;
	bonus_room_enter_target_y = 0;
	bonus_room_enter_transition_requested = false;
	bonus_room_enter_hp_vulnerable_previous = true;
	bonus_room_enter_user_hp_vulnerable_previous = true;

	secret_idle_inputless_time = 0;
	secret_idle_phase = 0;
	secret_idle_thought_fx = noone;
	secret_idle_thought_index = -1;
	secret_idle_thought_previous_index = -1;
	secret_idle_activation_time = SECOND * 5;
	secret_idle_thought_fade_speed = 1 / (SECOND * 0.2);
	secret_idle_fx_layer = "lyr_pfx_foreground";
	secret_idle_thought_offset_x = 4;
	secret_idle_thought_offset_y = -430;

	//Run
	frolic_active = false;
	frolic_ramp_time = 0;
	frolic_ramp_time_max = SECOND;
	frolic_acceleration_factor = 2;
	enemy_bounce_acceleration_factor = 2;

	//Air Spin
	air_spin_active = false;

	//Dive Spring
	enum DiveSpringPhase{
		dive,
		impact,
		spring,
		transition,
		fail
	}

	dive_spring_phase = DiveSpringPhase.dive;
	dive_spring_impact_timer = 0;
	dive_spring_fail_window_max = SECOND * 0.25;
	dive_spring_success_window_max = SECOND * 0.25;
	dive_spring_move_input_threshold = 0.2;
	dive_spring_move_input_previous = 0;
	dive_spring_dive_timer = 0;
	dive_spring_initial_speed = 12;
	dive_spring_max_speed = 50;
	dive_spring_acceleration_time = SECOND * 0.5;
	dive_spring_start_speed = 0;
	dive_spring_jump_acceleration_factor = 5.34;
	dive_spring_descent_loop_start_frame = 4;
	dive_spring_descent_loop_end_frame = 6;
	dive_spring_impact_start_frame = 6;
	dive_spring_impact_loop_start_frame = 7;
	dive_spring_impact_loop_end_frame = 8;
	dive_spring_launch_frame = 8;
	dive_spring_rotor_loop_start_frame = 9;
	dive_spring_rotor_loop_end_frame = 15;
	dive_spring_transition_start_frame = 15;
	dive_spring_transition_end_frame = 16;
	dive_spring_fail_start_frame = 5;
	dive_spring_launch_hold_time_max = SECOND * 0.12;
	dive_spring_launch_hold_time = 0;
	dive_spring_rotor_fps = 10;
	dive_spring_momentum_x = 0;
	dive_spring_velocity_retention_aerial = 1;
	dive_spring_velocity_retention_aerial_previous = velocity_retention_aerial;
	dive_spring_movement_override_active = false;
	dive_spring_enemy_impact = false;
	dive_spring_float_cancel_requested = false;
	dive_spring_dash_cancel_requested = false;
#endregion

#region Dash
	dash_enable = true;
	dash_state = PlayerState.dash;

	//Duration
	dash_countdown = 0;
	dash_countdown_max = 0.11 * SECOND;
	
	//Cooldown
	dash_cooldown = 0;
	dash_cooldown_max = 0.1 * SECOND;
	
	//Movement
	dash_acceleration = 16.5;
	dash_velocity_retention = 0.85;
	
	//Combat
	#macro PLAYER_DASH_DAMAGE_DEFAULT 6
	dash_damage = PLAYER_DASH_DAMAGE_DEFAULT;
	dash_range = 300;
	
	//Stamina
	dash_stamina_cost = 10;
	dash_stamina_max = dash_stamina_cost * 1;
	dash_stamina = dash_stamina_max;
	dash_stamina_recovery_rate = 0;//dash_stamina_cost / (SECOND * 0.7);
	dash_stamina_depleted = false;
	
	//Icon
	dash_icon_enable = false;
	dash_icon_light = lighting_light_create_track(spr_light_circular,c_white,"lyr_lighting",1,1,0,0,0,0);
	
	//Hold
	dash_hold_enable = true;
	dash_hold_check_countdown_max = SECOND*0.1;
	dash_hold_check_countdown = dash_hold_check_countdown_max;
	dash_hold_allow_countdown_max = SECOND*0.05;
	dash_hold_allow_countdown = dash_hold_allow_countdown_max;
	
	//No Input Direction
	dash_no_input_direction = 0;
	
	//Bump
	bump_triggered = false;
	bump_jump_count = 0;
	bump_allow = false;
	bump_allow_countdown = 0;
	bump_allow_countdown_max = 0.1 * SECOND;
#endregion

#region Hit
	var _hit_countdown_time = SECOND * 1;
	hit_countdown = new Countdown(_hit_countdown_time,_hit_countdown_time,true,COUNTDOWN_RESET_COUNT_NEVER);
	
	hit_state_previous = PlayerState.idle;
#endregion

#region Health
	#macro PLAYER_HP_MAX_DEFAULT 3
	#macro PLAYER_LIVES_DEFAULT 2

	hp = PLAYER_HP_MAX_DEFAULT;
	hp_set_max(hp);
	
	hp_regen_rate =  2;
	hp_regen_remaining = 0;
	hp_regen_countdown_max = SECOND / 10;							//Regen applied 10 times a second
	hp_regen_countdown = hp_regen_countdown_max;
	
	hp_decay_rate =  1;
	hp_decay_remaining = 0;
	hp_decay_countdown_max = SECOND / 3;							//Decay applied 5 times a second
	hp_decay_limit = 1;
	
	hp_overhealth_enable = true;
	
	//States
	hp_state_count = 4;
	
	hp_state_trigger[0] = 0.6;
	hp_state_trigger[1] = 0.2;
	hp_state_trigger[2] = 0;
	hp_state_trigger[3] = -1;
	
	hp_state_update();
#endregion

#region Lighting
	tracking_light = lighting_light_create_track(spr_light_circular,c_white,"lyr_lighting",1,1,0,0,0,1);
	//torch_light = lighting_light_create(LightType.torch,"lyr_lighting",0,0,2,2,c_white,0);
#endregion
