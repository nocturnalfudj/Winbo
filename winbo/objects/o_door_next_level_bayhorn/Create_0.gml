// Inherit the parent event
event_inherited();

// Enable level end character behavior
level_end_character_enable = true;

// Set animation sprites
level_end_character_sprite_idle = spr_bayhorn_idle;
level_end_character_sprite_wave = spr_bayhorn_wave;
level_end_character_sprite_dance = spr_bayhorn_dance;

// Initialize with idle sprite
sprite_current = level_end_character_sprite_idle;
image_system_setup(level_end_character_sprite_idle, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);

// Get next level from level registry
room_target = level_select_get_next_room(room);