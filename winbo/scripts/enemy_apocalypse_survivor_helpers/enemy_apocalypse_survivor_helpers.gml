function enemy_apocalypse_survivor_helpers() {
}

function enemy_apocalypse_survivor_crouch_allowed(){
	if(!variable_instance_exists(id, "survivor_allow_crouch")){
		survivor_allow_crouch = true;
	}

	return survivor_allow_crouch;
}

function enemy_apocalypse_survivor_posture_sync(){
	if(!variable_instance_exists(id, "survivor_posture")){
		return;
	}

	if(!enemy_apocalypse_survivor_crouch_allowed()){
		survivor_desired_posture = SurvivorPosture.standing;

		if(variable_instance_exists(id, "survivor_transition")){
			if((survivor_transition == SurvivorTransition.stand_to_crouch)
			|| (survivor_transition == SurvivorTransition.crouch_to_stand)){
				survivor_transition = SurvivorTransition.none;
			}
		}

		survivor_posture = SurvivorPosture.standing;
	}

	is_kneeling = (survivor_posture == SurvivorPosture.crouched);
}

function enemy_apocalypse_survivor_set_posture(_posture){
	survivor_posture = _posture;
	enemy_apocalypse_survivor_posture_sync();
}

function enemy_apocalypse_survivor_get_transition_sprite(_transition){
	switch(_transition){
		case SurvivorTransition.stand_to_crouch:
			return sprite_transition_stand_to_crouch;

		case SurvivorTransition.crouch_to_stand:
			return sprite_transition_crouch_to_stand;

		case SurvivorTransition.deaggro:
			return sprite_deaggro;
	}

	return noone;
}

function enemy_apocalypse_survivor_start_transition(_transition){
	if(_transition == SurvivorTransition.none){
		survivor_transition = SurvivorTransition.none;
		return;
	}

	if(!enemy_apocalypse_survivor_crouch_allowed()){
		if((_transition == SurvivorTransition.stand_to_crouch)
		|| (_transition == SurvivorTransition.crouch_to_stand)){
			survivor_desired_posture = SurvivorPosture.standing;
			enemy_apocalypse_survivor_set_posture(SurvivorPosture.standing);
			survivor_transition = SurvivorTransition.none;
			return;
		}
	}

	survivor_transition = _transition;

	var _transition_sprite = enemy_apocalypse_survivor_get_transition_sprite(_transition);
	if(_transition_sprite != noone && sprite_current != _transition_sprite){
		image_system_setup(_transition_sprite, ANIMATION_FPS_DEFAULT * animation_fps_multiplier, true, false, 0, IMAGE_LOOP_FULL);
	}
}

function enemy_apocalypse_survivor_finish_transition(){
	switch(survivor_transition){
		case SurvivorTransition.startle_to_standing:
		case SurvivorTransition.crouch_to_stand:
		case SurvivorTransition.deaggro:
			enemy_apocalypse_survivor_set_posture(SurvivorPosture.standing);
		break;

		case SurvivorTransition.stand_to_crouch:
			enemy_apocalypse_survivor_set_posture(SurvivorPosture.crouched);
		break;
	}

	survivor_transition = SurvivorTransition.none;
}

function enemy_apocalypse_survivor_get_layered_sprites(_sector, _is_shooting){
	var _standing = (survivor_posture == SurvivorPosture.standing);
	var _legs = noone;
	var _mid = noone;
	var _body = noone;

	if(_standing){
		switch(_sector){
			case "diag":
			case "diag_flip":
				_legs = _is_shooting ? sprite_shoot_standing_diag_legs : sprite_aim_standing_diag_legs;
				_body = _is_shooting ? sprite_shoot_standing_diag_body : sprite_aim_standing_diag_body;
			break;

			case "up":
				_legs = _is_shooting ? sprite_shoot_standing_up_legs : sprite_aim_standing_up_legs;
				_body = _is_shooting ? sprite_shoot_standing_up_body : sprite_aim_standing_up_body;
			break;

			case "side":
			case "side_flip":
			case "out":
			default:
				_legs = _is_shooting ? sprite_shoot_standing_side_legs : sprite_aim_standing_side_legs;
				_body = _is_shooting ? sprite_shoot_standing_side_body : sprite_aim_standing_side_body;
			break;
		}
	}
	else{
		switch(_sector){
			case "diag":
			case "diag_flip":
				_legs = _is_shooting ? sprite_shoot_diag_legs : sprite_aim_diag_legs;
				_body = _is_shooting ? sprite_shoot_diag_body : sprite_aim_diag_body;
			break;

			case "up":
				_legs = _is_shooting ? sprite_shoot_up_legs : sprite_aim_up_legs;
				_mid = _is_shooting ? sprite_shoot_up_mid : sprite_aim_up_mid;
				_body = _is_shooting ? sprite_shoot_up_body : sprite_aim_up_body;
			break;

			case "side":
			case "side_flip":
			case "out":
			default:
				_legs = _is_shooting ? sprite_shoot_side_legs : sprite_aim_side_legs;
				_body = _is_shooting ? sprite_shoot_side_body : sprite_aim_side_body;
			break;
		}
	}

	return {
		legs: _legs,
		mid: _mid,
		body: _body,
		use_three_layers: (!_standing) && (_sector == "up")
	};
}

function enemy_apocalypse_survivor_get_animation_driver(_sector, _is_shooting){
	var _layers = enemy_apocalypse_survivor_get_layered_sprites(_sector, _is_shooting);
	var _driver = _layers.body;
	var _driver_frames = (_driver != noone) ? sprite_get_number(_driver) : -1;

	var _candidates = [_layers.mid, _layers.legs];
	for(var _i = 0; _i < array_length(_candidates); _i++){
		var _candidate = _candidates[_i];
		if(_candidate == noone){
			continue;
		}

		var _candidate_frames = sprite_get_number(_candidate);
		if(_candidate_frames > _driver_frames){
			_driver = _candidate;
			_driver_frames = _candidate_frames;
		}
	}

	return _driver;
}

function enemy_apocalypse_survivor_refresh_attack_sprites(){
	var _aim_data = apocalypse_survivor_get_aim_data();
	sprite_attack_telegraph = enemy_apocalypse_survivor_get_animation_driver(_aim_data.sector, false);
	sprite_attack_active = enemy_apocalypse_survivor_get_animation_driver(_aim_data.sector, true);
	sprite_attack_recover = enemy_apocalypse_survivor_get_animation_driver(_aim_data.sector, false);
}
