// Inherit actor behavior
event_inherited();

// Only process during gameplay
if (global.game_state != GameState.play) {
	exit;
}

// Only active when in a bonus room
if (!o_director.bonus_room_active) {
	exit;
}

// Check for player overlap
var _player_in_range = false;
var _player_instance = noone;

with (o_player) {
	if (place_meeting(x, y, other)) {
		_player_in_range = true;
		_player_instance = id;
	}
}

bonus_door_player_overlapping = _player_in_range;

// Check for Up input while player is overlapping and grounded
if (_player_in_range && _player_instance != noone) {
	with (_player_instance) {
		if (move_grounded) {
			var _up_pressed = false;
			
			if (input_current[UserControl.up] && !input_previous[UserControl.up]) {
				_up_pressed = true;
			}
			
			if (!_up_pressed && keyboard_check_pressed(vk_up)) {
				_up_pressed = true;
			}
			
			if (_up_pressed) {
				other.bonus_door_input_pressed = true;
			}
		}
	}
}

// Handle transition when input is pressed
if (bonus_door_input_pressed) {
	bonus_door_input_pressed = false;
	
	// Return to the origin room (dynamically read from director)
	bonus_room_transition(o_director.bonus_room_origin);
}
