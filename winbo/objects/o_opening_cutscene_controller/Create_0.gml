enum OpeningCutscenePhase {
	intro,
	interactive,
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
prompt_elapsed = 0;
prompt_move_delay = 0.5;
transition_requested = false;
stomp_smoke_frame = -1;
stomp_smoke_fps = ANIMATION_FPS_DEFAULT;
stomp_smoke_delay_steps = 2;
stomp_smoke_step_count = 0;
stomp_smoke_pending = false;
stomp_smoke_x = 0;
stomp_smoke_y = 0;

// The menu and gameplay rooms can leave the persistent camera at different
// coordinates and sizes. Anchor this room to the authored 3840x2160 view so
// the world-space player always matches the GUI-space cutscene ground.
scene_width = 3840;
scene_height = 2160;
camera_fixed_x = 0;
camera_fixed_y = room_height - scene_height;
camera_set_view_size(view_camera[0],scene_width,scene_height);
camera_set_view_pos(view_camera[0],camera_fixed_x,camera_fixed_y);
scene_scale = scene_height / 1080;
player_ground_y = 3620;
player_intro_x = -180 * scene_scale;
player_handoff_x = 525 * scene_scale;
player_gate_x = 1250 * scene_scale;
player_exit_x = scene_width;
player_bottom_previous = 0;
player_hp_vulnerable_restore = true;
player_user_hp_vulnerable_restore = true;

// The cutscene art is authored for the 3840x2160 background. Keep the
// 1316x1080 soldier sequence at native size rather than doubling it.
// Its full-canvas frames also contain the authored backing-away movement.
sequence_draw_x = 850;
sequence_draw_y = 1122;
stomp_smoke_x = sequence_draw_x + 1067.5;
stomp_smoke_y = sequence_draw_y + 420;

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
