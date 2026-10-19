/// Clear eligibility at creation, damage, water entry and other non-jump launches.
function player_second_jump_reset(){
	second_jump_active = false;
	second_jump_hold_pending = false;
	second_jump_hold_time = 0;
	second_jump_landing_age = -1;
	second_jump_landing_armed = false;
	second_jump_airborne_seen = false;
}

function player_second_jump_validate(){
	if(swim_active || air_spin_active || (state != PlayerState.move && state != PlayerState.float)){
		player_second_jump_reset();
	}
}

function player_second_jump_hold_update(){
	if(!second_jump_hold_pending) return;
	if(!input_current[UserControl.jump] || velocity.y >= 0 || state != PlayerState.move){
		second_jump_hold_pending = false;
		return;
	}
	second_jump_hold_time += global.delta_time_factor_scaled;
	if(second_jump_hold_time < second_jump_hold_frames) return;

	second_jump_hold_pending = false;
	second_jump_active = true;
	jump_hold_allow_countdown = 0;
	velocity.y -= second_jump_hold_boost;
	// Keep the shared takeoff frames already played instead of restarting the wind-up.
	var _frame = image.frame;
	image_system_setup(sprite_jump_second, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
	image_set_frame(image, min(_frame, sprite_get_number(sprite_jump_second) - 1));
}

/// Shared by normal play and dialogue so every genuine landing consumes the flight.
function player_second_jump_landed(){
	second_jump_landing_age = second_jump_landing_armed && second_jump_airborne_seen ? 0 : -1;
	var _land = second_jump_active
		? (jump_face_sideways ? sprite_land_second_sideways : sprite_land)
		: (abs(velocity.x) > 5 ? sprite_land_sideways : sprite_land);
	second_jump_active = false;
	second_jump_hold_pending = false;
	second_jump_hold_time = 0;
	second_jump_landing_armed = false;
	second_jump_airborne_seen = false;
	return _land;
}
