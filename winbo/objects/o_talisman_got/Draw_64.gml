var _gui_width = display_get_gui_width();
var _gui_height = display_get_gui_height();

if(phase == TalismanGotPhase.fade_to_white){
	draw_set_colour(c_white);
	draw_set_alpha(fade_time / TALISMAN_GOT_FADE_TIME);
	draw_rectangle(0, 0, _gui_width, _gui_height, false);
	draw_set_alpha(1);
	exit;
}

// Hold white until the decoder hands over its first frame.
var _video = video_draw();
if(_video[0] != 0){
	draw_set_colour(c_white);
	draw_rectangle(0, 0, _gui_width, _gui_height, false);
	exit;
}
if(video_get_format() == video_format_rgba){
	draw_surface_stretched(_video[1], 0, 0, _gui_width, _gui_height);
}
else{
	shader_set(sh_video_yuv);
	texture_set_stage(video_chroma_sampler, surface_get_texture(_video[2]));
	draw_surface_stretched(_video[1], 0, 0, _gui_width, _gui_height);
	shader_reset();
}

// The talisman frames share the video's 3840x2160 framing at half resolution.
var _frame = floor(play_time * TALISMAN_GOT_FPS / SECOND);
if(_frame < TALISMAN_GOT_FIRST_FRAME) exit;
if(_frame > TALISMAN_GOT_LOOP_END){
	_frame = TALISMAN_GOT_LOOP_START + ((_frame - TALISMAN_GOT_LOOP_START) mod (TALISMAN_GOT_LOOP_END + 1 - TALISMAN_GOT_LOOP_START));
}
draw_sprite_ext(talisman_sprite, _frame - TALISMAN_GOT_FIRST_FRAME, _gui_width * 0.5, _gui_height * 0.5,
	2 * _gui_width / 3840, 2 * _gui_height / 2160, 0, c_white, 1);
