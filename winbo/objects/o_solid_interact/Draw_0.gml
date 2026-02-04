//Ignore if Not Visible
if(!camera_visible)
	exit;

//Only Operate In Normal Draw Event
if(o_director.depth_grid_draw_event_state != 1)
	exit;
	
//Draw Actor
draw_sprite_ext(sprite_current,sprite_current_frame,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	
#region Flash
	if(flash_alpha > 0){
		shader_set(sh_monochrome);
		draw_sprite_ext(sprite_current,sprite_current_frame,x,y,image_xscale,image_yscale,image_angle,flash_colour,flash_alpha);
		shader_reset();
	}
#endregion
	
#region Lock
	if(lock_scale > 0 && lock_sprite != noone){
		draw_sprite_ext(lock_sprite,0,x,y,lock_scale,lock_scale,image_angle,image_blend,lock_scale);
	}
#endregion

//Draw Title System
title_system_draw(x,y,image_angle,image_blend,image_alpha,1,1);
	
#region Dev Mode	
	//Bounding Box
	//draw_bounding_box();
#endregion