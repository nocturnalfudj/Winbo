function draw_sprite_ext_ags(_sprite,_animation_frame,_x,_y,_scale_x,_scale_y,_angle,_colour,_alpha) {
	if((_scale_x!=0) && (_scale_y!=0) && (_alpha>0)){
		if((_scale_x==1) && (_scale_y==1) && (_angle mod 360 == 0) && (_colour==c_white) && (_alpha==1)){
			draw_sprite(_sprite,_animation_frame,_x,_y);
		}
		else{
			draw_sprite_ext(_sprite,_animation_frame,_x,_y,_scale_x,_scale_y,_angle,_colour,_alpha);
		}
	}
}