// Inherit the parent event
event_inherited();

//State
uses_states = false;

//Camera Visible System
camera_visible_system_create();

//Image System
image_system_create();

//Move Trapped
move_trapped_trigger_enable = true;

//Collision
collision_enable_x_in		= true;
collision_enable_x_right	= true;
collision_enable_x_left		= true;

collision_enable_y_in		= true;
collision_enable_y_up		= true;
collision_enable_y_down		= true;

// Drop-through system
drop_through_enabled = false;