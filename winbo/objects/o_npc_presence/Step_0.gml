//Inherit Actor
event_inherited();

//Game State Switch
switch(global.game_state){
	case GameState.play:
		//Transform Update
		transform_system_update();
		
		//Interact System
		interact_system_update();
	break;

	case GameState.dialogue:
		//Transform Update
		transform_system_update();
	break;
	
	case GameState.gameover:
		//Transform Update
		transform_system_update();
	break;
	
	case GameState.stop:
	case GameState.menu:
		//Transform Update
		transform_system_update();
	break;
}

if(!presence_visual_enable){
	exit;
}

if((global.game_state != GameState.play) && (global.game_state != GameState.dialogue)){
	exit;
}

var _player_in_range;
var _player_dx;
_player_in_range = false;
_player_dx = 0;

if(instance_number(o_player) > 0){
	var _player;
	_player = instance_find(o_player,0);
	_player_dx = _player.x - x;

	var _distance_limit;
	_distance_limit = presence_visual_exit_distance;
	if((presence_visual_state == PresenceVisualState.hidden) || (presence_visual_state == PresenceVisualState.intro)){
		_distance_limit = presence_visual_enter_distance;
	}

	_player_in_range = point_distance(x,y,_player.x,_player.y) <= _distance_limit;
}

var _frame_step;
_frame_step = presence_visual_frame_speed * global.delta_time_factor;
var _eye_update_count, _eye_update_due;
presence_visual_eye_update_accumulator += presence_visual_eye_frame_speed * global.delta_time_factor;
_eye_update_count = floor(presence_visual_eye_update_accumulator);
_eye_update_due = _eye_update_count > 0;
if(_eye_update_due){
	presence_visual_eye_update_accumulator -= _eye_update_count;
}

switch(presence_visual_state){
	case PresenceVisualState.hidden:
		if(_player_in_range){
			presence_visual_state = PresenceVisualState.intro;
			presence_visual_intro_frame = 0;
			presence_visual_body_idle_frame = presence_visual_body_idle_start;
			presence_visual_head_idle_frame = 0;
			presence_visual_eyes_idle_frame = presence_visual_front_eyes_idle_start;
			presence_visual_eye_sprite = spr_npc_presence_eyes_front;
			presence_visual_eye_direction = PresenceEyeDirection.front;
			presence_visual_eye_direction_target = PresenceEyeDirection.front;
			presence_visual_head_direction = PresenceHeadDirection.front;
			presence_visual_eye_update_accumulator = 0;
		}
	break;

	case PresenceVisualState.intro:
		presence_visual_intro_frame += _frame_step;
		if(presence_visual_intro_frame >= (presence_visual_body_intro_end + 1)){
			presence_visual_intro_frame = presence_visual_body_intro_end;
			if(_player_in_range){
				presence_visual_state = PresenceVisualState.idle;
			}
			else{
				presence_visual_state = PresenceVisualState.outro;
				presence_visual_intro_frame = presence_visual_body_intro_end + 1;
			}
		}
	break;

	case PresenceVisualState.idle:
		presence_visual_body_idle_frame += _frame_step;
		if(presence_visual_body_idle_frame >= (presence_visual_body_idle_end + 1)){
			presence_visual_body_idle_frame = presence_visual_body_idle_start;
		}

		if(_player_dx <= -180){
			presence_visual_head_direction = PresenceHeadDirection.left;
		}
		else if(_player_dx >= 180){
			presence_visual_head_direction = PresenceHeadDirection.right;
		}
		else{
			presence_visual_head_direction = PresenceHeadDirection.front;
		}

		var _head_idle_end;
		switch(presence_visual_head_direction){
			case PresenceHeadDirection.left:
				_head_idle_end = presence_visual_head_left_idle_end;
			break;

			case PresenceHeadDirection.right:
				_head_idle_end = presence_visual_head_right_idle_end;
			break;

			default:
				_head_idle_end = presence_visual_head_front_idle_end;
			break;
		}

		presence_visual_head_idle_frame += _frame_step;
		if(presence_visual_head_idle_frame >= (_head_idle_end + 1)){
			presence_visual_head_idle_frame = 0;
		}

		if(_eye_update_due){
			var _eye_tracking_normalized_x;
			_eye_tracking_normalized_x = clamp(_player_dx / presence_visual_eye_tracking_world_range_x, -1, 1);

			if(_eye_tracking_normalized_x <= -presence_visual_eye_tracking_extreme_threshold){
				presence_visual_eye_direction_target = PresenceEyeDirection.extreme_left;
			}
			else if(_eye_tracking_normalized_x <= -presence_visual_eye_tracking_inbetween_threshold){
				presence_visual_eye_direction_target = PresenceEyeDirection.inbetween_left;
			}
			else if(_eye_tracking_normalized_x >= presence_visual_eye_tracking_extreme_threshold){
				presence_visual_eye_direction_target = PresenceEyeDirection.extreme_right;
			}
			else if(_eye_tracking_normalized_x >= presence_visual_eye_tracking_inbetween_threshold){
				presence_visual_eye_direction_target = PresenceEyeDirection.inbetween_right;
			}
			else{
				presence_visual_eye_direction_target = PresenceEyeDirection.front;
			}

			// Replay each elapsed 30Hz tick individually so dropped-frame
			// catch-up matches unbatched 30fps playback exactly: one direction
			// notch and one frame advance with its wrap check per tick.
			var _previous_eye_sprite;
			repeat(_eye_update_count){
				_previous_eye_sprite = presence_visual_eye_sprite;

				if(presence_visual_eye_direction < presence_visual_eye_direction_target){
					presence_visual_eye_direction += 1;
				}
				else if(presence_visual_eye_direction > presence_visual_eye_direction_target){
					presence_visual_eye_direction -= 1;
				}

				switch(presence_visual_eye_direction){
					case PresenceEyeDirection.extreme_left:
						presence_visual_eye_sprite = spr_npc_presence_eyes_left_b;
					break;

					case PresenceEyeDirection.inbetween_left:
						presence_visual_eye_sprite = spr_npc_presence_eyes_left_a;
					break;

					case PresenceEyeDirection.inbetween_right:
						presence_visual_eye_sprite = spr_npc_presence_eyes_right_a;
					break;

					case PresenceEyeDirection.extreme_right:
						presence_visual_eye_sprite = spr_npc_presence_eyes_right_b;
					break;

					default:
						presence_visual_eye_sprite = spr_npc_presence_eyes_front;
					break;
				}

				if(presence_visual_eye_sprite != _previous_eye_sprite){
					if(presence_visual_eye_sprite == spr_npc_presence_eyes_front){
						presence_visual_eyes_idle_frame = presence_visual_front_eyes_idle_start;
					}
					else{
						presence_visual_eyes_idle_frame = 0;
					}
				}
				else{
					presence_visual_eyes_idle_frame += 1;
					if(presence_visual_eye_sprite == spr_npc_presence_eyes_front){
						if(presence_visual_eyes_idle_frame >= (presence_visual_front_eyes_idle_end + 1)){
							presence_visual_eyes_idle_frame = presence_visual_front_eyes_idle_start;
						}
					}
					else if(presence_visual_eyes_idle_frame >= 10){
						presence_visual_eyes_idle_frame = 0;
					}
				}
			}
		}

		if(!_player_in_range){
			presence_visual_state = PresenceVisualState.outro;
			presence_visual_intro_frame = presence_visual_body_intro_end + 1;
			presence_visual_eye_direction_target = PresenceEyeDirection.front;
			presence_visual_head_direction = PresenceHeadDirection.front;
		}
	break;

	case PresenceVisualState.outro:
		presence_visual_intro_frame -= _frame_step;
		if(_eye_update_due){
			presence_visual_eye_direction_target = PresenceEyeDirection.front;
			repeat(_eye_update_count){
				if(presence_visual_eye_direction < presence_visual_eye_direction_target){
					presence_visual_eye_direction += 1;
				}
				else if(presence_visual_eye_direction > presence_visual_eye_direction_target){
					presence_visual_eye_direction -= 1;
				}

				switch(presence_visual_eye_direction){
					case PresenceEyeDirection.extreme_left:
						presence_visual_eye_sprite = spr_npc_presence_eyes_left_b;
					break;

					case PresenceEyeDirection.inbetween_left:
						presence_visual_eye_sprite = spr_npc_presence_eyes_left_a;
					break;

					case PresenceEyeDirection.inbetween_right:
						presence_visual_eye_sprite = spr_npc_presence_eyes_right_a;
					break;

					case PresenceEyeDirection.extreme_right:
						presence_visual_eye_sprite = spr_npc_presence_eyes_right_b;
					break;

					default:
						presence_visual_eye_sprite = spr_npc_presence_eyes_front;
						presence_visual_eye_direction = PresenceEyeDirection.front;
					break;
				}
			}
		}
		if(presence_visual_intro_frame < 0){
			presence_visual_intro_frame = 0;
			presence_visual_eye_direction = PresenceEyeDirection.front;
			presence_visual_eye_direction_target = PresenceEyeDirection.front;
			presence_visual_eye_sprite = spr_npc_presence_eyes_front;
			presence_visual_state = PresenceVisualState.hidden;
		}
	break;
}
