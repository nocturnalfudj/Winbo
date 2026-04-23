/// @function bonus_room_transition
/// @summary Handle direct room transition for bonus rooms (bypasses presence room)
/// @param {asset.GMRoom} _target_room The room to transition to
/// @returns {bool} True if the transition request was accepted.
function bonus_room_transition(_target_room) {
	var _was_bonus_room_active;
	_was_bonus_room_active = o_director.bonus_room_active;
	
	var _bonus_room_origin;
	_bonus_room_origin = o_director.bonus_room_origin;
	
	if(!director_gameplay_transition_request(
		_target_room,
		director_gameplay_transition_options_build(_target_room, false, false, false)
	)){
		return false;
	}
	
	// If we're NOT currently in a bonus room, store origin
	if (!_was_bonus_room_active) {
		// Store current room as origin (for return trip)
		o_director.bonus_room_origin = room;
		o_director.bonus_room_active = true;
		
		// Store player's current position (to restore when returning)
		with (o_player) {
			o_director.bonus_room_entry_x = x;
			o_director.bonus_room_entry_y = y;
		}
		
		sdm("Entering bonus room from: " + room_get_name(room), LOG_COLOUR_COMMAND_SUCCESS);
	}
	else {
		// We're leaving a bonus room
		// Check if target is our origin (returning to main level)
		if (_target_room == _bonus_room_origin) {
			o_director.bonus_room_origin = noone;
			o_director.bonus_room_active = false;
			// Keep entry position - cleared after player spawns
			
			sdm("Returning to main level from bonus room", LOG_COLOUR_COMMAND_SUCCESS);
		}
		// Otherwise we're going to another bonus room (nested)
		else {
			sdm("Transitioning between bonus rooms", LOG_COLOUR_COMMAND_SUCCESS);
		}
	}
	
	// DO NOT reset level timer (bonus room is part of the level)
	return true;
}
