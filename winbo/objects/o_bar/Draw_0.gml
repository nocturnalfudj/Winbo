if(!gui){
	var _x,_y,_angle,_colour,_alpha,_scale_x,_scale_y;
	_x = x;
	_y = y;
	_alpha = image_alpha;
	_colour = image_blend;
	_angle = image_angle;
	_scale_x = image_xscale;
	_scale_y = image_yscale;
	
	draw_set_colour(colour);
	
	switch(bar_direction){
		case BarDirection.up:
			draw_rectangle(0,0,_scale_x,_scale_y,false);
			
			if(edge_sprite!=noone)
				draw_sprite_ext_ags(edge_sprite,0,0,_scale_y,_scale_x,1,0,_colour,_alpha);
		break;
		
		case BarDirection.down:
			draw_rectangle(0,_y,_scale_x,_y + _scale_y,false);
			
			if(edge_sprite!=noone)
				draw_sprite_ext_ags(edge_sprite,0,0,_y,_scale_x,-1,0,_colour,_alpha);
		break;
		
		case BarDirection.left:
			draw_rectangle(0,0,_scale_x,_scale_y,false);
			
			if(edge_sprite!=noone)
				draw_sprite_ext_ags(edge_sprite,0,_scale_x,0,-_scale_y,1,90,_colour,_alpha);
		break;
		
		case BarDirection.right:
			draw_rectangle(_x,0,_x + _scale_x,_scale_y,false);
			
			if(edge_sprite!=noone)
				draw_sprite_ext_ags(edge_sprite,0,_x,0,_scale_y,1,-90,_colour,_alpha);
		break;
	}
	
	draw_set_colour(c_white);
}