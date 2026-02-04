function text_ui_set_width_height_pre_scale() {
	draw_set_font(font);
	draw_set_halign(alignment_h);
	draw_set_valign(alignment_v);

	var _txt_w = string_width(text_final_string);
	
	sep = string_height_ext(text_final_string,0,_txt_w);

	_txt_w = string_width_ext(text_final_string,sep,width_max);

	width_actual = _txt_w;
		
	width_pre_scale = max(min(width_actual + 2*width_buff,width_max),width_min);
	height_pre_scale = string_height_ext(text_final_string,sep,width_actual);
	height_pre_scale = max(height_pre_scale + 2*height_buff,height_min);
}