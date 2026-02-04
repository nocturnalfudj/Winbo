// Inherit the parent event
event_inherited();

//Interaction
mouse_collision_enable = false;

//Fade
fade_full_screen = true;
fade_follow_camera = true;
fade_factor = 1;

//Set Colour to Black
transform_set(transform[TransformType.anchor],TransformValue.colour,c_black,false);

#region Blur
	//Default to no Blur
	blur_area_id = noone;
#endregion