if(instance_number(o_player) > 0) {
	var _player;
	_player = instance_find(o_player,0);
	_player.visible = true;
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
	var _camera_image_xscale = camera_image_xscale_restore;
	var _camera_image_yscale = camera_image_yscale_restore;
	var _camera_zoom_control_enable = camera_zoom_control_enable_restore;
	var _lighting_enable = lighting_was_enabled;
	with(o_camera) {
		state = _camera_state;
		follow_target_id = _camera_follow_target;
		stationary_target.Set(_camera_stationary_target_x,_camera_stationary_target_y);
		zoom_control_enable = _camera_zoom_control_enable;
		image_xscale = _camera_image_xscale;
		image_yscale = _camera_image_yscale;
		x = _camera_x;
		y = _camera_y;
		var _camera_transform = transform[TransformType.anchor];
		transform_set(_camera_transform,TransformValue.x,x,false);
		transform_set(_camera_transform,TransformValue.y,y,false);
		camera_zoom_set_dimensions();
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
