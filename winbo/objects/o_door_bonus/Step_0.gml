// Inherit actor behavior
event_inherited();

// Only process during gameplay
if (global.game_state != GameState.play) {
	exit;
}

// Check for player overlap
var _player_was_overlapping = bonus_door_player_overlapping;
var _player_in_range = false;
var _player_instance = noone;

with (o_player) {
	if (place_meeting(x, y, other)) {
		_player_in_range = true;
		_player_instance = id;
	}
}

bonus_door_player_overlapping = _player_in_range;

if (bonus_door_player_overlapping) {
	if (!_player_was_overlapping) {
		bonus_door_open_image_index = 0;
		bonus_door_portal_image_index = 0;
	}
	else {
		bonus_door_open_image_index += (bonus_door_open_animation_fps / SECOND) * global.delta_time_factor;
		bonus_door_portal_image_index += (bonus_door_portal_animation_fps / SECOND) * global.delta_time_factor;
	}
}
else {
	bonus_door_open_image_index = 0;
	bonus_door_portal_image_index = 0;
}

// Check for Up input while player is overlapping and grounded
if (_player_in_range && _player_instance != noone) {
	with (_player_instance) {
		// Player must be grounded
		if (move_grounded && state == PlayerState.move) {
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
	
	if (_player_instance != noone) {
		with (_player_instance) {
			player_bonus_room_enter_begin(other.room_target, other.x, y);
		}
	}
}
