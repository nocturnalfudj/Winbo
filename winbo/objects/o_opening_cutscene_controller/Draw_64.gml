var _gui_width = display_get_gui_width();
var _gui_height = display_get_gui_height();
var _scale_x = _gui_width / 1920;
var _scale_y = _gui_height / 1080;

if(phase == OpeningCutscenePhase.interactive) {
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_colour(c_white);
	draw_set_font(fnt_bahnschrift_32);
	draw_set_colour(c_black);
	draw_text_transformed(_gui_width * 0.5 + 3 * _scale_x,_gui_height * 0.15 + 3 * _scale_y,"Press Jump",_scale_x,_scale_y,0);
	draw_set_colour(c_white);
	draw_text_transformed(_gui_width * 0.5,_gui_height * 0.15,"Press Jump",_scale_x,_scale_y,0);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

if(phase == OpeningCutscenePhase.title) {
	var _fade_in = clamp(title_elapsed / title_fade_duration,0,1);
	var _fade_out = clamp((title_duration - title_elapsed) / title_fade_duration,0,1);
	var _title_alpha = min(_fade_in,_fade_out);
	var _title_scale = min(_scale_x,_scale_y) * lerp(1.8,2.25,1 - power(1 - _fade_in,3));

	draw_set_alpha(_fade_in);
	draw_set_colour(c_black);
	draw_rectangle(0,0,_gui_width,_gui_height,false);

	draw_set_alpha(_title_alpha);
	draw_set_font(fnt_default_100);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_colour(make_colour_rgb(255,209,63));
	draw_text_transformed(_gui_width * 0.5,_gui_height * 0.5,"WINBO",_title_scale,_title_scale,0);

	draw_set_alpha(1);
	draw_set_colour(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}
