var _gui_width = display_get_gui_width();
var _gui_height = display_get_gui_height();
var _scale_x = _gui_width / 1920;
var _scale_y = _gui_height / 1080;
var _asset_scale_x = _gui_width / 3840;
var _asset_scale_y = _gui_height / 2160;

draw_sprite_ext(spr_opening_bg_4,0,0,0,_asset_scale_x,_asset_scale_y,0,c_white,1);
draw_sprite_ext(spr_opening_bg_3,0,0,0,_asset_scale_x,_asset_scale_y,0,c_white,1);
draw_sprite_ext(spr_opening_bg_2,0,0,0,_asset_scale_x,_asset_scale_y,0,c_white,1);
draw_sprite_ext(spr_opening_bg_1,0,0,0,_asset_scale_x,_asset_scale_y,0,c_white,1);

draw_sprite_ext(
	spr_opening_cutscene_soldier,
	min(floor(soldier_frame),sprite_get_number(spr_opening_cutscene_soldier) - 1),
	sequence_draw_x * _asset_scale_x,
	sequence_draw_y * _asset_scale_y,
	_asset_scale_x,
	_asset_scale_y,
	0,
	c_white,
	1
);

if(soldier_frame >= 83) {
	draw_sprite_ext(spr_opening_cutscene_m16,0,sequence_draw_x * _asset_scale_x,sequence_draw_y * _asset_scale_y,_asset_scale_x,_asset_scale_y,0,c_white,1);
}

if(instance_number(o_player) > 0) {
	var _player = instance_find(o_player,0);
	var _player_x = _player.x - camera_fixed_x;
	var _player_y = _player.y - camera_fixed_y;
	var _player_walking_in = phase == OpeningCutscenePhase.intro && soldier_frame < player_entry_end_frame;
	var _player_sprite = _player_walking_in
		? _player.sprite_walk
		: ((phase == OpeningCutscenePhase.intro) ? _player.sprite_idle : _player.sprite_current);
	var _player_frame = (phase == OpeningCutscenePhase.intro)
		? floor(current_time * (ANIMATION_FPS_DEFAULT / 1000)) mod max(1,sprite_get_number(_player_sprite))
		: _player.sprite_current_frame;
	var _face = (phase == OpeningCutscenePhase.intro) ? 1 : sign(_player.face_horizontal * _player.sprite_face_direction);
	if(_face == 0) _face = 1;
	draw_sprite_ext(_player_sprite,_player_frame,_player_x,_player_y,_face,1,_player.image_angle,c_white,1);
}

if(stomp_smoke_pending && stomp_smoke_frame >= 0) {
	draw_sprite_ext(
		spr_smoke_explosion_large,
		min(floor(stomp_smoke_frame),sprite_get_number(spr_smoke_explosion_large) - 1),
		stomp_smoke_x * _asset_scale_x,
		stomp_smoke_y * _asset_scale_y,
		_asset_scale_x,
		_asset_scale_y,
		0,
		c_white,
		1
	);
}

draw_sprite_ext(spr_opening_bg_0,0,0,0,_asset_scale_x,_asset_scale_y,0,c_white,1);

if(phase == OpeningCutscenePhase.interactive) {
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_colour(c_white);
	draw_set_font(fnt_bahnschrift_32);
	draw_set_colour(c_black);
	draw_text_transformed(_gui_width * 0.5 + 3 * _scale_x,_gui_height * 0.15 + 3 * _scale_y,"Press W to Jump",_scale_x,_scale_y,0);
	draw_set_colour(c_white);
	draw_text_transformed(_gui_width * 0.5,_gui_height * 0.15,"Press W to Jump",_scale_x,_scale_y,0);
	if(prompt_elapsed >= prompt_move_delay) {
		draw_set_font(fnt_bahnschrift_16);
		draw_set_colour(c_black);
		draw_text_transformed(_gui_width * 0.5 + 2 * _scale_x,_gui_height * 0.21 + 2 * _scale_y,"A/D = Move Left/Right",_scale_x,_scale_y,0);
		draw_set_colour(c_white);
		draw_text_transformed(_gui_width * 0.5,_gui_height * 0.21,"A/D = Move Left/Right",_scale_x,_scale_y,0);
	}
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}
