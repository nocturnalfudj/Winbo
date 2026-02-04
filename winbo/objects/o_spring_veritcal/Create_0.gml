// Inherit the parent event
event_inherited();

//Image
spring_colour = SpringColour.purple;//choose(SpringColour.red,SpringColour.purple);
switch(spring_colour){
	case SpringColour.red:
		sprite_idle = spr_spring_red_idle;
		sprite_active = spr_spring_red_active;
	break;
	
	case SpringColour.purple:
		sprite_idle = spr_spring_purple_idle;
		sprite_active = spr_spring_purple_active;
	break;
}

//Idle Sprite
image_system_setup(sprite_idle,ANIMATION_FPS_DEFAULT,true,true,0,IMAGE_LOOP_FULL);

spring_acceleration = 2;	//As a factor of the player's jump height
spring_direction = 90;		//Up

// Configure directional collision
// Block from sides and below, but allow fall-through from above
collision_enable_x_in = false;
collision_enable_x_left = true;   // Block player coming from the left (moving right)
collision_enable_x_right = true;  // Block player coming from the right (moving left)

collision_enable_y_in = false;
collision_enable_y_up = true;     // Block player coming from below (moving up)
collision_enable_y_down = false;  // Allow player to fall through from above (moving down)

// Disable drop-through functionality (no crouch-drop)
drop_through_enabled = false;