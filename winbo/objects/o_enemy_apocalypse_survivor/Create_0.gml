// Inherit the parent event
event_inherited();

#region Sprites
	// Symmetric sprites (use xscale flip)
	sprite_direction_enable = false;
	face_horizontal_draw_enable = true;

	// Apocalypse Survivor sprites face LEFT by default - use system-level flip
	sprite_face_direction = -1;

	// Core sprites
	sprite_idle = spr_apocalypse_survivor_idle;
	sprite_startled_left = spr_apocalypse_survivor_startle;
	sprite_startled_right = spr_apocalypse_survivor_startle;

	// Walk (relaxed + hostile use same cycle for now)
	sprite_walk_relaxed_left = spr_apocalypse_survivor_walk;
	sprite_walk_relaxed_right = spr_apocalypse_survivor_walk;
	sprite_walk_hostile_left = spr_apocalypse_survivor_walk;
	sprite_walk_hostile_right = spr_apocalypse_survivor_walk;

	// Enable extended animation system (required for walk/idle sprite switching)
	sprite_animation_extended_enable = true;
	animation_fps_multiplier = 1;

	// Attack sprites (side-facing placeholders; multi-direction swaps will be handled later)
	sprite_attack_telegraph = spr_apocalypse_survivor_aim_side_body;
	sprite_attack_active = spr_apocalypse_survivor_shoot_side_body;
	sprite_attack_recover = spr_apocalypse_survivor_idle;

	// Death sprites (standing vs kneeling)
	sprite_death_1 = spr_apocalypse_survivor_death_standing;
	sprite_death_2 = spr_apocalypse_survivor_death_kneeling;

	// Two-layer aim sprites (side-facing placeholders)
	sprite_aim_body = spr_apocalypse_survivor_aim_side_body;
	sprite_aim_legs = spr_apocalypse_survivor_aim_side_legs;

	// Initial sprite
	image_system_setup(sprite_idle, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);

	// Initialize dimensions from sprite (required for height-based combat checks)
	dimensions_system_update(sprite_idle);

	// Scale down (and set rest scale)
	var _scale = 0.75;
	var _transform = transform[TransformType.anchor];
	transform_set(_transform, TransformValue.xscale, _scale, false);
	transform_set(_transform, TransformValue.yscale, _scale, false);
	transform_set_rest_to_current(_transform, TransformValue.xscale);
	transform_set_rest_to_current(_transform, TransformValue.yscale);
#endregion

#region Two-Layer Aim System
	aim_angle = 0;
	aim_two_layer_enable = true;
	aim_body_sprite_offset_x = 0;
	aim_body_sprite_offset_y = 0;
	aim_legs_sprite_offset_x = 0;
	aim_legs_sprite_offset_y = 0;

	// Laser sight (placeholder offsets until anchor points are finalized)
	laser_origin_offset_x = 60;
	laser_origin_offset_y = -40;
	laser_length = 2000;
	laser_width = 2;
	laser_alpha = 0.65;
	laser_color = c_red;
#endregion

#region Combat - Apocalypse Survivor Overrides
	// Attack timing (mirrors Space Ranger for now)
	attack_countdown_max = SECOND * 2;
	attack_countdown = 0; // Start at 0 so can attack immediately when in range

	// Telegraph (aiming phase)
	attack_telegraph_progress_at_end_of_animation = false;
	attack_telegraph_countdown_max = SECOND * 1;
	attack_telegraph_countdown = attack_telegraph_countdown_max;

	// Active (fire)
	attack_active_progress_at_end_of_animation = true;
	attack_active_countdown_max = SECOND * 0.5;
	attack_active_countdown = attack_active_countdown_max;

	// Projectile tuning (temporary until dedicated projectile/hitbox exists)
	attack_projectile_spawn_frame = 0;
	attack_projectile_spawn_offset_x = 80;
	attack_projectile_spawn_offset_y = -40;
	attack_projectile_speed = 25;
	attack_projectile_damage = 1;

	// Simple FX timers (Draw handles assets by string name)
	muzzle_flash_timer_max = 0.12 * SECOND;
	muzzle_flash_timer = 0;
	shell_timer_max = 0.2 * SECOND;
	shell_timer = 0;

	// Recover
	attack_recover_progress_at_end_of_animation = true;
	attack_recover_countdown_max = SECOND * 0.5;
	attack_recover_countdown = attack_recover_countdown_max;

	// Recoil effect when firing
	attack_recoil_enable = true;
	attack_recoil_amount = 4;

	// Grounded enemies should not walk off ledges during attacks
	edge_guard_attack_enable = true;
#endregion

#region Detection / Hostility
	// Start non-hostile (patrol mode)
	is_hostile = false;
	is_kneeling = false; // posture flag (set true when kneeling)

	// Enable detection to aggro when player gets close
	hostility_detection_enable = true;
	hostility_detection_range = 1000; // Horizontal detection distance
	hostility_detection_y_threshold = 200; // Vertical detection distance

	// De-aggro disabled for now (handled in later tasks)
	deaggro_enable = false;
#endregion

#region Movement - Patrol Defaults
	// Movement speed settings
	movement_velocity_retention_and_acceleration_max_set(0.7, 1000);
	movement_input_move_acceleration_default_set(2);

	// Grounded patrol (no path)
	movement_path_enable = false;
	movement_path_start_x = x;
	movement_path_end_x = x + 1000;
	movement_path_direction = 1;

	// Patrol: turn around after N walk loops (relaxed)
	patrol_turn_after_walk_loops_enable = true;
	patrol_walk_loops_before_turn = 5;

	// Hostile: stop at edges (ranged enemy doesn't chase)
	hostile_stop_at_edges_enable = true;

	// Store patrol origin for return after deaggro
	patrol_origin_x = x;
	patrol_origin_y = y;

	// Patrol pause settings (random idle pauses)
	patrol_pause_min = 0.5 * SECOND;
	patrol_pause_max = 1.5 * SECOND;
	patrol_pause_chance = 0.01; // 1% chance per step to pause when relaxed
	patrol_pause_timer = 0;
	patrol_pause_cooldown_max = 1.25 * SECOND;
	patrol_pause_cooldown = 0;
#endregion
