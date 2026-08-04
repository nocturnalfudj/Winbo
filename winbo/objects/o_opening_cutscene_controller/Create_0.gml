enum OpeningCutscenePhase {
	intro,
	interactive,
	stomp,
	defeat,
	landing,
	exit,
	title
}

phase = OpeningCutscenePhase.intro;
soldier_frame = 0;
soldier_fps = 15;
intro_preroll_elapsed = 0;
intro_preroll_duration = 1;
intro_preroll_frame_count = 15;
beg_frame_first = 200;
beg_frame_last = 205;
defeat_frame_first = 214;
defeat_frame_last = 215;
defeat_elapsed = 0;
defeat_duration = 0.8;
defeat_sequence_duration = (defeat_frame_last - defeat_frame_first + 1) / soldier_fps;
player_entry_arrival_frame = 78;
player_entry_frame_first = 0;
player_entry_stop_speed = 0.05;
player_entry_x = 0;
player_entry_velocity = 0;
player_entry_motion_complete = false;
player_entry_walk_elapsed = 0;
player_entry_idle_elapsed = 0;
dialogue_played = false;
voice_snd_id = noone;
opening_cutscene_sfx_stop = function(_sound_instance) {
	if(_sound_instance == noone) return;

	var _sound_list = o_audio.channel[AudioChannel.sfx][AudioChannelProperty.sound_list];
	var _sound_index = ds_list_find_index(_sound_list,_sound_instance);
	if(_sound_index < 0) return;

	ds_list_delete(_sound_list,_sound_index);
	o_audio.channel[AudioChannel.sfx][AudioChannelProperty.sound_num] = max(
		0,
		o_audio.channel[AudioChannel.sfx][AudioChannelProperty.sound_num] - 1
	);
	audio_stop_sound(_sound_instance);
};
transition_requested = false;
walk_back_frame_first = 99;
walk_back_frame_last = 132;
walk_back_deceleration_frame_first = 123;
walk_back_distance = 0;
stomp_elapsed = 0;
stomp_duration = 0.75;
stomp_arc_height = 0;
stomp_player_start_x = 0;
stomp_player_start_y = 0;
stomp_player_target_x = 0;
stomp_player_target_y = 0;
landing_elapsed = 0;
landing_frame_count = sprite_get_number(spr_player_land_sideways);
// Normal movement releases the landing block as soon as the last frame has
// rendered once, rather than holding that frame for a full animation interval.
landing_duration = (landing_frame_count - 1) / ANIMATION_FPS_DEFAULT + 1 / SECOND;
exit_player_x = 0;
exit_elapsed = 0;
exit_player_velocity = 0;
exit_velocity_retention = 0.7;
exit_move_acceleration = 3;
title_elapsed = 0;
title_duration = 2.5;
title_fade_duration = 0.4;
stomp_smoke_frame = -1;
stomp_smoke_fps = ANIMATION_FPS_DEFAULT;
stomp_smoke_delay_elapsed = 0;
stomp_smoke_pending = false;
stomp_smoke_x = 0;
stomp_smoke_y = 0;

// Keep the normal gameplay camera dimensions and lock only its position. The
// director remains the sole owner of the opening environment at every
// resolution, exactly as it is in the other gameplay rooms.
scene_authored_width = 3840;
scene_authored_height = 2160;
camera_state_restore = o_camera.state;
camera_follow_target_restore = o_camera.follow_target_id;
camera_stationary_target_x_restore = o_camera.stationary_target.x;
camera_stationary_target_y_restore = o_camera.stationary_target.y;
camera_x_restore = o_camera.x;
camera_y_restore = o_camera.y;
camera_zoom_control_enable_restore = o_camera.zoom_control_enable;
camera_zoom_anchor_rest_restore = o_camera.zoom_anchor.rest;
camera_zoom_relative_rest_restore = o_camera.zoom_relative.rest;

var _hud_front_layer = layer_get_id("lyr_hud_front");
var _hud_layer = layer_get_id("lyr_hud");
var _hud_back_layer = layer_get_id("lyr_hud_back");
hud_front_visible_restore = layer_get_visible(_hud_front_layer);
hud_visible_restore = layer_get_visible(_hud_layer);
hud_back_visible_restore = layer_get_visible(_hud_back_layer);
layer_set_visible(_hud_front_layer,false);
layer_set_visible(_hud_layer,false);
layer_set_visible(_hud_back_layer,false);
player_hp_vulnerable_restore = true;
player_user_hp_vulnerable_restore = true;

// The cutscene soldier portrays the Apocalypse Survivor. Match that enemy's
// normal 0.75 gameplay scale while retaining the artist-authored sequence.
soldier_scale = 0.75;
soldier_head_local_x = 1067.5;
soldier_head_local_y = 420;
soldier_foot_local_y = 795;
m16_bottom_local_y = 790;
m16_draw_y = 0;
environment_ground_local_y = 1922;
environment_ground_y = 0;
player_foot_local_y = sprite_get_bbox_bottom(spr_player_idle)
	- sprite_get_yoffset(spr_player_idle);
opening_platform_id = instance_find(o_platform,0);
opening_platform_top_offset_y = (
	sprite_get_bbox_top(spr_platform) - sprite_get_yoffset(spr_platform)
) * opening_platform_id.image_yscale;
soldier_body_center_local_y = (soldier_head_local_y + soldier_foot_local_y) * 0.5;
var _landing_sprite = spr_player_fall_sideways;
landing_center_x = (sprite_get_bbox_left(_landing_sprite)
	+ sprite_get_bbox_right(_landing_sprite)) * 0.5
	- sprite_get_xoffset(_landing_sprite);
landing_bottom_y = sprite_get_bbox_bottom(_landing_sprite)
	- sprite_get_yoffset(_landing_sprite);

// The source frames contain almost no translation during the backing-away
// walk, so move the soldier canvas explicitly and leave the dropped M16 put.
// Recalculate view-relative choreography through the canonical camera system;
// this keeps the environment and actors aligned after a resolution change.
opening_cutscene_layout_update = function(_scene_width,_scene_height) {
	scene_width = _scene_width;
	scene_height = _scene_height;
	camera_fixed_x = 0;
	camera_fixed_y = max(0,room_height - scene_height);
	camera_center_x = camera_fixed_x + scene_width * 0.5;
	camera_center_y = camera_fixed_y + scene_height * 0.5;

	var _view_cover_scale = max(
		scene_width / scene_authored_width,
		scene_height / scene_authored_height
	);
	var _view_cover_y = camera_fixed_y + scene_height
		- scene_authored_height * _view_cover_scale;
	environment_ground_y = _view_cover_y
		+ environment_ground_local_y * _view_cover_scale;
	player_ground_y = environment_ground_y - player_foot_local_y;
	opening_platform_id.y = environment_ground_y - opening_platform_top_offset_y;
	player_intro_x = -0.09375 * scene_width;
	player_handoff_x = 0.2734375 * scene_width;
	player_exit_x = 1.0520833333 * scene_width;
	var _entry_distance = player_handoff_x - player_intro_x;
	var _entry_steady_velocity = exit_move_acceleration * exit_velocity_retention
		/ (1 - exit_velocity_retention);
	var _entry_steady_step_distance = _entry_steady_velocity
		+ exit_move_acceleration * 0.5;
	var _entry_coast_steps = ceil(
		ln(player_entry_stop_speed / _entry_steady_velocity)
		/ ln(exit_velocity_retention)
	);
	var _entry_duration = _entry_distance / (_entry_steady_step_distance * SECOND)
		+ _entry_coast_steps / SECOND;
	player_entry_frame_first = max(
		0,
		player_entry_arrival_frame - soldier_fps * _entry_duration
	);
	stomp_arc_height = (320 / scene_authored_height) * scene_height;
	defeat_bounce_height = (240 / scene_authored_height) * scene_height;

	walk_back_distance = (400 / scene_authored_height) * scene_height;
	// At 1080p the soldier begins 200px left of centre, then backs to centre.
	soldier_head_x = camera_center_x;
	soldier_ground_y = environment_ground_y;
	sequence_draw_x = soldier_head_x - walk_back_distance - soldier_head_local_x * soldier_scale;
	sequence_draw_y = soldier_ground_y - soldier_foot_local_y * soldier_scale;
	m16_draw_y = soldier_ground_y - m16_bottom_local_y * soldier_scale;
	soldier_head_y = sequence_draw_y + soldier_head_local_y * soldier_scale;
	stomp_player_start_x = camera_fixed_x + player_handoff_x;
	stomp_player_start_y = player_ground_y;
	stomp_player_target_x = soldier_head_x - landing_center_x;
	stomp_player_target_y = soldier_head_y - landing_bottom_y;
	stomp_smoke_x = soldier_head_x;
	stomp_smoke_y = sequence_draw_y + soldier_body_center_local_y * soldier_scale;
};
opening_cutscene_layout_update(o_camera.width,o_camera.height);
player_entry_x = camera_fixed_x + player_intro_x;

var _camera_center_x = camera_center_x;
var _camera_center_y = camera_center_y;
with(o_camera) {
	state = CameraState.stationary;
	follow_target_id = noone;
	stationary_target.Set(_camera_center_x,_camera_center_y);
	zoom_control_enable = false;
	zoom_anchor.animating = false;
	zoom_relative.animating = false;
	zoom_updated = false;
	x = _camera_center_x;
	y = _camera_center_y;
	var _camera_transform = transform[TransformType.anchor];
	transform_set(_camera_transform,TransformValue.x,x,false);
	transform_set(_camera_transform,TransformValue.y,y,false);
	camera_view_pos_update();
}

lighting_was_enabled = o_camera.lighting_enable;
o_camera.lighting_enable = false;
ambience_snd_id = audio_sound_play(
	snd_opening_cutscene_forest_ambience,
	AudioChannel.sfx,
	true,
	0,
	0,
	false,
	1,
	1
);

if(instance_number(o_player) > 0) {
	var _player = instance_find(o_player,0);
	if(_player.state == PlayerState.stage_entrance) {
		player_hp_vulnerable_restore = _player.stage_entrance_hp_vulnerable_previous;
		player_user_hp_vulnerable_restore = _player.stage_entrance_user_hp_vulnerable_previous;
	}
	else {
		player_hp_vulnerable_restore = _player.hp_vulnerable;
		player_user_hp_vulnerable_restore = _player.user.hp_vulnerable;
	}
	exit_velocity_retention = _player.velocity_retention_default;
	exit_move_acceleration = _player.input_move_acceleration_default;
	_player.visible = false;
	_player.x = camera_fixed_x + player_intro_x;
	_player.y = player_ground_y;
	var _player_transform = _player.transform[TransformType.anchor];
	transform_set(_player_transform,TransformValue.x,_player.x,false);
	transform_set(_player_transform,TransformValue.y,_player.y,false);
	_player.velocity.Set(0,0);
	_player.acceleration.Set(0,0);
	with(_player) {
		// The normal room-entry flow may already have begun this state before
		// the cutscene controller is finalized. Do not begin it twice or the
		// second call records the temporary invulnerability as the restore value.
		if(state != PlayerState.stage_entrance) player_stage_entrance_begin();
		state = PlayerState.stage_entrance;
	}
}
