//Ignore if Not Visible
if(!camera_visible_position)
	exit;
	
if(sprite_grate_back != noone){
	draw_sprite_ext(sprite_grate_back,0,x,y,grate_scale_x,grate_scale_y,image_angle,image_blend,image_alpha);
}
	
//Draw Actor
draw_sprite_ext(sprite_current,sprite_current_frame,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);

if(sprite_grate_front != noone){
	draw_sprite_ext(sprite_grate_front,0,x,y,grate_scale_x,grate_scale_y,image_angle,image_blend,image_alpha);
}
	
#region Flash
	if(flash_alpha > 0){
		shader_set(sh_monochrome);
		
		draw_sprite_ext(sprite_current,sprite_current_frame,x,y,image_xscale,image_yscale,image_angle,flash_colour,flash_alpha);
		
		if(sprite_grate_front != noone){
			draw_sprite_ext(sprite_grate_front,0,x,y,image_xscale,image_yscale,image_angle,flash_colour,flash_alpha);
		}
		
		shader_reset();
	}
#endregion

//Info Bar
info_bar_system_draw();
	
#region Dev Mode
	if(o_master.dev_mode){
		#region Movement Stats
			//var _x,_y,_string;
			//_x = x + 100;
			//_y = y - 100;
			
			//_string = "velocity: " + string(velocity);
			//draw_text(_x,_y,_string);
			
			//_y += 50;
			//_string = "acceleration: " + string(acceleration);
			//draw_text(_x,_y,_string);
			
			//_y += 50;
			//_string = "velocity_retention: " + string(velocity_retention);
			//draw_text(_x,_y,_string);
			
			//_y += 50;
			//_string = "velocity_mag: " + string(velocity_mag);
			//draw_text(_x,_y,_string);
			
			//_y += 50;
			//_string = "velocity_dir: " + string(velocity_dir);
			//draw_text(_x,_y,_string);
			
			//_y += 50;
			//_string = "velocity_terminal: " + string(velocity_terminal);
			//draw_text(_x,_y,_string);
		#endregion
	
	
		//Bounding Box
		draw_bounding_box();
	}
#endregion