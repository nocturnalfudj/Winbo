enum OpeningCutscenePhase {
	intro,
	interactive,
	defeat,
	exit,
	title
}

phase = OpeningCutscenePhase.intro;
soldier_frame = 0;
soldier_fps = 15;
intro_preroll_elapsed = 0;
intro_preroll_duration = 2;
intro_preroll_frame_count = 15;
beg_frame_first = 200;
beg_frame_last = 205;
defeat_frame_first = 214;
defeat_frame_last = 215;
defeat_elapsed = 0;
defeat_duration = 0.8;
defeat_sequence_duration = (defeat_frame_last - defeat_frame_first + 1) / soldier_fps;
soldier_notice_frame = 78;
soldier_notice_delay_duration = 0.5;
player_entry_arrival_frame = soldier_notice_frame
	- soldier_fps * soldier_notice_delay_duration;
player_entry_frame_first = 0;
player_entry_stop_speed = 0.05;
player_entry_x = 0;
player_entry_velocity = 0;
player_entry_velocity_retention = 0.7;
player_entry_move_acceleration = 1.5;
player_entry_animation_fps = ANIMATION_FPS_DEFAULT;
player_entry_motion_complete = false;
player_entry_walk_elapsed = 0;
player_entry_idle_elapsed = 0;
player_bottom_previous = 0;
prompt_elapsed = 0;
prompt_move_delay = 1.25;
prompt_input_type = Input.mouse_and_keyboard;
prompt_input_type_initialized = false;
prompt_controls = [UserControl.jump,UserControl.left,UserControl.right];
prompt_jump_key = noone;
prompt_left_key = noone;
prompt_right_key = noone;
prompt_jump_sprite = noone;
prompt_left_sprite = noone;
prompt_right_sprite = noone;
prompt_jump_label = "W";
prompt_left_label = "A";
prompt_right_label = "D";
prompt_use_sprites = false;
dialogue_played = false;
voice_snd_id = noone;
opening_cutscene_sfx_stop = function(_sound_instance) {
	if(_sound_instance == noone) return;
	audio_stop_sound(_sound_instance);
};
opening_cutscene_prompt_label_get = function(_input_type,_key) {
	if(_key == noone) return "Unbound";
	if(_input_type == Input.mouse) {
		return ds_list_find_value(global.mouse_keycode_list,_key);
	}
	if(_input_type == Input.gamepad) {
		return ds_list_find_value(global.gamepad_keycode_list,_key);
	}
	if(_input_type == Input.mouse_and_keyboard
	&& (_key == mb_left || _key == mb_right || _key == mb_middle)) {
		return ds_list_find_value(global.mouse_keycode_list,_key);
	}
	return ds_list_find_value(global.keyboard_keycode_list,_key);
};
opening_cutscene_prompt_update = function() {
	var _user = o_input.user[0];
	var _input_type = _user.input;
	if(_input_type == Input.mouse_and_keyboard_and_gamepad) {
		var _gamepad_device = _user.input_device;
		var _gamepad_active = abs(input_check_gamepad(_gamepad_device,gp_axislh)) > 0
			|| abs(input_check_gamepad(_gamepad_device,gp_axislv)) > 0
			|| abs(input_check_gamepad(_gamepad_device,gp_axisrh)) > 0
			|| abs(input_check_gamepad(_gamepad_device,gp_axisrv)) > 0;
		var _mouse_keyboard_active = false;
		for(var _control_index=0;_control_index<array_length(prompt_controls);_control_index++) {
			var _control = prompt_controls[_control_index];
			var _gamepad_key = _user.control[_control].input[Input.gamepad][InputProperty.key];
			var _mouse_keyboard_key = _user.control[_control]
				.input[Input.mouse_and_keyboard][InputProperty.key];
			if(_gamepad_key != noone) {
				_gamepad_active = _gamepad_active
					|| input_check_gamepad(_gamepad_device,_gamepad_key);
			}
			if(_mouse_keyboard_key != noone) {
				_mouse_keyboard_active = _mouse_keyboard_active
					|| input_check_keyboard_mouse(_mouse_keyboard_key);
			}
		}

		if(_gamepad_active) {
			prompt_input_type = Input.gamepad;
		}
		else if(_mouse_keyboard_active) {
			prompt_input_type = Input.mouse_and_keyboard;
		}
		else if(!prompt_input_type_initialized) {
			prompt_input_type = _user.gamepad_using
				? Input.gamepad
				: Input.mouse_and_keyboard;
		}
		_input_type = prompt_input_type;
	}
	if(_input_type != Input.gamepad
	&& _input_type != Input.mouse
	&& _input_type != Input.keyboard
	&& _input_type != Input.mouse_and_keyboard) {
		_input_type = Input.mouse_and_keyboard;
	}

	prompt_input_type = _input_type;
	prompt_input_type_initialized = true;
	prompt_jump_key = _user.control[UserControl.jump].input[_input_type][InputProperty.key];
	prompt_left_key = _user.control[UserControl.left].input[_input_type][InputProperty.key];
	prompt_right_key = _user.control[UserControl.right].input[_input_type][InputProperty.key];
	prompt_jump_sprite = _user.control[UserControl.jump].input[_input_type][InputProperty.sprite];
	prompt_left_sprite = _user.control[UserControl.left].input[_input_type][InputProperty.sprite];
	prompt_right_sprite = _user.control[UserControl.right].input[_input_type][InputProperty.sprite];
	prompt_jump_label = opening_cutscene_prompt_label_get(_input_type,prompt_jump_key);
	prompt_left_label = opening_cutscene_prompt_label_get(_input_type,prompt_left_key);
	prompt_right_label = opening_cutscene_prompt_label_get(_input_type,prompt_right_key);
	prompt_use_sprites = _input_type == Input.gamepad
		&& prompt_jump_sprite != noone
		&& prompt_left_sprite != noone
		&& prompt_right_sprite != noone;
};
transition_requested = false;
title_card_enabled = false;
title_elapsed = 0;
title_black_fade_duration = 0.4;
title_text_fade_in_duration = 1;
title_text_hold_duration = 1.2;
title_text_fade_out_duration = 0.4;
title_duration = title_black_fade_duration
	+ title_text_fade_in_duration
	+ title_text_hold_duration
	+ title_text_fade_out_duration;
title_player_lock_x = 0;
title_player_lock_y = 0;
player_screen_bound_margin = 64;
player_move_limit_enable_x_restore = false;
player_move_limit_x_min_restore = 0;
player_move_limit_x_max_restore = 0;
walk_back_frame_first = 99;
walk_back_frame_last = 132;
walk_back_deceleration_frame_first = 123;
walk_back_distance = 0;
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

// The interactive frames occupy x=900..1129 and y=412..795 in the authored
// canvas. Add modest side/top forgiveness so the whole visible soldier reads
// as solid and any clearly landed jump counts, rather than only his head.
soldier_collision_local_left = 880;
soldier_collision_local_right = 1150;
soldier_collision_local_top = 400;
soldier_collision_local_bottom = 795;
soldier_solid_left = 0;
soldier_solid_right = 0;
soldier_solid_top = 0;
soldier_solid_bottom = 0;
soldier_solid_id = instance_create_layer(0,0,"lyr_opening_level_walls",o_platform);
with(soldier_solid_id) {
	visible = false;
	collision_enable_x_in = false;
	collision_enable_x_left = false;
	collision_enable_x_right = false;
	collision_enable_y_in = false;
	collision_enable_y_up = false;
	collision_enable_y_down = false;
}

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
	player_handoff_x = 0.14 * scene_width;
	var _entry_distance = player_handoff_x - player_intro_x;
	var _entry_steady_velocity = player_entry_move_acceleration
		* player_entry_velocity_retention
		/ (1 - player_entry_velocity_retention);
	var _entry_steady_step_distance = _entry_steady_velocity
		+ player_entry_move_acceleration * 0.5;
	var _entry_coast_steps = ceil(
		ln(player_entry_stop_speed / _entry_steady_velocity)
		/ ln(player_entry_velocity_retention)
	);
	var _entry_duration = _entry_distance / (_entry_steady_step_distance * SECOND)
		+ _entry_coast_steps / SECOND;
	player_entry_frame_first = max(
		0,
		player_entry_arrival_frame - soldier_fps * _entry_duration
	);
	walk_back_distance = (400 / scene_authored_height) * scene_height;
	// At 1080p the soldier begins 200px left of centre, then backs to centre.
	soldier_head_x = camera_center_x;
	soldier_ground_y = environment_ground_y;
	sequence_draw_x = soldier_head_x - walk_back_distance - soldier_head_local_x * soldier_scale;
	sequence_draw_y = soldier_ground_y - soldier_foot_local_y * soldier_scale;
	m16_draw_y = soldier_ground_y - m16_bottom_local_y * soldier_scale;
	soldier_solid_left = sequence_draw_x + walk_back_distance
		+ soldier_collision_local_left * soldier_scale;
	soldier_solid_right = sequence_draw_x + walk_back_distance
		+ soldier_collision_local_right * soldier_scale;
	soldier_solid_top = sequence_draw_y + soldier_collision_local_top * soldier_scale;
	soldier_solid_bottom = sequence_draw_y + soldier_collision_local_bottom * soldier_scale;
	var _solid_sprite_width = sprite_get_bbox_right(spr_platform)
		- sprite_get_bbox_left(spr_platform) + 1;
	var _solid_sprite_height = sprite_get_bbox_bottom(spr_platform)
		- sprite_get_bbox_top(spr_platform) + 1;
	var _solid_scale_x = (soldier_solid_right - soldier_solid_left)
		/ _solid_sprite_width;
	var _solid_scale_y = (soldier_solid_bottom - soldier_solid_top)
		/ _solid_sprite_height;
	var _solid_local_left = sprite_get_bbox_left(spr_platform)
		- sprite_get_xoffset(spr_platform);
	var _solid_local_top = sprite_get_bbox_top(spr_platform)
		- sprite_get_yoffset(spr_platform);
	var _soldier_solid_x = soldier_solid_left - _solid_local_left * _solid_scale_x;
	var _soldier_solid_y = soldier_solid_top - _solid_local_top * _solid_scale_y;
	with(soldier_solid_id) {
		x = _soldier_solid_x;
		y = _soldier_solid_y;
		image_xscale = _solid_scale_x;
		image_yscale = _solid_scale_y;
	}
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
	player_move_limit_enable_x_restore = _player.move_limit_enable_x;
	if(player_move_limit_enable_x_restore) {
		player_move_limit_x_min_restore = _player.move_limit_x.x;
		player_move_limit_x_max_restore = _player.move_limit_x.y;
	}
	if(_player.state == PlayerState.stage_entrance) {
		player_hp_vulnerable_restore = _player.stage_entrance_hp_vulnerable_previous;
		player_user_hp_vulnerable_restore = _player.stage_entrance_user_hp_vulnerable_previous;
	}
	else {
		player_hp_vulnerable_restore = _player.hp_vulnerable;
		player_user_hp_vulnerable_restore = _player.user.hp_vulnerable;
	}
	player_entry_velocity_retention = _player.velocity_retention_default;
	player_entry_move_acceleration = _player.input_move_acceleration_default * 0.5;
	opening_cutscene_layout_update(o_camera.width,o_camera.height);
	player_entry_x = camera_fixed_x + player_intro_x;
	_player.visible = false;
	_player.x = player_entry_x;
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
opening_cutscene_prompt_update();
