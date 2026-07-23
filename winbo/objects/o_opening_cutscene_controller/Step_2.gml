camera_set_view_pos(view_camera[0],camera_fixed_x,camera_fixed_y);
o_camera.lighting_enable = false;

if(instance_number(o_player) == 0) exit;

var _player = instance_find(o_player,0);
_player.visible = false;

if(phase == OpeningCutscenePhase.intro) {
	// Keep gameplay logic from treating the scripted off-screen entry as an
	// out-of-room death before control is handed to the player.
	_player.state = PlayerState.stage_entrance;
	_player.hp_vulnerable = false;
	_player.user.hp_vulnerable = false;
	var _entry_progress = clamp((soldier_frame - 40) / (player_entry_end_frame - 40),0,1);
	var _entry_eased = 1 - sqr(1 - _entry_progress);
	_player.x = camera_fixed_x + lerp(player_intro_x,player_handoff_x,_entry_eased);
	_player.y = player_ground_y;
	var _player_transform = _player.transform[TransformType.anchor];
	transform_set(_player_transform,TransformValue.x,_player.x,false);
	transform_set(_player_transform,TransformValue.y,_player.y,false);
	_player.velocity.Set(0,0);
	_player.acceleration.Set(0,0);
}
else if(phase == OpeningCutscenePhase.interactive) {
	var _clamped_x = clamp(_player.x,camera_fixed_x - 100,camera_fixed_x + player_gate_x);
	if(_clamped_x != _player.x) {
		_player.x = _clamped_x;
		transform_set(_player.transform[TransformType.anchor],TransformValue.x,_clamped_x,false);
	}
}

// The opening is a focused tutorial beat; suppress the normal five-second
// secret idle so it cannot cover the prompt or replace Winbo's control pose.
with(_player) {
	if(secret_idle_phase != PLAYER_SECRET_IDLE_PHASE_INACTIVE || secret_idle_thought_fx != noone) {
		player_secret_idle_cancel(false);
	}
	secret_idle_inputless_time = 0;
}
