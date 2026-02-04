//Inherit UI Object Parent
event_inherited();

//Alarms
enum WindowAlarm{
	surface_redraw_disable,
	
	SIZE
}

#region Interaction
	mouse_collision_enable = true;
	mouse_collision_down_required = true;

	mouse_control_button = mb_left;
#endregion

//Dimensions
width = sprite_width;
height = sprite_height;

//Window
window_active = false;

//Transform Child
transform_system_new_transform_child();

#region Surface
	surface = noone;
	surface_x = 0;
	surface_y = 0;
	
	surface_border_left = 0;
	surface_border_right = 0;
	
	surface_border_top = 0;
	surface_border_bottom = 0;
	
	surface_draw = ds_list_create();
	surface_draw_size = 0;
	
	surface_redraw = false;
	window_surface_redraw_set(2);
#endregion

#region Scroll
	scroll = new Scroll(x,y);
	scroll.transform_parent = transform_child[0];
#endregion

//Create System
title_system_create();

#region Image
	sprite_current = noone;
#endregion