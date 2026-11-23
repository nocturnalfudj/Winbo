function player_movement_update(){
	var _delta_time_scaled;
	_delta_time_scaled = global.delta_time_factor_scaled;
	
	movement_system_update();
	player_room_border_resolve();
	
	//Stationary
	if(velocity_mag > 0.05){
		stationary = false;
		stationary_time = 0;
	}
	else{
		stationary = true;
		stationary_time += _delta_time_scaled;
	}
		
	if(second_jump_landing_armed && !move_grounded) second_jump_airborne_seen = true;

	#region Landing
		var _was_jump_grounded = jump_grounded;
		jump_grounded = player_jump_grounded();
		if(!swim_active && (state == PlayerState.move || state == PlayerState.float)
		&& jump_grounded && !_was_jump_grounded){
			player_land_begin();
			velocity.x = 0;
			acceleration.x = 0;
		}
	#endregion
}

#macro PLAYER_ROOM_BORDER_MARGIN 256

/// The room's left, right and top edges block Winbo in normal play; the bottom
/// stays open so pits still kill. The edge reads as a wall contact with no
/// instance, which a dash treats as a room border (see player_bump_contact_is_border).
function player_room_border_resolve(){
	if((state != PlayerState.move) && (state != PlayerState.dash)
	&& (state != PlayerState.float) && (state != PlayerState.dive_spring)){
		return;
	}

	var _push_x = 0;
	if(bbox_left < 0){
		_push_x = -bbox_left;
	}
	else if(bbox_right > room_width - 1){
		_push_x = room_width - 1 - bbox_right;
	}
	if(_push_x != 0){
		x += _push_x;
		transform_set(transform[TransformType.anchor], TransformValue.x, x, false);
		collision.x = -sign(_push_x);
		move_collision_object_instance_x = noone;
		if(sign(velocity.x) == collision.x){
			velocity.x = 0;
		}
	}

	var _push_y = 0;
	if(bbox_top < 0){
		_push_y = -bbox_top;
		y += _push_y;
		transform_set(transform[TransformType.anchor], TransformValue.y, y, false);
		collision.y = -1;
		move_collision_object_instance_y = noone;
		if(velocity.y < 0){
			velocity.y = 0;
		}
	}

	// Pressing into the edge leaves Winbo stationary, as against any wall.
	if((_push_x != 0) || (_push_y != 0)){
		velocity_mag = velocity.Magnitude();
		velocity_dir = velocity.Direction();
	}
}

/// Whether a dash contact is the edge of the playable room rather than a wall
/// to bump off. Covers the runtime room edge (no instance) and the invisible
/// walls placed along room edges, whose contacted face lies within
/// PLAYER_ROOM_BORDER_MARGIN of that edge. Floors are never borders.
/// @param _solid The contacted solid, or noone for the runtime room edge.
/// @param _side_x Horizontal contact side (-1 left, 1 right), or 0.
/// @param _side_y Vertical contact side (-1 ceiling), or 0.
function player_bump_contact_is_border(_solid, _side_x, _side_y){
	if(_solid == noone){
		return true;
	}
	if(_side_x == -1){
		return _solid.bbox_right <= PLAYER_ROOM_BORDER_MARGIN;
	}
	if(_side_x == 1){
		return _solid.bbox_left >= room_width - PLAYER_ROOM_BORDER_MARGIN;
	}
	if(_side_y == -1){
		return _solid.bbox_bottom <= PLAYER_ROOM_BORDER_MARGIN;
	}
	return false;
}

/// A dash into a room border never bumps: the dash ends at once and Winbo
/// falls without a bump jump or a stamina refill, so borders cannot be climbed.
function player_dash_border_stop(){
	bump_allow = false;
	if(state != PlayerState.dash){
		return;
	}
	dash_countdown = 0;
	dash_hold_check_countdown = 0;
	dash_hold_allow_countdown = 0;
	velocity.x = 0;
	acceleration.x = 0;
}
