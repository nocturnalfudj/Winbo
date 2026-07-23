enum OpeningCutscenePhase {
	intro,
	interactive,
	defeat,
	exit
}

phase = OpeningCutscenePhase.intro;
soldier_frame = 0;
soldier_fps = 15;
beg_frame_first = 200;
beg_frame_last = 205;
defeat_frame_first = 214;
defeat_frame_last = 215;
player_entry_end_frame = 78;
prompt_elapsed = 0;
prompt_move_delay = 0.5;
transition_requested = false;

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

lighting_was_enabled = o_camera.lighting_enable;
o_camera.lighting_enable = false;

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
