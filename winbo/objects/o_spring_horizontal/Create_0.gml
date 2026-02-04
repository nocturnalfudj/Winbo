// Inherit the parent event
event_inherited();

//Image - Red mushroom sprites for horizontal spring
sprite_idle = spr_spring_red_idle;
sprite_active = spr_spring_red_active;

//Idle Sprite
image_system_setup(sprite_idle,ANIMATION_FPS_DEFAULT,true,true,0,IMAGE_LOOP_FULL);

spring_acceleration = 2;	//As a factor of the player's jump height
// spring_direction will be calculated dynamically based on player approach direction

// Configure directional collision for horizontal spring
// Block from top and bottom, but allow pass-through from sides
collision_enable_x_in = false;
collision_enable_x_left = false;   // Allow pass-through from left
collision_enable_x_right = false;  // Allow pass-through from right

collision_enable_y_in = false;
collision_enable_y_up = true;      // Block player coming from below (moving up)
collision_enable_y_down = true;    // Block player coming from above (moving down)

// Disable drop-through functionality (no crouch-drop)
drop_through_enabled = false;