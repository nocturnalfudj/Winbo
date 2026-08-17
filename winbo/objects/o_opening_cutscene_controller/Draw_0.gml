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
		m16_draw_y,
		soldier_scale,
		soldier_scale,
		0,
		c_white,
		1
	);
}

if(phase == OpeningCutscenePhase.intro
&& player_entry_started
&& instance_number(o_player) > 0) {
	var _player = instance_find(o_player,0);
	var _player_walking_in = !player_entry_motion_complete;
	var _player_sprite = _player_walking_in ? _player.sprite_walk : _player.sprite_idle;
	var _player_frame;
	if(_player_walking_in) {
		var _entry_walk_frame_count = sprite_get_number(_player_sprite);
		var _entry_walk_loop_start = min(4,_entry_walk_frame_count - 1);
		_player_frame = floor(player_entry_walk_elapsed * player_entry_animation_fps);
		if(_player_frame >= _entry_walk_frame_count) {
			_player_frame = _entry_walk_loop_start
				+ ((_player_frame - _entry_walk_loop_start)
				mod max(1,_entry_walk_frame_count - _entry_walk_loop_start));
		}
	}
	else {
		_player_frame = floor(player_entry_idle_elapsed * ANIMATION_FPS_DEFAULT)
			mod max(1,sprite_get_number(_player_sprite));
	}
	draw_sprite_ext(
		_player_sprite,
		_player_frame,
		player_entry_x,
		player_ground_y,
		1,
		1,
		0,
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
