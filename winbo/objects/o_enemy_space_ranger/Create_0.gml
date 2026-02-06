// Inherit the parent event
event_inherited();

#region Sprites
	sprite_idle				= spr_space_ranger_idle;
	sprite_attack_telegraph	= spr_space_ranger_aim_body;
	sprite_attack_active	= spr_space_ranger_attack;
	sprite_attack_recover	= spr_space_ranger_idle;

	// Death sprites (two variations)
	sprite_death_1 = spr_space_ranger_death_1;
	sprite_death_2 = spr_space_ranger_death_2;

	// Movement directional sprites (relative to character facing, not world direction)
	// "Forward" = moving toward where facing, "Backward" = moving away from where facing
	sprite_move_forward = spr_space_ranger_move_left;
	sprite_move_backward = spr_space_ranger_move_right;
	sprite_move_up = spr_space_ranger_move_up;
	sprite_move_down = spr_space_ranger_move_down;
	sprite_move_diag_forward = spr_space_ranger_move_diag_left;
	sprite_move_diag_backward = spr_space_ranger_move_diag_right;

	// Two-layer aim sprites (body rotates, legs stay static)
	sprite_aim_body = spr_space_ranger_aim_body;
	sprite_aim_legs = spr_space_ranger_aim_legs;

	// Set initial sprite
	image_system_setup(sprite_idle, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);

	// Initialize dimensions from sprite (required for height-based combat checks)
	dimensions_system_update(sprite_idle);

	// Space Ranger sprites face LEFT by default - use system-level flip
	// Note: face_horizontal_draw_enable is toggled per-state:
	// - false for directional movement sprites (already oriented correctly)
	// - true for idle/aim/attack sprites (left-facing, need flip system)
	sprite_face_direction = -1;
	face_horizontal_draw_enable = true;  // Default for idle sprite at spawn

#endregion

#region Two-Layer Aim System
	aim_angle = 0;
	aim_two_layer_enable = true;
	aim_body_sprite_offset_x = 0;
	aim_body_sprite_offset_y = 0;
	aim_legs_sprite_offset_x = 0;
	aim_legs_sprite_offset_y = 0;

	// Hybrid rotation: two-layer draw within threshold, whole-sprite rotation beyond
	aim_split_threshold = 25;

	// Locked rotation for attack/recover (set when transitioning from aim to attack)
	attack_locked_angle = 0;
	attack_locked_draw_angle = 0;
	attack_rotation_active = false;
	attack_rotation_lerp_speed = 0.15;
#endregion

#region Combat - Space Ranger Overrides
	// Attack timing
	attack_countdown_max = SECOND * 2;
	attack_countdown = 0;  // Start at 0 so can attack immediately when in range

	// Telegraph (aiming phase)
	attack_telegraph_progress_at_end_of_animation = false;
	attack_telegraph_countdown_max = SECOND * 1;
	attack_telegraph_countdown = attack_telegraph_countdown_max;

	// Active (fire missile)
	attack_active_progress_at_end_of_animation = true;
	attack_active_countdown_max = SECOND * 0.5;
	attack_active_countdown = attack_active_countdown_max;

	// Recover
	attack_recover_progress_at_end_of_animation = true;
	attack_recover_countdown_max = SECOND * 0.5;
	attack_recover_countdown = attack_recover_countdown_max;

	// Missile settings
	missile_object = o_missile;
	missile_spawn_offset_x = -201;  // Offset from sprite origin (741,400) to launcher barrel (540,238)
	missile_spawn_offset_y = -162;
	missile_spawn_frame = 0;        // Frame of attack animation when missile should spawn (0 = instant)
	missile_speed = 6;
	missile_damage = 1;

	// Recoil effect when firing
	attack_recoil_enable = true;
	attack_recoil_amount = 4;
#endregion

#region Detection / Hostility
	// Start non-hostile (patrol mode)
	is_hostile = false;

	// Skip startled state (no startled sprite — base enemy_state_move would
	// transition to startled anyway, but the exit condition checks for the
	// animation reaching its last frame, which never happens when a looping
	// movement sprite with a restricted loop range is playing)
	has_played_startled = true;

	// Enable detection to aggro when player gets close
	hostility_detection_enable = true;
	hostility_detection_range = 1000; // Horizontal detection distance
	hostility_detection_y_threshold = 1000; // Vertical detection distance

	// De-aggro when player escapes range (Space Ranger uses custom deaggro logic for both X and Y)
	deaggro_enable = false; // Disable base deaggro (only checks Y distance)
	deaggro_timer_max = SECOND * 4;
	deaggro_x_distance_threshold = 1500; // Horizontal escape distance
	deaggro_y_distance_threshold = 1500; // Vertical escape distance
	deaggro_timer = 0; // Custom timer for Space Ranger
#endregion

#region Movement - Flying Path
	// Path movement (inherited from ranged flying parent)
	movement_path_enable = true;
	movement_path_start_x = x;
	movement_path_end_x = x + 1000;

	// Store patrol origin for return after deaggro
	patrol_origin_x = x;
	patrol_origin_y = y;

	// Slower movement - reduce acceleration by 50% (drag stays at default 0.7)
	movement_input_move_acceleration_default_set(0.5);
#endregion

