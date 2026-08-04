// The normal paused/stopped camera state targets the menu origin and starts a
// zoom recoil. Reassert this room's stationary camera after every camera Step
// so pausing cannot move the canonical environment away from the cutscene.
opening_cutscene_layout_update(o_camera.width,o_camera.height);
var _camera_center_x = camera_center_x;
var _camera_center_y = camera_center_y;
var _camera_zoom_anchor_rest = camera_zoom_anchor_rest_restore;
var _camera_zoom_relative_rest = camera_zoom_relative_rest_restore;
with(o_camera) {
	state = CameraState.stationary;
	follow_target_id = noone;
	stationary_target.Set(_camera_center_x,_camera_center_y);
	zoom_control_enable = false;
	zoom_anchor.rest = _camera_zoom_anchor_rest;
	zoom_relative.rest = _camera_zoom_relative_rest;
	zoom_anchor.animating = false;
	zoom_relative.animating = false;
	zoom_updated = false;
	x = _camera_center_x;
	y = _camera_center_y;
	var _camera_transform = transform[TransformType.anchor];
	transform_set(_camera_transform,TransformValue.x,x,false);
	transform_set(_camera_transform,TransformValue.y,y,false);
	camera_view_pos_update();
	lighting_enable = false;
}

if(instance_number(o_player) == 0) exit;

var _player = instance_find(o_player,0);
_player.visible = phase != OpeningCutscenePhase.intro
	&& phase != OpeningCutscenePhase.title;

if(phase == OpeningCutscenePhase.intro) {
	// Keep gameplay logic from treating the scripted off-screen entry as an
	// out-of-room death before control is handed to the player.
	_player.state = PlayerState.stage_entrance;
	_player.hp_vulnerable = false;
	_player.user.hp_vulnerable = false;
	_player.x = player_entry_x;
	_player.y = player_ground_y;
	_player.move_grounded = true;
	var _player_transform = _player.transform[TransformType.anchor];
	transform_set(_player_transform,TransformValue.x,_player.x,false);
	transform_set(_player_transform,TransformValue.y,_player.y,false);
	_player.velocity.Set(0,0);
	_player.acceleration.Set(0,0);
}

// The opening is a focused tutorial beat; suppress the normal five-second
// secret idle so it cannot cover the prompt or replace Winbo's control pose.
with(_player) {
	if(secret_idle_phase != PLAYER_SECRET_IDLE_PHASE_INACTIVE || secret_idle_thought_fx != noone) {
		player_secret_idle_cancel(false);
	}
	secret_idle_inputless_time = 0;
}
