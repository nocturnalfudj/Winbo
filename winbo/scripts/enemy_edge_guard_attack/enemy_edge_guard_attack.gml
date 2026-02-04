/// @function enemy_edge_guard_attack
/// @summary Prevent enemies from stepping off ledges during attack states by cancelling horizontal movement if no ground ahead.
/// @returns {void}
function enemy_edge_guard_attack(){
	// Feature toggle
	if(!edge_guard_attack_enable) exit;
	
	// Only meaningful while grounded
	if(!move_grounded) exit;
	
	// Determine intended horizontal direction (prefer actual movement intent, fall back to facing)
	var _intent_x = velocity.x + acceleration.x;
	var _dir_sign;
	if(abs(_intent_x) > 0.001){
		_dir_sign = sign(_intent_x);
	}
	else{
		_dir_sign = (face_horizontal != 0) ? sign(face_horizontal) : 1;
	}
	
	// Delta time factor
	var _delta_time;
	if(time_scale_enable)
		_delta_time = global.delta_time_factor_scaled;
	else
		_delta_time = global.delta_time_factor;
	
	// Predict displacement magnitude for lookahead distance
	var _accel_mult = 0.5 * _delta_time;
	var _disp_mag = abs((velocity.x + acceleration.x * _accel_mult) * _delta_time);
	
	var _extra = edge_guard_attack_lookahead_extra_px;
	_extra ??= 4;
	
	var _lookahead = max(_disp_mag, sprite_width/2 + _extra);
	var _next_x = x + _lookahead * _dir_sign;
	
	// Ground check a little below feet
	var _ground_ok = place_meeting(_next_x, y + 2, move_collision_object);
	
	// If we'd step off, cancel horizontal motion for this step (do NOT flip facing)
	if(!_ground_ok){
		velocity.x = 0;
		acceleration.x = 0;
		input_move_magnitude = 0;
	}
}
