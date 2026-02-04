if(camera_visible){
	draw_sprite_ext(sprite_current,sprite_current_frame,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	
	//Draw Title System
	title_system_draw(x,y,0,c_white,image_alpha,image_xscale,image_yscale);
}