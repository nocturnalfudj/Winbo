function enemy_apocalypse_survivor_state_attack_recover() {
	enemy_apocalypse_survivor_posture_sync();
	character_health();

	var _delta_time = time_scale_enable ? global.delta_time_factor_scaled : global.delta_time_factor;
	var _target_valid = target_update(TargetType.attack);
	if(_target_valid && target[TargetType.attack] != noone && target[TargetType.attack].has_valid_target()){
		var _target_x = target[TargetType.attack].x;
		var _target_y = target[TargetType.attack].y;
		var _target_aim_x = _target_x;
		var _target_aim_y = _target_y;

		enemy_apocalypse_survivor_set_target_aim(_target_aim_x, _target_aim_y);
	}

	enemy_apocalypse_survivor_refresh_attack_sprites();
	if(sprite_attack_recover != noone && sprite_current != sprite_attack_recover){
		image_system_setup(sprite_attack_recover, ANIMATION_FPS_DEFAULT * animation_fps_multiplier, true, true, 0, IMAGE_LOOP_FULL);
	}

	if(attack_recover_countdown > 0){
		attack_recover_countdown -= _delta_time;
	}

	if(attack_recover_countdown <= 0){
		attack_face_lock_active = false;
		state = EnemyState.move;
	}

	#region Out of Room
		if((x < 0) || (x > room_width) || (y < 0) || (y > room_height)){
			character_kill();
		}
	#endregion
}
