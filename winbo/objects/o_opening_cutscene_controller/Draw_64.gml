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
