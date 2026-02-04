// Inherit the parent event
event_inherited();

//Sprite Current
sprite_current = sprite_index;

//Create Dimensions System
dimension_system_create();

//Transform System
transform_system_create();

//Flash
flash_system_create();

//PFX
pfx_system_create();

#region Title System
	title_system_create();
	title_enable = true;
	title_text = noone;
	title_string = "DISPLAY STRING";
	title_font = fnt_default_52;
	title_colour = c_white;
	title_halign = fa_center;
	title_valign = fa_middle;
	title_x = 0;
	title_y = -100;
	title_shadow_enable = true;
	title_shadow_colour = c_black;
	title_shadow_x = -4;
	title_shadow_y = 4;
#endregion

//Create the Interact System
interact_system_create();

//Lock
lock_sprite = noone; // TODO: Replace with actual lock sprite when available
lock_scale = 0;