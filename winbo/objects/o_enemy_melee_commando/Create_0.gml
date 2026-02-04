// Inherit the parent event
event_inherited();

#region Image
	// Directional (asymmetrical)
	sprite_direction_enable = true;
	face_horizontal_draw_enable = false; // Use L/R sprites, no xscale flip
	
	// Relaxed idle (pre-hostile, facing player)
	sprite_idle_relaxed = spr_commando_idle;
	sprite_idle = sprite_idle_relaxed;
	
	// Startled
	sprite_startled_left = spr_commando_startled_left;
	sprite_startled_right = spr_commando_startled_right;
	
	// Relaxed walk (combined)
	sprite_walk_relaxed_left = spr_commando_walk_relaxed_left;
	sprite_walk_relaxed_right = spr_commando_walk_relaxed_right;
	walk_relaxed_idle_start = 0;
	walk_relaxed_idle_end = 2;
	walk_relaxed_walk_start = 4;
	walk_relaxed_walk_end = 18;
	
	// Hostile walk (combined idle+walk)
	sprite_walk_hostile_left = spr_commando_walk_hostile_left;
	sprite_walk_hostile_right = spr_commando_walk_hostile_right;
	walk_hostile_idle_start = 0;
	walk_hostile_idle_end = 13;
	walk_hostile_walk_start = 14;
	walk_hostile_walk_end = 30;
	
	// Attack (combined telegraph+active+recover)
	sprite_attack_left = spr_commando_attack_left;
	sprite_attack_right = spr_commando_attack_right;
	sprite_attack_telegraph = spr_commando_attack_left; // will be directionalized in move
	sprite_attack_active = spr_commando_attack_left;
	sprite_attack_recover = spr_commando_attack_left;
	
	// Melee attack collision mask (knife-only)
	attack_melee_collision_mask_sprite = spr_commando_attack_collision_mask;
	
	// Melee hitbox active frames (knife contact window)
	attack_melee_active_frames_enable = true;
	attack_melee_active_frame_start = 13;
	attack_melee_active_frame_end = 16;
	
	// Prevent stepping off ledges during attack states
	edge_guard_attack_enable = true;
	
	// Only start attacks when already facing the target (prevents snapping into backwards attacks)
	attack_requires_facing_target_enable = true;
	
	// Patrol: turn around after N walk loops (relaxed)
	patrol_turn_after_walk_loops_enable = true;
	patrol_walk_loops_before_turn = 5;
	
	// Hostile follow: stop at edges/walls instead of flipping away from the target
	hostile_stop_at_edges_enable = true;
	
	// Turn transitions
	sprite_turn_relaxed = spr_commando_turn_around_idle; // Fallback symmetric
	// Directional relaxed turns (asymmetrical character)
	sprite_turn_relaxed_left = spr_commando_turnaround_r_to_l;  // Play when turning TO face left (from right)
	sprite_turn_relaxed_right = spr_commando_turnaround_l_to_r; // Play when turning TO face right (from left)
	sprite_turn_hostile_left = spr_commando_turn_around_hostile_left;
	sprite_turn_hostile_right = spr_commando_turn_around_hostile_right;
	
	// Hit / death reuse
	sprite_take_damage_left = spr_commando_take_damage_0_left;
	sprite_take_damage_right = spr_commando_take_damage_0_right;
	// Death sprites (fallback to take-damage if not available)
	sprite_death_left = spr_commando_death_left ?? spr_commando_take_damage_0_left;
	sprite_death_right = spr_commando_death_right ?? spr_commando_take_damage_0_right;
	
	// Enable extended animation handling
	sprite_animation_extended_enable = true;
	
	animation_fps_multiplier = 1.2;
	sprite_startled_start_frame = 3;
	
	// Attack progression via frame markers
	attack_telegraph_progress_at_frame_enable = true;
	attack_telegraph_progress_at_frame = 11; // telegraph frames 0-10
	attack_active_progress_at_frame_enable = true;
	attack_active_progress_at_frame = 16;    // active frames 11-15
	attack_recover_progress_at_end_of_animation = true; // recover 16-24 to end
	
	// Do not swap sprites mid-attack (single combined sprite)
	attack_active_skip_sprite_change = true;
	attack_recover_skip_sprite_change = true;
	
	// Sheathe sprites (used for de-aggro animation)
	sprite_sheathe_left = spr_commando_sheathe_left;
	sprite_sheathe_right = spr_commando_sheathe_right;

	// Hostility / detection
	is_hostile = false;
	hostility_detection_enable = true;
	hostility_detection_range = 600;
	hostility_detection_y_threshold = 200; // only aggro if player is within vertical range

	// De-aggro: sheathe weapon when player is out of vertical range for too long
	deaggro_enable = true;
	deaggro_timer_max = SECOND * 3;
	deaggro_y_distance_threshold = 200;
	
	// Scale down (and set rest scale)
	var _scale;
	_scale = 0.75;
	var _transform;
	_transform = transform[TransformType.anchor];
	transform_set(_transform,TransformValue.xscale,_scale,false);
	transform_set(_transform,TransformValue.yscale,_scale,false);
	transform_set_rest_to_current(_transform,TransformValue.xscale);
	transform_set_rest_to_current(_transform,TransformValue.yscale);
	
	//Idle Sprite
	image_system_setup(sprite_idle,ANIMATION_FPS_DEFAULT * animation_fps_multiplier,true,true,0,IMAGE_LOOP_FULL);
#endregion

#region Movement
	movement_velocity_retention_and_acceleration_max_set(0.7,1000);
	movement_input_move_acceleration_default_set(2);

	//Path
	movement_path_enable = false;
	movement_path_start_x = x;
	movement_path_end_x = x + 1000;
	movement_path_direction = 1;
#endregion

#region Target / Attack Range
	// Increased attack trigger distance for the lunging knife attack
	// This is the distance at which the enemy will initiate the attack sequence
	target[TargetType.attack].set_distance_trigger(1000);
#endregion