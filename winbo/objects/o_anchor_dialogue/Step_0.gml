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
_text_length = presence_dialogue_page_character_count;

switch(presence_dialogue_phase) {
	case PresenceDialoguePhase.demon_type:
	case PresenceDialoguePhase.direct_english_type:
		if(_advance_pressed && presence_dialogue_reveal_count < _text_length) {
			presence_dialogue_fast_countdown = 0.35 * SECOND;
		}
		else if(_advance_pressed && presence_dialogue_reveal_finish_countdown > 0) {
			presence_dialogue_reveal_finish_countdown = 0;
			presence_dialogue_reveal_finish();
		}

		var _reveal_speed;
		_reveal_speed = presence_dialogue_reveal_speed;
		if(presence_dialogue_fast_countdown > 0) {
			presence_dialogue_fast_countdown -= _delta_time_scaled;
			_reveal_speed = presence_dialogue_reveal_speed_fast;
		}

		if(presence_dialogue_reveal_count < _text_length) {
			presence_dialogue_reveal_count += _reveal_speed * _delta_time_scaled;
			presence_dialogue_text_apply_reveal();
			if(presence_dialogue_reveal_count >= _text_length) {
				presence_dialogue_reveal_count = _text_length;
				presence_dialogue_text_apply_reveal();
				presence_dialogue_reveal_finish_countdown = presence_dialogue_character_reveal_fade_time;
			}
		}
		else if(presence_dialogue_reveal_finish_countdown > 0) {
			presence_dialogue_reveal_finish_countdown -= _delta_time_scaled;
			if(presence_dialogue_reveal_finish_countdown <= 0) {
				presence_dialogue_reveal_finish_countdown = 0;
				presence_dialogue_reveal_finish();
			}
		}
		else if(_text_length <= 0) {
			presence_dialogue_reveal_finish();
		}
	break;

	case PresenceDialoguePhase.decode_glitch:
		if(_advance_pressed) {
			presence_dialogue_decode_time = presence_dialogue_decode_duration;
		}
		else {
			presence_dialogue_decode_time += _delta_time_scaled;
		}

		if(presence_dialogue_decode_time >= presence_dialogue_decode_duration) {
			presence_dialogue_decode_time = presence_dialogue_decode_duration;
			presence_dialogue_decode_complete();
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
