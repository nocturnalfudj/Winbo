/// @function bonus_room_transition
/// @summary Handle direct room transition for bonus rooms (bypasses presence room)
/// @param {asset.GMRoom} _target_room The room to transition to
/// @returns {void}
function bonus_room_transition(_target_room) {
	// If we're NOT currently in a bonus room, store origin
	if (!o_director.bonus_room_active) {
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
		if (_target_room == o_director.bonus_room_origin) {
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
	
	// Set transitioning flag to prevent life deduction
	o_director.level_transitioning = true;
	
	// Direct room transition (NO presence room)
	room_goto(_target_room);
	
	// Keep game state as play
	global.game_state = GameState.play;
	global.game_state_target = noone;
	
	// DO NOT reset level timer (bonus room is part of the level)
}
