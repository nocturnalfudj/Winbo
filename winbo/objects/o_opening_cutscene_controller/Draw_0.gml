var _walk_back_frame = clamp(
	soldier_frame - walk_back_frame_first,
	0,
	walk_back_frame_last - walk_back_frame_first
);
var _walk_back_coast_frames = walk_back_deceleration_frame_first - walk_back_frame_first;
var _walk_back_deceleration_frames = walk_back_frame_last - walk_back_deceleration_frame_first;
var _walk_back_effective_frames = _walk_back_coast_frames + _walk_back_deceleration_frames * 0.5;
var _walk_back_progress;

// Keep the authored gait speed through frame 123, then use the same coast-out
// shape as moving actors: continuous velocity that reaches zero at frame 132.
if(_walk_back_frame <= _walk_back_coast_frames) {
	_walk_back_progress = _walk_back_frame / _walk_back_effective_frames;
}
else {
	var _walk_back_deceleration_progress = (
		_walk_back_frame - _walk_back_coast_frames
	) / _walk_back_deceleration_frames;
	var _walk_back_deceleration_distance = _walk_back_deceleration_frames * 0.5
		* (1 - sqr(1 - _walk_back_deceleration_progress));
	_walk_back_progress = (
		_walk_back_coast_frames + _walk_back_deceleration_distance
	) / _walk_back_effective_frames;
}
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
	var _player_scripted_landing = phase == OpeningCutscenePhase.landing;
	var _player_scripted_idle = phase == OpeningCutscenePhase.interactive;
	var _player_scripted_exit = phase == OpeningCutscenePhase.exit;
	var _stomp_progress = _player_scripted_stomp ? clamp(stomp_elapsed / stomp_duration,0,1) : 0;
	var _defeat_progress = _player_scripted_defeat ? clamp(defeat_elapsed / defeat_duration,0,1) : 0;
	var _player_sprite = _player.sprite_current;
	if(_player_walking_in || _player_scripted_exit) {
		_player_sprite = _player.sprite_walk;
	}
	else if(phase == OpeningCutscenePhase.intro || _player_scripted_idle) {
		_player_sprite = _player.sprite_idle;
	}
	else if(_player_scripted_stomp) {
		_player_sprite = (_stomp_progress < 0.55)
			? _player.sprite_jump_sideways
			: _player.sprite_fall_sideways;
	}
	else if(_player_scripted_defeat) {
		_player_sprite = (_defeat_progress < 0.5)
			? _player.sprite_jump_sideways
			: _player.sprite_fall_sideways;
	}
	else if(_player_scripted_landing) {
		_player_sprite = _player.sprite_land_sideways;
	}

	var _player_scripted_draw = phase == OpeningCutscenePhase.intro
		|| _player_scripted_idle
		|| _player_scripted_stomp
		|| _player_scripted_defeat
		|| _player_scripted_landing
		|| _player_scripted_exit;
	var _player_frame = _player.sprite_current_frame;
	if(_player_scripted_landing) {
		_player_frame = min(
			floor(landing_elapsed * ANIMATION_FPS_DEFAULT),
			sprite_get_number(_player_sprite) - 1
		);
	}
	else if(_player_scripted_exit) {
		var _walk_frame_count = sprite_get_number(_player_sprite);
		var _walk_loop_start = min(4,_walk_frame_count - 1);
		_player_frame = 1 + floor(exit_elapsed * ANIMATION_FPS_DEFAULT);
		if(_player_frame >= _walk_frame_count) {
			_player_frame = _walk_loop_start
				+ ((_player_frame - _walk_loop_start) mod max(1,_walk_frame_count - _walk_loop_start));
		}
	}
	else if(_player_scripted_draw) {
		_player_frame = floor(current_time * (ANIMATION_FPS_DEFAULT / 1000))
			mod max(1,sprite_get_number(_player_sprite));
	}
	var _face = _player_scripted_draw ? 1 : sign(_player.face_horizontal * _player.sprite_face_direction);
	if(_face == 0) _face = 1;
	draw_sprite_ext(
		_player_sprite,
		_player_frame,
		_player.x,
		_player.y,
		_face,
		1,
		_player_scripted_draw ? 0 : _player.image_angle,
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
