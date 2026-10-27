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
	second_jump_landing_armed = false;
	// The higher tier owns the flight and its landing.
	jump_frolic_active = false;
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

#macro PLAYER_POST_DASH_PHASE_INACTIVE 0
#macro PLAYER_POST_DASH_PHASE_LOOP 1
#macro PLAYER_POST_DASH_PHASE_TRANSITION 2
// Ordinary fall art, still chosen by motion so the handoff cannot pop orientation.
#macro PLAYER_POST_DASH_PHASE_FALL 3

/// Start a genuine landing in normal play or dialogue. Airborne context picks
/// the squash: post-dash, then the jump tier, then a jump taken from Frolic.
function player_land_begin(){
	var _land = player_second_jump_landed();
	if((post_dash_phase == PLAYER_POST_DASH_PHASE_LOOP) || (post_dash_phase == PLAYER_POST_DASH_PHASE_TRANSITION)){
		_land = sprite_land_post_dash;
	}
	else if(jump_frolic_active){
		_land = sprite_land_frolic;
	}
	player_landing_context_clear();
	image_system_setup(_land, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
	image_set_frame(image, 0);
}

/// True while any landing squash still owns the sprite.
function player_landing_playing(){
	if((sprite_current == sprite_land_second_sideways)
	|| (sprite_current == sprite_land_frolic)
	|| (sprite_current == sprite_land_post_dash)){
		// These non-looping sequences own every frame, but only while supported.
		return move_grounded && image.animate;
	}
	return ((sprite_current == sprite_land)
		|| (sprite_current == sprite_land_sideways))
		&& (sprite_current_frame < (image.sprite_number - 1));
}

function player_landing_context_clear(){
	jump_frolic_active = false;
	player_post_dash_clear();
}

/// Airborne presentation only survives an uninterrupted move-state flight.
function player_landing_context_validate(){
	if(swim_active || air_spin_active || (state != PlayerState.move)
	|| (move_grounded && velocity.y >= 0)){
		player_landing_context_clear();
	}
}

/// Air dash exit: presentation only, the fall physics are untouched.
function player_post_dash_begin(){
	jump_frolic_active = false;
	post_dash_phase = PLAYER_POST_DASH_PHASE_LOOP;
	post_dash_fall_time = 0;
	post_dash_sideways = abs(velocity.x) > post_dash_sideways_enter_speed;
}

function player_post_dash_clear(){
	post_dash_phase = PLAYER_POST_DASH_PHASE_INACTIVE;
	post_dash_fall_time = 0;
	post_dash_sideways = false;
}

/// Gameplay-time fall clock; frozen whenever the move state is not running.
/// Only descent counts, so a rising dash exit does not eat the loop.
function player_post_dash_update(){
	if(post_dash_phase != PLAYER_POST_DASH_PHASE_LOOP) return;
	if((velocity.y < 0) || (acceleration.y < 0)) return;
	post_dash_fall_time += global.delta_time_factor_scaled;
}

function player_post_dash_is_sprite(_sprite){
	return (_sprite == sprite_fall_post_dash) || (_sprite == sprite_fall_post_dash_sideways);
}

/// Owns the airborne sprite for the whole post-dash flight, including any residual rise.
function player_post_dash_sprite_update(){
	// Horizontal motion picks the variant, with hysteresis so drift cannot flicker it.
	var _speed_x = abs(velocity.x);
	if(post_dash_sideways){
		if(_speed_x < post_dash_sideways_exit_speed) post_dash_sideways = false;
	}
	else if(_speed_x > post_dash_sideways_enter_speed){
		post_dash_sideways = true;
	}

	if(post_dash_phase == PLAYER_POST_DASH_PHASE_FALL){
		var _fall = post_dash_sideways ? sprite_fall_sideways : sprite_fall;
		if(sprite_current != _fall){
			if((sprite_current == sprite_fall) || (sprite_current == sprite_fall_sideways)){
				image_set_sprite(image, _fall, false);
			}
			else{
				image_system_setup(_fall, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
			}
		}
		return;
	}

	var _target = post_dash_sideways ? sprite_fall_post_dash_sideways : sprite_fall_post_dash;
	var _loop_frames = post_dash_loop_frames;

	if(sprite_current != _target){
		if(player_post_dash_is_sprite(sprite_current)){
			// Swap variants in place; the fall clock is not touched.
			var _position = image.position;
			if(post_dash_phase == PLAYER_POST_DASH_PHASE_TRANSITION){
				var _from_length = max(1, image.sprite_number - _loop_frames);
				var _to_length = max(1, sprite_get_number(_target) - _loop_frames);
				_position = _loop_frames + max(0, _position - _loop_frames) * _to_length / _from_length;
				_position = min(_position, sprite_get_number(_target) - 1);
			}
			image_set_sprite(image, _target, false);
			image.position = _position;
			image.frame = floor(_position);
			sprite_current_frame = image.frame;
		}
		else{
			var _transition = post_dash_phase == PLAYER_POST_DASH_PHASE_TRANSITION;
			image_system_setup(_target, ANIMATION_FPS_DEFAULT, true, !_transition, 0, _transition ? IMAGE_LOOP_FULL : _loop_frames);
			image_set_frame(image, _transition ? _loop_frames : 0);
		}
	}

	if(post_dash_phase == PLAYER_POST_DASH_PHASE_LOOP){
		if(post_dash_fall_time >= post_dash_fall_time_max){
			// Let the current loop run on into the in-between frames without a cut.
			post_dash_phase = PLAYER_POST_DASH_PHASE_TRANSITION;
			image.loop = false;
		}
		return;
	}

	// Hand over to the ordinary fall in the same orientation the transition ended in.
	if(!image.animate){
		post_dash_phase = PLAYER_POST_DASH_PHASE_FALL;
		image_system_setup(post_dash_sideways ? sprite_fall_sideways : sprite_fall, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
	}
}
