enum OpeningCutscenePhase {
	intro,
	interactive,
	stomp,
	defeat,
	exit
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
player_entry_end_frame = 78;
dialogue_cue_frame = player_entry_end_frame;
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
walk_back_distance = 400;
stomp_elapsed = 0;
stomp_duration = 0.75;
stomp_arc_height = 320;
stomp_player_start_x = 0;
stomp_player_start_y = 0;
stomp_player_target_x = 0;
stomp_player_target_y = 0;
exit_player_x = 0;
exit_run_speed = 1800;
stomp_smoke_frame = -1;
stomp_smoke_fps = ANIMATION_FPS_DEFAULT;
stomp_smoke_delay_steps = 2;
stomp_smoke_step_count = 0;
stomp_smoke_pending = false;
stomp_smoke_x = 0;
stomp_smoke_y = 0;

// The opening art is authored as one 3840x2160 environment view at the bottom
// of the inherited gameplay room. Configure the persistent camera itself so
// the director's normal environment renderer and the application surface use
// the same fixed view throughout the cutscene.
scene_width = 3840;
scene_height = 2160;
camera_fixed_x = 0;
camera_fixed_y = room_height - scene_height;
camera_center_x = camera_fixed_x + scene_width * 0.5;
camera_center_y = camera_fixed_y + scene_height * 0.5;
camera_state_restore = o_camera.state;
camera_follow_target_restore = o_camera.follow_target_id;
camera_stationary_target_x_restore = o_camera.stationary_target.x;
camera_stationary_target_y_restore = o_camera.stationary_target.y;
camera_x_restore = o_camera.x;
camera_y_restore = o_camera.y;
camera_image_xscale_restore = o_camera.image_xscale;
camera_image_yscale_restore = o_camera.image_yscale;
camera_zoom_control_enable_restore = o_camera.zoom_control_enable;

var _camera_center_x = camera_center_x;
var _camera_center_y = camera_center_y;
var _scene_width = scene_width;
var _scene_height = scene_height;
with(o_camera) {
	state = CameraState.stationary;
	follow_target_id = noone;
	stationary_target.Set(_camera_center_x,_camera_center_y);
	zoom_control_enable = false;
	zoom_anchor.animating = false;
	zoom_relative.animating = false;
	image_xscale = _scene_width / (width_ini * zoom_resultant);
	image_yscale = _scene_height / (height_ini * zoom_resultant);
	x = _camera_center_x;
	y = _camera_center_y;
	var _camera_transform = transform[TransformType.anchor];
	transform_set(_camera_transform,TransformValue.x,x,false);
	transform_set(_camera_transform,TransformValue.y,y,false);
	camera_zoom_set_dimensions();
	camera_view_pos_update();
}

var _hud_front_layer = layer_get_id("lyr_hud_front");
var _hud_layer = layer_get_id("lyr_hud");
var _hud_back_layer = layer_get_id("lyr_hud_back");
hud_front_visible_restore = layer_get_visible(_hud_front_layer);
hud_visible_restore = layer_get_visible(_hud_layer);
hud_back_visible_restore = layer_get_visible(_hud_back_layer);
layer_set_visible(_hud_front_layer,false);
layer_set_visible(_hud_layer,false);
layer_set_visible(_hud_back_layer,false);
scene_scale = scene_height / 1080;
player_ground_y = 3620;
player_intro_x = -180 * scene_scale;
player_handoff_x = 525 * scene_scale;
player_exit_x = scene_width + 200;
player_hp_vulnerable_restore = true;
player_user_hp_vulnerable_restore = true;

// This is a unique, full-canvas scripted soldier rather than an Apocalypse
// Survivor reskin. Its sequence was authored at native scale for this scene.
sequence_draw_x = 850;
sequence_draw_y = 1122;
soldier_head_local_x = 1067.5;
soldier_head_local_y = 420;
soldier_foot_local_y = 795;
soldier_body_center_local_y = (soldier_head_local_y + soldier_foot_local_y) * 0.5;

// The source frames contain almost no translation during the backing-away
// walk, so move the soldier canvas explicitly and leave the dropped M16 put.
soldier_head_scene_x = sequence_draw_x + walk_back_distance + soldier_head_local_x;
soldier_head_scene_y = sequence_draw_y + soldier_head_local_y;
stomp_smoke_x = soldier_head_scene_x;
stomp_smoke_y = sequence_draw_y + soldier_body_center_local_y;

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
