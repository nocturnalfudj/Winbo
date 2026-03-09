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

function enemy_apocalypse_survivor_debug_log_aim_resolution(_target_x, _target_y, _face, _candidates, _best){
	if(!(variable_instance_exists(id, "debug_attack_logs_enable") && debug_attack_logs_enable)){
		return;
	}

	if(!(variable_instance_exists(id, "survivor_posture") && survivor_posture == SurvivorPosture.standing)){
		return;
	}

	if(!variable_instance_exists(id, "debug_aim_log_cooldown")){
		debug_aim_log_cooldown = 0;
	}

	if(!variable_instance_exists(id, "debug_aim_log_last_signature")){
		debug_aim_log_last_signature = "";
	}

	var _delta_time = time_scale_enable ? global.delta_time_factor_scaled : global.delta_time_factor;
	if(debug_aim_log_cooldown > 0){
		debug_aim_log_cooldown -= _delta_time;
	}

	var _expected_side_sector = (_face == 1) ? "side" : "side_flip";
	var _close_x = abs(_target_x - x) <= (standing_close_fire_origin_distance + 250);
	var _suspicious = _close_x
		|| _best.close_range_fallback
		|| (_best.aim_angle > 0)
		|| (_best.sector != _expected_side_sector);

	if(!_suspicious){
		return;
	}

	var _signature = _best.sector
		+ "|" + string(round(_best.aim_angle))
		+ "|" + string(round(_target_x - x))
		+ "|" + string(round(_target_y - y))
		+ "|" + string(_best.close_range_fallback ? 1 : 0);

	if(debug_aim_log_cooldown > 0 && debug_aim_log_last_signature == _signature){
		return;
	}

	debug_aim_log_last_signature = _signature;
	debug_aim_log_cooldown = SECOND * 0.25;

	var _candidate_text = "";
	for(var _i = 0; _i < array_length(_candidates); _i++){
		var _candidate = _candidates[_i];
		if(_i > 0){
			_candidate_text += " ";
		}

		_candidate_text += _candidate.sector
			+ "(a=" + string(round(_candidate.aim_angle))
			+ " e=" + string(round(_candidate.error))
			+ " fb=" + string(_candidate.close_range_fallback ? 1 : 0)
			+ " bh=" + string(_candidate.target_behind_muzzle ? 1 : 0)
			+ " my=" + string(round(_candidate.muzzle_y - y))
			+ " fy=" + string(round(_candidate.fire_y - y))
			+ ")";
	}

	__mcp_log(
		"[ASDBG][AIM]"
		+ " t=(" + string(round(_target_x - x)) + "," + string(round(_target_y - y)) + ")"
		+ " root_dir=" + string(round(point_direction(x, y, _target_x, _target_y)))
		+ " best=" + _best.sector
		+ " aim=" + string(round(_best.aim_angle))
		+ " err=" + string(round(_best.error))
		+ " fb=" + string(_best.close_range_fallback ? 1 : 0)
		+ " bh=" + string(_best.target_behind_muzzle ? 1 : 0)
		+ " dy_m=" + string(round(_target_y - _best.muzzle_y))
		+ " dy_f=" + string(round(_target_y - _best.fire_y))
		+ " cand=" + _candidate_text
	);
}

function enemy_apocalypse_survivor_clamp_angle_to_sector(_angle, _sector, _target_y = undefined){
	var _target_above = !is_undefined(_target_y) && (_target_y < y);

	switch(_sector){
		case "side":
			if(!is_undefined(_target_y)){
				var _signed = angle_difference(_angle, 0);
				if(_target_above){
					return clamp(_signed, 0, 45);
				}
				return clamp(_signed, -45, 0);
			}
			return angle_clamp_around(_angle, 0, 45);

		case "diag":
			return angle_clamp_around(_angle, 65, 20);

		case "up":
			return angle_clamp_around(_angle, 90, 5);

		case "diag_flip":
			return angle_clamp_around(_angle, 115, 20);

		case "side_flip":
			if(!is_undefined(_target_y)){
				var _flip_diff = angle_difference(_angle, 180);
				if(_target_above){
					return 180 + clamp(_flip_diff, -45, 0);
				}
				return 180 + clamp(_flip_diff, 0, 45);
			}
			return angle_clamp_around(_angle, 180, 45);
	}

	return _angle;
}

function enemy_apocalypse_survivor_get_sector_angle_range(_sector, _target_y){
	var _target_above = (_target_y < y);

	switch(_sector){
		case "side":
			return _target_above ? [0, 45] : [-45, 0];

		case "diag":
			return [45, 85];

		case "up":
			return [85, 95];

		case "diag_flip":
			return [95, 135];

		case "side_flip":
			return _target_above ? [135, 180] : [180, 225];
	}

	return [_target_above ? 0 : -45, _target_above ? 45 : 0];
}

function enemy_apocalypse_survivor_apply_close_fire_origin(_aim_data, _target_x, _target_y){
	_aim_data.fire_x = _aim_data.muzzle_x;
	_aim_data.fire_y = _aim_data.muzzle_y;
	_aim_data.close_range_fallback = false;
	_aim_data.target_behind_muzzle = false;

	if(!(variable_instance_exists(id, "survivor_posture") && survivor_posture == SurvivorPosture.standing)){
		return _aim_data;
	}

	var _target_behind_muzzle = ((_aim_data.face_horizontal == 1) && (_target_x < _aim_data.muzzle_x))
		|| ((_aim_data.face_horizontal == -1) && (_target_x > _aim_data.muzzle_x));
	_aim_data.target_behind_muzzle = _target_behind_muzzle;

	if(!_target_behind_muzzle){
		_aim_data.error = abs(angle_difference(
			point_direction(_aim_data.fire_x, _aim_data.fire_y, _target_x, _target_y),
			_aim_data.aim_angle
		));
		return _aim_data;
	}

	var _target_dist = point_distance(x, y, _target_x, _target_y);
	var _fire_dist = min(standing_close_fire_origin_distance, max(0, _target_dist - standing_close_target_margin));
	_aim_data.fire_x = x + lengthdir_x(_fire_dist, _aim_data.aim_angle);
	_aim_data.fire_y = y + lengthdir_y(_fire_dist, _aim_data.aim_angle);
	_aim_data.close_range_fallback = true;
	_aim_data.error = abs(angle_difference(
		point_direction(_aim_data.fire_x, _aim_data.fire_y, _target_x, _target_y),
		_aim_data.aim_angle
	));

	return _aim_data;
}

function enemy_apocalypse_survivor_is_better_candidate(_candidate, _best, _target_x, _target_y){
	if(is_undefined(_best)){
		return true;
	}

	if(_candidate.error < (_best.error - 0.001)){
		return true;
	}

	if(_candidate.error > (_best.error + 0.001)){
		return false;
	}

	var _current_angle = variable_instance_exists(id, "aim_angle")
		? aim_angle
		: point_direction(x, y, _target_x, _target_y);
	var _candidate_turn = abs(angle_difference(_candidate.aim_angle, _current_angle));
	var _best_turn = abs(angle_difference(_best.aim_angle, _current_angle));

	if(_candidate_turn < (_best_turn - 0.001)){
		return true;
	}

	if(_candidate_turn > (_best_turn + 0.001)){
		return false;
	}

	var _root_dir = point_direction(x, y, _target_x, _target_y);
	var _candidate_root_diff = abs(angle_difference(_candidate.aim_angle, _root_dir));
	var _best_root_diff = abs(angle_difference(_best.aim_angle, _root_dir));
	return _candidate_root_diff < _best_root_diff;
}

function enemy_apocalypse_survivor_search_sector_angles(_target_x, _target_y, _face, _sector, _angle_min, _angle_max, _step, _best){
	for(var _angle = _angle_min; _angle <= (_angle_max + (_step * 0.5)); _angle += _step){
		var _sample_angle = clamp(_angle, _angle_min, _angle_max);
		var _candidate = enemy_apocalypse_survivor_apply_close_fire_origin(
			apocalypse_survivor_get_aim_data(_sample_angle, _face, _sector),
			_target_x,
			_target_y
		);

		if(enemy_apocalypse_survivor_is_better_candidate(_candidate, _best, _target_x, _target_y)){
			_best = _candidate;
		}
	}

	return _best;
}

function enemy_apocalypse_survivor_solve_sector_aim(_target_x, _target_y, _face, _sector){
	var _range = enemy_apocalypse_survivor_get_sector_angle_range(_sector, _target_y);
	var _best = enemy_apocalypse_survivor_search_sector_angles(
		_target_x,
		_target_y,
		_face,
		_sector,
		_range[0],
		_range[1],
		1,
		undefined
	);
	var _refine_min = max(_range[0], _best.aim_angle - 1);
	var _refine_max = min(_range[1], _best.aim_angle + 1);
	_best = enemy_apocalypse_survivor_search_sector_angles(
		_target_x,
		_target_y,
		_face,
		_sector,
		_refine_min,
		_refine_max,
		0.25,
		_best
	);
	_refine_min = max(_range[0], _best.aim_angle - 0.25);
	_refine_max = min(_range[1], _best.aim_angle + 0.25);
	_best = enemy_apocalypse_survivor_search_sector_angles(
		_target_x,
		_target_y,
		_face,
		_sector,
		_refine_min,
		_refine_max,
		0.05,
		_best
	);

	return _best;
}

function enemy_apocalypse_survivor_resolve_sector_candidate(_target_x, _target_y, _face, _sector){
	return enemy_apocalypse_survivor_solve_sector_aim(_target_x, _target_y, _face, _sector);
}

function enemy_apocalypse_survivor_resolve_aim_data(_target_x, _target_y){
	var _face = (_target_x >= x) ? 1 : -1;
	var _resolved_angle = point_direction(x, y, _target_x, _target_y);

	if(variable_instance_exists(id, "survivor_posture") && survivor_posture == SurvivorPosture.standing){
		var _best = undefined;
		var _target_above = (_target_y < y);
		var _candidates = [];
		var _sectors = (_face == 1)
			? (_target_above ? ["side", "diag", "up"] : ["side"])
			: (_target_above ? ["side_flip", "diag_flip", "up"] : ["side_flip"]);

		for(var _i = 0; _i < array_length(_sectors); _i++){
			var _candidate = enemy_apocalypse_survivor_resolve_sector_candidate(_target_x, _target_y, _face, _sectors[_i]);
			_candidates[array_length(_candidates)] = _candidate;

			if(is_undefined(_best) || (_candidate.error < _best.error)){
				_best = _candidate;
			}
		}

		enemy_apocalypse_survivor_debug_log_aim_resolution(_target_x, _target_y, _face, _candidates, _best);
		return _best;
	}

	return enemy_apocalypse_survivor_apply_close_fire_origin(
		apocalypse_survivor_get_aim_data(_resolved_angle, _face),
		_target_x,
		_target_y
	);
}

function enemy_apocalypse_survivor_set_target_aim(_target_x, _target_y){
	var _aim_data = enemy_apocalypse_survivor_resolve_aim_data(_target_x, _target_y);
	face_horizontal = _aim_data.face_horizontal;
	aim_angle = _aim_data.aim_angle;
	survivor_resolved_aim_data = _aim_data;
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
