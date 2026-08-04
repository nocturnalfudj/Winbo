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
_player.visible = false;

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
else if(phase == OpeningCutscenePhase.interactive) {
	// The card specifies a single jump-button prompt followed by a scripted
	// stomp. Keep Winbo staged while still allowing player_input() to poll it.
	_player.x = camera_fixed_x + player_handoff_x;
	_player.y = player_ground_y;
	_player.velocity.Set(0,0);
	_player.acceleration.Set(0,0);
	_player.move_grounded = true;
	transform_set(_player.transform[TransformType.anchor],TransformValue.x,_player.x,false);
	transform_set(_player.transform[TransformType.anchor],TransformValue.y,_player.y,false);
}
else if(phase == OpeningCutscenePhase.stomp) {
	var _stomp_progress = clamp(stomp_elapsed / stomp_duration,0,1);
	var _stomp_eased = _stomp_progress * _stomp_progress * (3 - 2 * _stomp_progress);
	_player.x = lerp(stomp_player_start_x,stomp_player_target_x,_stomp_eased);
	_player.y = lerp(stomp_player_start_y,stomp_player_target_y,_stomp_eased)
		- 4 * stomp_arc_height * _stomp_progress * (1 - _stomp_progress);
	_player.velocity.Set(0,0);
	_player.acceleration.Set(0,0);
	_player.move_grounded = false;
	_player.state = PlayerState.stage_entrance;
	transform_set(_player.transform[TransformType.anchor],TransformValue.x,_player.x,false);
	transform_set(_player.transform[TransformType.anchor],TransformValue.y,_player.y,false);
}
else if(phase == OpeningCutscenePhase.defeat) {
	var _defeat_progress = clamp(defeat_elapsed / defeat_duration,0,1);
	var _defeat_eased = _defeat_progress * _defeat_progress * (3 - 2 * _defeat_progress);
	_player.x = stomp_player_target_x;
	_player.y = lerp(stomp_player_target_y,player_ground_y,_defeat_eased)
		- 4 * defeat_bounce_height * _defeat_progress * (1 - _defeat_progress);
	_player.velocity.Set(0,0);
	_player.acceleration.Set(0,0);
	_player.move_grounded = _defeat_progress >= 1;
	_player.state = PlayerState.stage_entrance;
	transform_set(_player.transform[TransformType.anchor],TransformValue.x,_player.x,false);
	transform_set(_player.transform[TransformType.anchor],TransformValue.y,_player.y,false);
}
else if(phase == OpeningCutscenePhase.landing) {
	_player.x = stomp_player_target_x;
	_player.y = player_ground_y;
	_player.velocity.Set(0,0);
	_player.acceleration.Set(0,0);
	_player.move_grounded = true;
	_player.state = PlayerState.stage_entrance;
	transform_set(_player.transform[TransformType.anchor],TransformValue.x,_player.x,false);
	transform_set(_player.transform[TransformType.anchor],TransformValue.y,_player.y,false);
}
else if(phase == OpeningCutscenePhase.exit) {
	_player.x = exit_player_x;
	_player.y = player_ground_y;
	_player.velocity.Set(0,0);
	_player.acceleration.Set(0,0);
	_player.move_grounded = true;
	_player.state = PlayerState.stage_entrance;
	transform_set(_player.transform[TransformType.anchor],TransformValue.x,_player.x,false);
	transform_set(_player.transform[TransformType.anchor],TransformValue.y,_player.y,false);
}

// The opening is a focused tutorial beat; suppress the normal five-second
// secret idle so it cannot cover the prompt or replace Winbo's control pose.
with(_player) {
	if(secret_idle_phase != PLAYER_SECRET_IDLE_PHASE_INACTIVE || secret_idle_thought_fx != noone) {
		player_secret_idle_cancel(false);
	}
	secret_idle_inputless_time = 0;
}
