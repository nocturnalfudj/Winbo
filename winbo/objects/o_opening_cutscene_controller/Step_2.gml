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
	transform_set(_player.transform[TransformType.anchor],TransformValue.x,_player.x,false);
	transform_set(_player.transform[TransformType.anchor],TransformValue.y,_player.y,false);
}
else if(phase == OpeningCutscenePhase.defeat) {
	_player.x = stomp_player_target_x;
	_player.velocity.x = 0;
	_player.acceleration.x = 0;
	transform_set(_player.transform[TransformType.anchor],TransformValue.x,_player.x,false);
}
else if(phase == OpeningCutscenePhase.exit) {
	_player.x = exit_player_x;
	_player.y = player_ground_y;
	_player.velocity.Set(0,0);
	_player.acceleration.Set(0,0);
	_player.move_grounded = true;
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
