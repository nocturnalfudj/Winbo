function draw_text_ext_transformed_ags(_x,_y,_string,_sep,_width,_scale_x,_scale_y,_angle,_colour,_alpha,_align_h,_align_v,_font) {
	if((_scale_x!=0) && (_scale_y!=0) && (_alpha>0) && (_string != "")){
		draw_set_halign(_align_h);
		draw_set_valign(_align_v);
		draw_set_font(_font);
		draw_set_alpha(_alpha);
		draw_set_color(_colour);
	
		if((_scale_x==1) && (_scale_y==1) && (_angle mod 360 == 0)){
			draw_text_ext(_x,_y,_string,_sep,_width);
			//draw_text(_x,_y,_string);
		}
		else{
			draw_text_ext_transformed(_x,_y,_string,_sep,_width,_scale_x,_scale_y,_angle);
			//draw_text_transformed(_x,_y,_string,_scale_x,_scale_y,_angle);
		}
	
		draw_set_alpha(1);
	}
}