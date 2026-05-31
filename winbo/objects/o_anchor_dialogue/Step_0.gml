event_inherited();

var _delta_time_scaled;
_delta_time_scaled = global.delta_time_factor_scaled;

presence_dialogue_frame += presence_dialogue_frame_speed * _delta_time_scaled;
if(presence_dialogue_frame >= 61) {
	presence_dialogue_frame = 0;
}

var _advance_pressed;
_advance_pressed = keyboard_check_pressed(vk_space)
	|| keyboard_check_pressed(vk_enter);

if(instance_number(o_player) > 0) {
	var _player;
	_player = instance_find(o_player,0);
	_advance_pressed = _advance_pressed
		|| (_player.input_current[UserControl.interact] && !_player.input_previous[UserControl.interact])
		|| (_player.input_current[UserControl.jump] && !_player.input_previous[UserControl.jump]);
}

var _text_length;
_text_length = string_length(presence_dialogue_page_text);

switch(presence_dialogue_phase) {
	case PresenceDialoguePhase.demon:
	case PresenceDialoguePhase.english:
		if(_advance_pressed && presence_dialogue_reveal_count < _text_length) {
			presence_dialogue_fast_countdown = 0.35 * SECOND;
		}

		var _reveal_speed;
		_reveal_speed = presence_dialogue_reveal_speed;
		if(presence_dialogue_fast_countdown > 0) {
			presence_dialogue_fast_countdown -= _delta_time_scaled;
			_reveal_speed = presence_dialogue_reveal_speed_fast;
		}

		if(presence_dialogue_reveal_count < _text_length) {
			presence_dialogue_reveal_count += _reveal_speed * _delta_time_scaled;
			if(presence_dialogue_reveal_count >= _text_length) {
				presence_dialogue_reveal_count = _text_length;
				if(presence_dialogue_phase == PresenceDialoguePhase.demon) {
					presence_dialogue_phase = PresenceDialoguePhase.decode_wait;
					presence_dialogue_decode_countdown = presence_dialogue_decode_wait_time;
				}
				else {
					presence_dialogue_phase = PresenceDialoguePhase.complete;
					presence_dialogue_ready_for_advance = true;
				}
			}
		}
	break;

	case PresenceDialoguePhase.decode_wait:
		presence_dialogue_decode_countdown -= _delta_time_scaled;
		if((presence_dialogue_decode_countdown <= 0) || _advance_pressed) {
			presence_dialogue_phase = PresenceDialoguePhase.english;
			presence_dialogue_reveal_count = 0;
			presence_dialogue_fast_countdown = 0;
		}
	break;

	case PresenceDialoguePhase.complete:
		if(_advance_pressed) {
			if(presence_dialogue_page_index < array_length(presence_dialogue_pages) - 1) {
				presence_dialogue_page_index += 1;
				presence_dialogue_page_start();
			}
			else {
				game_state_set_target(GameState.play);
				ui_anchor_remove(o_anchor_dialogue);
			}
		}
	break;
}
