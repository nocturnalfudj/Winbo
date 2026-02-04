// Inherit the parent event (o_bullet)
event_inherited();

// Missile-specific sprite
sprite_current = spr_missile;
sprite_index = spr_missile;

// Missile settings
damage = 1;
alive_time = 5 * SECOND;

// Rotate to velocity direction
rotate_to_velocity_direction = true;

// Sprite angle offset - missile sprite is drawn pointing left, add 180 to face velocity direction
sprite_angle_offset = 180;

// Movement - missiles maintain velocity (no drag)
movement_velocity_retention_and_acceleration_max_set(1, 100);

// Homing settings
homing_enable = true;
homing_turn_rate = 1.5;       // Degrees to turn per frame toward target (slow tracking)
homing_target = noone;        // Will be set to player on first frame
homing_delay = 0.2 * SECOND;  // Delay before homing kicks in (let missile travel a bit first)
