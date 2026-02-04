//Inherit UI Object Parent
event_inherited();

#region Slider
	vertical = true;
#endregion

#region Image
	sprite_current = spr_slider_vertical;
	ssprite_frame = noone;
	sprite_background = spr_slider_vertical_background;
	sprite_pointer = spr_slider_vertical_pointer;
	sprite_discrete_bar = spr_slider_vertical_discrete_bar;
#endregion

#region Dimensions
	dimensions_system_update(sprite_background);

	slider_sprite_width = sprite_get_width(sprite_current);
	slider_sprite_height = sprite_get_height(sprite_current);
	
	slider_sprite_width_half = slider_sprite_width/2;
	slider_sprite_height_half = slider_sprite_height/2;
#endregion