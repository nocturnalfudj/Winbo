//Ignore if Not Visible
if(!camera_visible)
	exit;

//Only Operate In Normal Draw Event
if(o_director.depth_grid_draw_event_state != 1)
	exit;


var _colour;
if((shop_unpurchased_colour_draw_gray_enable) && ((shop_item_data.unlocked == false) || ((shop_item_data.level == 0)))){
	_colour = c_gray;
}
else{
	_colour = c_white;
}
draw_sprite_ext(sprite_current,sprite_current_frame,x,y,image_xscale,image_yscale,image_angle,_colour,image_alpha);
if(shop_item_icon != noone)
	draw_sprite_ext(shop_item_icon,0,x + shop_item_icon_x,y + shop_item_icon_y,image_xscale,image_yscale,image_angle,_colour,image_alpha);
	
//Item Is Locked
if(shop_item_data.unlocked == false){
	var _scale;
	_scale = 0.2;
	// TODO: Replace with actual lock sprite when available
	// draw_sprite_ext(spr_lock,0,x,y - 200,image_xscale * _scale,image_yscale * _scale,image_angle,image_blend,image_alpha);
}
//Item is Unlocked & Not Max Level
else if((!purchase_item_level_increase) || ((purchase_item_level_increase) && (shop_item_data.level < shop_item_data.level_max))){
	shop_system_draw_cost();
}
	
#region Flash
	if(flash_alpha > 0){
		shader_set(sh_monochrome);
		draw_sprite_ext(sprite_current,sprite_current_frame,x,y,image_xscale,image_yscale,image_angle,flash_colour,flash_alpha);
		shader_reset();
	}
#endregion
	
//Draw Title System
title_system_draw(x,y,image_angle,image_blend,image_alpha,1,1);
	
#region Dev Mode
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
	//draw_bounding_box();
#endregion