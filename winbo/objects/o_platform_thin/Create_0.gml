// Inherit the parent event
event_inherited();

//Image
sprite_current = sprite_index;//director_get_custom_sprite(spr_platform_thin);

// Make it semi-solid by default
collision_enable_x_in = false;
collision_enable_x_left = false;
collision_enable_x_right = false;

collision_enable_y_in = false;
collision_enable_y_down = true;  // Allow jumping up through from below
collision_enable_y_up = false;     // Allow landing on top

// Enable drop-through functionality
drop_through_enabled = true;
