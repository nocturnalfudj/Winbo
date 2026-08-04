if(instance_number(o_player) > 0) {
	var _player;
	_player = instance_find(o_player,0);
	_player.visible = true;
	_player.state = PlayerState.move;
	_player.hp_vulnerable = player_hp_vulnerable_restore;
	_player.user.hp_vulnerable = player_user_hp_vulnerable_restore;
	if(player_move_limit_enable_x_restore) {
		with(_player) {
			movement_limit_enable_x(
				other.player_move_limit_x_min_restore,
				other.player_move_limit_x_max_restore
			);
		}
	}
	else {
		_player.move_limit_enable_x = false;
	}
}
with(soldier_solid_id) {
	collision_enable_x_in = false;
	collision_enable_x_left = false;
	collision_enable_x_right = false;
	collision_enable_y_in = false;
	collision_enable_y_up = false;
	collision_enable_y_down = false;
}
layer_set_visible("lyr_hud_front",hud_front_visible_restore);
layer_set_visible("lyr_hud",hud_visible_restore);
layer_set_visible("lyr_hud_back",hud_back_visible_restore);
if(instance_number(o_camera) > 0) {
	var _camera_state = camera_state_restore;
	var _camera_follow_target = camera_follow_target_restore;
	var _camera_stationary_target_x = camera_stationary_target_x_restore;
	var _camera_stationary_target_y = camera_stationary_target_y_restore;
	var _camera_x = camera_x_restore;
	var _camera_y = camera_y_restore;
	var _camera_zoom_control_enable = camera_zoom_control_enable_restore;
	var _camera_zoom_anchor_rest = camera_zoom_anchor_rest_restore;
	var _camera_zoom_relative_rest = camera_zoom_relative_rest_restore;
	var _lighting_enable = lighting_was_enabled;
	with(o_camera) {
		state = _camera_state;
		follow_target_id = _camera_follow_target;
		stationary_target.Set(_camera_stationary_target_x,_camera_stationary_target_y);
		zoom_control_enable = _camera_zoom_control_enable;
		zoom_anchor.rest = _camera_zoom_anchor_rest;
		zoom_relative.rest = _camera_zoom_relative_rest;
		transform_value_recoil(zoom_anchor,0,CAMERA_ZOOM_RECOIL_TIME,CAMERA_ZOOM_RECOIL_CURVE);
		transform_value_recoil(zoom_relative,0,CAMERA_ZOOM_RECOIL_TIME,CAMERA_ZOOM_RECOIL_CURVE);
		x = _camera_x;
		y = _camera_y;
		var _camera_transform = transform[TransformType.anchor];
		transform_set(_camera_transform,TransformValue.x,x,false);
		transform_set(_camera_transform,TransformValue.y,y,false);
		camera_view_pos_update();
		lighting_enable = _lighting_enable;
	}
}
if(voice_snd_id != noone) {
	opening_cutscene_sfx_stop(voice_snd_id);
	voice_snd_id = noone;
}
if(ambience_snd_id != noone) {
	opening_cutscene_sfx_stop(ambience_snd_id);
	ambience_snd_id = noone;
}
