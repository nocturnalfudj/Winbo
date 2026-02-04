// Inherit the parent event
event_inherited();

//Team
team = Team.enemy;

//States
enum EnemyState{
	create,
	idle,
	move,
	sheathe,
	startled,
	attack_telegraph,
	attack_active,
	attack_recover,
	death,
	destroy
}

state = EnemyState.create;

death_state = EnemyState.death;

#region Image
	sprite_idle				= spr_enemy_ranged_test_idle;
	sprite_attack_telegraph	= spr_enemy_ranged_test_attack_telegraph;
	sprite_attack_active	= spr_enemy_ranged_test_attack_active;
	sprite_attack_recover	= spr_enemy_ranged_test_attack_recover;
	
	// Directional sprite support (asymmetrical characters)
	sprite_direction_enable = false;
	sprite_attack_left = noone;
	sprite_attack_right = noone;
	
	// Extended animation support (idle/walk per hostility)
	sprite_animation_extended_enable = false;
	sprite_idle_relaxed = noone;
	sprite_idle_hostile_left = noone;
	sprite_idle_hostile_right = noone;
	sprite_walk_relaxed_left = noone;
	sprite_walk_relaxed_right = noone;
	sprite_walk_hostile_left = noone;
	sprite_walk_hostile_right = noone;
	sprite_startled_left = noone;
	sprite_startled_right = noone;
	sprite_turn_relaxed = noone;
	sprite_turn_relaxed_left = noone;  // Turn animation when turning TO face left (R to L)
	sprite_turn_relaxed_right = noone; // Turn animation when turning TO face right (L to R)
	sprite_turn_hostile_left = noone;
	sprite_turn_hostile_right = noone;
	sprite_take_damage_left = noone;
	sprite_take_damage_right = noone;
	sprite_death_left = noone;
	sprite_death_right = noone;
	sprite_sheathe_left = noone;
	sprite_sheathe_right = noone;

	sprite_startled_start_frame = 0;
	
	// Combined-sprite frame ranges (defaults no-op)
	walk_relaxed_idle_start = 0;
	walk_relaxed_idle_end = 0;
	walk_relaxed_walk_start = 0;
	walk_relaxed_walk_end = 0;
	walk_hostile_idle_start = 0;
	walk_hostile_idle_end = 0;
	walk_hostile_walk_start = 0;
	walk_hostile_walk_end = 0;
	
	//Idle Sprite
	image_system_setup(sprite_idle,ANIMATION_FPS_DEFAULT,true,true,0,IMAGE_LOOP_FULL);
#endregion

#region Movement
	movement_velocity_retention_and_acceleration_max_set(0.7,1000);
	movement_input_move_acceleration_default_set(1);
	
	//Path
	movement_path_enable = false;
	movement_path_start_x = x;
	movement_path_end_x = x + 1000;
	movement_path_direction = 1;
	
	//Movement Effects
	wobble_enable = false;
	speed_stretch_enable = false;
	acceleration_sway_enable = false;
	acceleration_sway_max = 5;
	acceleration_sway_lerp_val = 0.3;
#endregion

#region Target
	target[TargetType.attack].set_distance_trigger(1000);
	target[TargetType.attack].object = o_player;
	target[TargetType.attack].type = Target.object;
#endregion

#region Combat
	//Rate of Attack
	attack_countdown = 0;
	attack_countdown_max = SECOND * 3;
	
	//Attack
	attack_telegraph_progress_at_end_of_animation = false;
	attack_telegraph_countdown_max = SECOND * 2;
	attack_telegraph_countdown = attack_telegraph_countdown_max;
	
	// Frame-based attack progression (optional)
	attack_telegraph_progress_at_frame_enable = false;
	attack_telegraph_progress_at_frame = 0;
	attack_active_progress_at_frame_enable = false;
	attack_active_progress_at_frame = 0;
	attack_recover_progress_at_frame_enable = false;
	attack_recover_progress_at_frame = 0;
	
	// Sprite change control during combined animations
	attack_active_skip_sprite_change = false;
	attack_recover_skip_sprite_change = false;
	
	attack_active_attack_created = false;
	attack_active_progress_at_end_of_animation = false;
	attack_active_countdown_max = SECOND * 2;
	attack_active_countdown = attack_telegraph_countdown_max;
	
	attack_recover_progress_at_end_of_animation = false;
	attack_recover_countdown_max = SECOND * 2;
	attack_recover_countdown = attack_telegraph_countdown_max;
	
	//Attack Type
	enum AttackType{
		ranged,
		melee,
		
		SIZE
	}
	attack_type = AttackType.ranged;
	
	//Ranged Attack
	attack_ranged_can_aim_downward = false;
	attack_ranged_bullet_acceleration = 15;
	
	//Melee Attack
	attack_melee_attack_instance = noone;
	attack_melee_collision_mask_sprite = spr_melee_attack;
	
	// Melee hitbox active window within the ATTACK ANIMATION (sprite_current_frame).
	// If disabled, melee hitbox uses legacy behaviour (exists for whole active state).
	attack_melee_active_frames_enable = false;
	attack_melee_active_frame_start = 0;
	attack_melee_active_frame_end = 0;
	
	// Edge guard during attacks (prevents stepping off ledges while telegraph/active/recover)
	edge_guard_attack_enable = false;
	edge_guard_attack_lookahead_extra_px = 4;
	
	// Attack facing lock (prevents flipping during telegraph/active/recover)
	attack_face_lock_active = false;
	attack_face_horizontal_lock = 1;
	
	// Require facing target to start an attack (optional; useful for melee)
	attack_requires_facing_target_enable = false;
	
	// Patrol behaviour (optional)
	patrol_turn_after_walk_loops_enable = false;
	patrol_walk_loops_before_turn = 4;
	patrol_walk_loops_count = 0;
	patrol_walk_frame_prev = 0;
	patrol_pending_turn = false;
	
	// Edge response while hostile in move state (optional; avoids jitter when chasing toward an off-ledge target)
	hostile_stop_at_edges_enable = false;
#endregion

#region Hostility / Detection
	// Default enemies remain hostile to preserve legacy behaviour
	is_hostile = true;
	hostility_detection_enable = false;
	hostility_detection_range = 0;
	hostility_detection_y_threshold = 9999; // max vertical distance for aggro (large default = no restriction)

	// De-aggro system: enemy sheathes weapon and returns to relaxed state
	// when player is out of vertical range for too long
	deaggro_enable = false;
	deaggro_timer = 0;
	deaggro_timer_max = SECOND * 3;
	deaggro_y_distance_threshold = 200; // vertical distance to trigger de-aggro countdown

	// Startled animation tracking - only plays once per enemy lifetime
	has_played_startled = false;
#endregion

#region Lighting
	tracking_light = lighting_light_create_track(spr_light_circular,c_white,"lyr_lighting",1,1,0,0,0,1);
#endregion