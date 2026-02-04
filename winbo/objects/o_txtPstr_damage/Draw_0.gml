if(!gui && camera_visible){
	var _string,_sep,_width,_width_actual;
	_string = text_final_string;
	_sep = sep;
	_width = width;
	_width_actual = width_actual;

	var _x,_y,_angle,_colour,_alpha,_scale_x,_scale_y;
	_x = x;
	_y = y;
	_alpha = image_alpha;
	_colour = image_blend;
	_angle = image_angle;
	_scale_x = image_xscale;
	_scale_y = image_yscale;
	
	var _shadow_scale;
	_shadow_scale = (1 - flash_alpha);
	
	if(shadow_enable){
		var _shadow_x,_shadow_y;
		_shadow_x = _x + shadow_x*_scale_x*_shadow_scale;
		_shadow_y = _y + shadow_y*_scale_y*_shadow_scale;
		draw_text_ext_transformed_ags(_shadow_x,_shadow_y,_string,_sep,_width_actual,_scale_x,_scale_y,_angle,shadow_c,_alpha*shadow_alpha,alignment_h,alignment_v,font);
	}

	draw_text_ext_transformed_ags(_x,_y,_string,_sep,_width_actual,_scale_x,_scale_y,_angle,_colour,_alpha,alignment_h,alignment_v,font);
	
	var _crit_x,_crit_y;
	if(critical){
		shader_set(sh_monochrome);
		_crit_x = _x + (125 + shadow_x*_shadow_scale)*_scale_x;
		_crit_y = _y + (30 + shadow_y*_shadow_scale) * _scale_y;
		draw_sprite_ext_ags(spr_critical_hit_icon,0,_crit_x,_crit_y,_scale_x,_scale_y,_angle,c_white,_alpha);
		shader_reset();
		
		_crit_x = _x + 125*_scale_x;
		_crit_y = _y + 30 * _scale_y;
		draw_sprite_ext_ags(spr_critical_hit_icon,0,_crit_x,_crit_y,_scale_x,_scale_y,_angle,c_white,_alpha);
	}
	if(critical_super){
		shader_set(sh_monochrome);
		_crit_x = _x + (240 + shadow_x*_shadow_scale)*_scale_x;
		_crit_y = _y + (40 + shadow_y*_shadow_scale) * _scale_y;
		draw_sprite_ext_ags(spr_super_critical_hit_icon_1,0,_crit_x,_crit_y,_scale_x,_scale_y,_angle,c_white,_alpha);
		shader_reset();
		
		_crit_x = _x + 240*_scale_x;
		_crit_y = _y + 40 * _scale_y;
		draw_sprite_ext_ags(spr_super_critical_hit_icon,0,_crit_x,_crit_y,_scale_x,_scale_y,_angle,c_white,_alpha);
	}
	
	if(flash_alpha > 0){
		shader_set(sh_monochrome);
		draw_text_ext_transformed_ags(_x,_y,_string,_sep,_width_actual,_scale_x,_scale_y,_angle,c_white,flash_alpha,alignment_h,alignment_v,font);
	
		if(critical){
			_crit_x = _x + 125*_scale_x;
			_crit_y = _y + 30 * _scale_y;
			draw_sprite_ext_ags(spr_critical_hit_icon,0,_crit_x,_crit_y,_scale_x,_scale_y,_angle,c_white,flash_alpha);
		}
		if(critical_super){
			_crit_x = _x + 240*_scale_x;
			_crit_y = _y + 40 * _scale_y;
			draw_sprite_ext_ags(spr_super_critical_hit_icon,0,_crit_x,_crit_y,_scale_x,_scale_y,_angle,c_white,flash_alpha);
		}
		
		shader_reset();
	}
}