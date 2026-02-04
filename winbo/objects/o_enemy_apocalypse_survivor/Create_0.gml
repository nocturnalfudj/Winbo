// Inherit the parent event
event_inherited();

#region Sprites
	// Symmetric sprites (use xscale flip)
	sprite_direction_enable = false;
	face_horizontal_draw_enable = true;

	// Core sprites
	sprite_idle = spr_apocalypse_survivor_idle;
	sprite_startled_left = spr_apocalypse_survivor_startle;
	sprite_startled_right = spr_apocalypse_survivor_startle;

	// Walk (relaxed + hostile use same cycle for now)
	sprite_walk_relaxed_left = spr_apocalypse_survivor_walk;
	sprite_walk_relaxed_right = spr_apocalypse_survivor_walk;
	sprite_walk_hostile_left = spr_apocalypse_survivor_walk;
	sprite_walk_hostile_right = spr_apocalypse_survivor_walk;

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
#endregion

#region Two-Layer Aim System
	aim_angle = 0;
	aim_two_layer_enable = true;
	aim_body_sprite_offset_x = 0;
	aim_body_sprite_offset_y = 0;
	aim_legs_sprite_offset_x = 0;
	aim_legs_sprite_offset_y = 0;
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

	// Recover
	attack_recover_progress_at_end_of_animation = true;
	attack_recover_countdown_max = SECOND * 0.5;
	attack_recover_countdown = attack_recover_countdown_max;

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
	// Grounded patrol (no path)
	movement_path_enable = false;
	movement_path_start_x = x;
	movement_path_end_x = x + 1000;

	// Store patrol origin for return after deaggro
	patrol_origin_x = x;
	patrol_origin_y = y;
#endregion
