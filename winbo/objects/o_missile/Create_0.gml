// Inherit the parent event (o_bullet)
event_inherited();

// Missile-specific sprite
sprite_current = spr_missile;
sprite_index = spr_missile;

// Use the custom image system (sprite_current_frame) to animate the missile.
image_system_setup(sprite_current, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);

// Missile settings
damage = 1;
alive_time = 5 * SECOND;
death_anim_sprite = spr_missile_explosion;
death_anim_fps = ANIMATION_FPS_DEFAULT;
death_anim_suppress_on_deflect = true;
deflect_flyoff_enable = true;
deflect_flyoff_active = false;
deflect_flyoff_speed = 50;
deflect_flyoff_margin = 192;
deflect_flyoff_lifetime = 1.25 * SECOND;
deflect_flyoff_sprite_spin_speed = 18;

// Rotate to velocity direction
rotate_to_velocity_direction = true;

// Sprite angle offset - missile sprite is drawn pointing left, add 180 to face velocity direction
sprite_angle_offset = 180;

// Movement - missiles maintain velocity (no drag)
movement_velocity_retention_and_acceleration_max_set(1, 100);

// Homing settings
homing_enable = true;
homing_turn_rate = 1.0;       // Degrees to turn per frame toward target (slow tracking)
homing_target = noone;        // Will be set to player on first frame
homing_delay = 0.2 * SECOND;  // Delay before homing kicks in (let missile travel a bit first)
