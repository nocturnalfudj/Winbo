/// Clear eligibility at creation, damage, water entry and other non-jump launches.
function player_second_jump_reset(){
	second_jump_active = false;
	second_jump_landing_age = -1;
	second_jump_landing_armed = false;
	second_jump_airborne_seen = false;
}

function player_second_jump_validate(){
	if(swim_active || air_spin_active || (state != PlayerState.move && state != PlayerState.float)){
		player_second_jump_reset();
	}
}

/// The sideways flourish commits Winbo until its extreme pose.
function player_flourish_cancel_locked(){
	return (sprite_current == sprite_jump_second_sideways) && (image.frame < second_jump_cancel_frame);
}

/// Cancelling the sideways flourish plays Andy's in-between poses in place of
/// the next move's opening frames, so the move keeps its length and snap.
/// Call after the next move's image_system_setup.
function player_flourish_cancel_transition(_transition){
	image.target_start_frame = sprite_get_number(_transition);
	image_system_queue_add_to_front(_transition, ANIMATION_FPS_DEFAULT);
}

/// Shared by normal play and dialogue so every genuine landing consumes the flight.
function player_second_jump_landed(){
	second_jump_landing_age = second_jump_landing_armed && second_jump_airborne_seen ? 0 : -1;
	var _land = second_jump_active
		? (jump_face_sideways ? sprite_land_second_sideways : sprite_land_second)
		: (abs(velocity.x) > 5 ? sprite_land_sideways : sprite_land);
	second_jump_active = false;
	second_jump_landing_armed = false;
	second_jump_airborne_seen = false;
	return _land;
}

#macro PLAYER_POST_DASH_PHASE_INACTIVE 0
#macro PLAYER_POST_DASH_PHASE_LOOP 1
#macro PLAYER_POST_DASH_PHASE_TRANSITION 2
// Ordinary sideways fall art after the post-dash in-betweens.
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
	if((sprite_current == sprite_land_second)
	|| (sprite_current == sprite_land_second_sideways)
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
	|| (move_grounded && velocity.y >= 0 && !jump_startup_active)){
		player_landing_context_clear();
	}
}

/// Air dash exit: presentation only, the fall physics are untouched.
function player_post_dash_begin(){
	jump_frolic_active = false;
	post_dash_phase = PLAYER_POST_DASH_PHASE_LOOP;
	post_dash_fall_time = 0;
}

function player_post_dash_clear(){
	post_dash_phase = PLAYER_POST_DASH_PHASE_INACTIVE;
	post_dash_fall_time = 0;
}

/// Gameplay-time fall clock; frozen whenever the move state is not running.
/// Only descent counts, so a rising dash exit does not eat the loop.
function player_post_dash_update(){
	if(post_dash_phase != PLAYER_POST_DASH_PHASE_LOOP) return;
	if((velocity.y < 0) || (acceleration.y < 0)) return;
	post_dash_fall_time += global.delta_time_factor_scaled;
}

/// Owns the airborne sprite for the whole post-dash flight, including any residual rise.
/// Only the sideways artwork plays. The dash locked Winbo's facing, so it keeps
/// facing the dash direction after the stick is released.
function player_post_dash_sprite_update(){
	if(post_dash_phase == PLAYER_POST_DASH_PHASE_FALL){
		if(sprite_current != sprite_fall_sideways){
			image_system_setup(sprite_fall_sideways, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
		}
		return;
	}

	if(sprite_current != sprite_fall_post_dash_sideways){
		var _transition = post_dash_phase == PLAYER_POST_DASH_PHASE_TRANSITION;
		image_system_setup(sprite_fall_post_dash_sideways, ANIMATION_FPS_DEFAULT, true, !_transition, 0, _transition ? IMAGE_LOOP_FULL : post_dash_loop_frames);
		image_set_frame(image, _transition ? post_dash_loop_frames : 0);
	}

	if(post_dash_phase == PLAYER_POST_DASH_PHASE_LOOP){
		if(post_dash_fall_time >= post_dash_fall_time_max){
			// Let the current loop run on into the in-between frames without a cut.
			post_dash_phase = PLAYER_POST_DASH_PHASE_TRANSITION;
			image.loop = false;
		}
		return;
	}

	// Hand over to the sideways fall the transition ends in.
	if(!image.animate){
		post_dash_phase = PLAYER_POST_DASH_PHASE_FALL;
		image_system_setup(sprite_fall_sideways, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
	}
}
