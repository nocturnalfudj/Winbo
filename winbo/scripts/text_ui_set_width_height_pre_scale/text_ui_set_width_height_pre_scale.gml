function text_ui_set_width_height_pre_scale() {
	draw_set_font(font);
	draw_set_halign(alignment_h);
	draw_set_valign(alignment_v);

	if(sep <= 0){
		sep = string_height_ext("M",-1,9999);
	}

	var _wrap_width = width_max;
	if(_wrap_width <= 0){
		_wrap_width = max(string_width(text_final_string),1);
	}

	var _txt_w = string_width_ext(text_final_string,sep,_wrap_width);

	width_actual = _txt_w;

	width_pre_scale = width_actual + 2*width_buff;
	if(width_max > 0){
		width_pre_scale = min(width_pre_scale,width_max);
	}
	width_pre_scale = max(width_pre_scale,width_min);

	height_pre_scale = string_height_ext(text_final_string,sep,_wrap_width);
	height_pre_scale = max(height_pre_scale + 2*height_buff,height_min);
}
