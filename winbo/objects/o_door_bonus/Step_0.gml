// Inherit actor behavior
event_inherited();

// Only process during gameplay
if (global.game_state != GameState.play) {
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
		// Player must be grounded
		if (move_grounded) {
			// Check for Up key pressed (W key or vk_up arrow)
			var _up_pressed = false;
			
			// Check input system up control (W key)
			if (input_current[UserControl.up] && !input_previous[UserControl.up]) {
				_up_pressed = true;
			}
			
			// Also check vk_up arrow key for arrow key support
			if (!_up_pressed) {
				if (keyboard_check_pressed(vk_up)) {
					_up_pressed = true;
				}
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
	
	// Execute bonus room transition
	bonus_room_transition(room_target);
}
