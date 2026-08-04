var _walk_back_progress = clamp(
	(soldier_frame - walk_back_frame_first) / (walk_back_frame_last - walk_back_frame_first),
	0,
	1
);
var _soldier_draw_x = sequence_draw_x + walk_back_distance * _walk_back_progress;
var _sequence_draw_y = sequence_draw_y;

var _soldier_visible = phase < OpeningCutscenePhase.defeat
	|| (phase == OpeningCutscenePhase.defeat && stomp_smoke_frame < 0);
if(_soldier_visible) {
	draw_sprite_ext(
		spr_opening_cutscene_soldier,
		min(floor(soldier_frame),sprite_get_number(spr_opening_cutscene_soldier) - 1),
		_soldier_draw_x,
		_sequence_draw_y,
		soldier_scale,
		soldier_scale,
		0,
		c_white,
		1
	);
}

if(soldier_frame >= 83) {
	draw_sprite_ext(
		spr_opening_cutscene_m16,
		0,
		sequence_draw_x,
		_sequence_draw_y,
		soldier_scale,
		soldier_scale,
		0,
		c_white,
		1
	);
}

if(instance_number(o_player) > 0) {
	var _player = instance_find(o_player,0);
	var _player_walking_in = phase == OpeningCutscenePhase.intro && soldier_frame < player_entry_end_frame;
	var _player_scripted_stomp = phase == OpeningCutscenePhase.stomp;
	var _player_scripted_defeat = phase == OpeningCutscenePhase.defeat;
	var _player_scripted_idle = phase == OpeningCutscenePhase.interactive;
	var _player_scripted_exit = phase == OpeningCutscenePhase.exit;
	var _stomp_progress = _player_scripted_stomp ? clamp(stomp_elapsed / stomp_duration,0,1) : 0;
	var _defeat_progress = _player_scripted_defeat ? clamp(defeat_elapsed / defeat_duration,0,1) : 0;
	var _player_sprite = _player_walking_in
		? _player.sprite_walk
		: ((phase == OpeningCutscenePhase.intro || _player_scripted_idle)
			? _player.sprite_idle
			: (_player_scripted_stomp
				? ((_stomp_progress < 0.55) ? _player.sprite_jump_sideways : _player.sprite_fall_sideways)
				: (_player_scripted_defeat
					? ((_defeat_progress < 0.5) ? _player.sprite_jump_sideways : _player.sprite_fall_sideways)
					: (_player_scripted_exit ? _player.sprite_walk : _player.sprite_current))));
	var _player_scripted_draw = phase == OpeningCutscenePhase.intro
		|| _player_scripted_idle
		|| _player_scripted_stomp
		|| _player_scripted_defeat
		|| _player_scripted_exit;
	var _player_frame = _player_scripted_draw
		? floor(current_time * (ANIMATION_FPS_DEFAULT / 1000)) mod max(1,sprite_get_number(_player_sprite))
		: _player.sprite_current_frame;
	var _face = _player_scripted_draw ? 1 : sign(_player.face_horizontal * _player.sprite_face_direction);
	if(_face == 0) _face = 1;
	draw_sprite_ext(
		_player_sprite,
		_player_frame,
		_player.x,
		_player.y,
		_face,
		1,
		(_player_scripted_stomp || _player_scripted_defeat) ? 0 : _player.image_angle,
		c_white,
		1
	);
}

if(stomp_smoke_pending && stomp_smoke_frame >= 0) {
	draw_sprite_ext(
		spr_smoke_explosion_large,
		min(floor(stomp_smoke_frame),sprite_get_number(spr_smoke_explosion_large) - 1),
		stomp_smoke_x,
		stomp_smoke_y,
		1,
		1,
		0,
		c_white,
		1
	);
}
