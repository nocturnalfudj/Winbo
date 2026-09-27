// Directional look: while grounded and standing still, Winbo plays an authored
// look pose (intro -> loop -> release) and the camera pans toward that direction
// to reveal nearby platforms. Any gameplay action interrupts it immediately.

enum PlayerLookPhase{
	inactive,
	hold,		//Intro frames play into the looping pose
	release
}

enum PlayerLookDirection{
	none,
	up,
	down,
	left,
	right,

	SIZE
}

//Animation (all look sprites share this frame layout)
#macro PLAYER_LOOK_FPS ANIMATION_FPS_DEFAULT
#macro PLAYER_LOOK_FRAME_INTRO_END 4
#macro PLAYER_LOOK_FRAME_LOOP_START 5
#macro PLAYER_LOOK_FRAME_LOOP_END 11			//Image loop_end is exclusive, so frames 5-10 loop
#macro PLAYER_LOOK_FRAME_RELEASE_START 11
#macro PLAYER_LOOK_FRAME_RELEASE_END 16

//Camera starts panning once the head turn is underway, so the pose leads the view
#macro PLAYER_LOOK_CAMERA_PAN_START_FRAME 2

//Input
#macro PLAYER_LOOK_KEY_MODIFIER ord("Q")		//Hold with the arrow keys; WASD movement is untouched
#macro PLAYER_LOOK_STICK_THRESHOLD_ENTER 0.6	//Right stick deflection needed to start a look
#macro PLAYER_LOOK_STICK_THRESHOLD_EXIT 0.35	//Deflection needed to keep holding the current look

/// @function player_look_setup
/// @summary Initialise directional look fields. Call from the player Create event after sprites are set.
function player_look_setup(){
	look_phase = PlayerLookPhase.inactive;
	look_direction = PlayerLookDirection.none;
	look_face_horizontal_draw_enable_previous = face_horizontal_draw_enable;

	look_sprite = array_create(PlayerLookDirection.SIZE, noone);
	look_sprite[PlayerLookDirection.up]		= spr_player_look_up;
	look_sprite[PlayerLookDirection.down]	= spr_player_look_down;
	look_sprite[PlayerLookDirection.left]	= spr_player_look_left;
	look_sprite[PlayerLookDirection.right]	= spr_player_look_right;

	//Clear any look pan carried over from a previous room
	with(o_camera){
		look_pan_direction.Set(0, 0);
		look_pan_offset.Set(0, 0);
		look_pan_lerp_factor = CAMERA_LOOK_PAN_LERP_FACTOR_RETURN;
	}
}

/// @function player_look_active
/// @summary Whether the look pose currently owns the player sprite.
function player_look_active(){
	return look_phase != PlayerLookPhase.inactive;
}

/// @function player_look_modifier_held
/// @summary Whether the keyboard look modifier is held on a keyboard-capable input type.
function player_look_modifier_held(){
	if(IS_MOBILE){
		return false;
	}

	switch(user.input){
		case Input.keyboard:
		case Input.mouse_and_keyboard:
		case Input.mouse_and_keyboard_and_gamepad:
			return keyboard_check(PLAYER_LOOK_KEY_MODIFIER);
	}

	return false;
}

/// @function player_look_arrow_keys_captured
/// @summary Whether arrow keys belong to look this step and must not jump, drop or dash.
function player_look_arrow_keys_captured(){
	return move_grounded && player_look_modifier_held();
}

/// @function player_look_input_direction
/// @summary Read the requested look direction from the right stick or the look modifier + arrow keys.
/// @returns {real} PlayerLookDirection value.
function player_look_input_direction(){
	if(IS_MOBILE){
		return PlayerLookDirection.none;
	}

	var _user_input;
	_user_input = user.input;

	#region Gamepad Right Stick
		if(GAMEPAD_ENABLE && ((_user_input == Input.gamepad) || (_user_input == Input.mouse_and_keyboard_and_gamepad))){
			var _stick_h, _stick_v;
			_stick_h = input_check_gamepad(user.input_device, gp_axisrh);
			_stick_v = input_check_gamepad(user.input_device, gp_axisrv);

			//Keep the current look while the stick stays past the lower exit threshold
			if(look_phase == PlayerLookPhase.hold){
				var _stick_along;
				_stick_along = 0;

				switch(look_direction){
					case PlayerLookDirection.up:	_stick_along = -_stick_v;	break;
					case PlayerLookDirection.down:	_stick_along = _stick_v;	break;
					case PlayerLookDirection.left:	_stick_along = -_stick_h;	break;
					case PlayerLookDirection.right:	_stick_along = _stick_h;	break;
				}

				if(_stick_along >= PLAYER_LOOK_STICK_THRESHOLD_EXIT){
					return look_direction;
				}
			}

			if(max(abs(_stick_h), abs(_stick_v)) >= PLAYER_LOOK_STICK_THRESHOLD_ENTER){
				if(abs(_stick_v) >= abs(_stick_h)){
					return (_stick_v > 0) ? PlayerLookDirection.down : PlayerLookDirection.up;
				}

				return (_stick_h > 0) ? PlayerLookDirection.right : PlayerLookDirection.left;
			}
		}
	#endregion

	#region Keyboard Modifier + Arrows
		if(player_look_modifier_held()){
			var _key_up, _key_down, _key_left, _key_right;
			_key_up = keyboard_check(vk_up);
			_key_down = keyboard_check(vk_down);
			_key_left = keyboard_check(vk_left);
			_key_right = keyboard_check(vk_right);

			//A second arrow does not steal an existing look
			if(look_phase == PlayerLookPhase.hold){
				switch(look_direction){
					case PlayerLookDirection.up:	if(_key_up)		return look_direction;	break;
					case PlayerLookDirection.down:	if(_key_down)	return look_direction;	break;
					case PlayerLookDirection.left:	if(_key_left)	return look_direction;	break;
					case PlayerLookDirection.right:	if(_key_right)	return look_direction;	break;
				}
			}

			if(_key_down)	return PlayerLookDirection.down;
			if(_key_up)		return PlayerLookDirection.up;
			if(_key_left && !_key_right)	return PlayerLookDirection.left;
			if(_key_right && !_key_left)	return PlayerLookDirection.right;
		}
	#endregion

	return PlayerLookDirection.none;
}

/// @function player_look_has_action_input
/// @summary Whether any gameplay control is active this step (interrupts look).
function player_look_has_action_input(){
	return (input_move_magnitude > 0)
		|| input_current[UserControl.up]
		|| input_current[UserControl.down]
		|| input_current[UserControl.left]
		|| input_current[UserControl.right]
		|| input_current[UserControl.jump]
		|| input_current[UserControl.dash]
		|| input_current[UserControl.attack]
		|| input_current[UserControl.interact]
		|| input_current[UserControl.interact_equip]
		|| input_current[UserControl.float]
		|| input_current[UserControl.run];
}

/// @function player_look_gate_open
/// @summary Look is only allowed while grounded, standing still and out of water.
function player_look_gate_open(_bump_block, _landing_block){
	return (global.game_state == GameState.play)
		&& (state == PlayerState.move)
		&& move_grounded
		&& stationary
		&& !frolic_active
		&& (liquid_collision_instance == noone)
		&& (secret_idle_phase == PLAYER_SECRET_IDLE_PHASE_INACTIVE)
		&& !_bump_block
		&& !_landing_block
		&& !image.is_playing_queued;
}

/// @function player_look_update
/// @summary Drive look input, pose and camera pan. Call from player_state_move after player_input().
/// @param _bump_block Bump animation still playing.
/// @param _landing_block Landing animation still playing.
function player_look_update(_bump_block, _landing_block){
	if(player_look_has_action_input()){
		player_look_cancel(true);
		return;
	}

	var _input_direction;
	_input_direction = player_look_input_direction();

	//A deliberate look ends the secret idle so it can start this step
	if((_input_direction != PlayerLookDirection.none) && (secret_idle_phase != PLAYER_SECRET_IDLE_PHASE_INACTIVE)){
		player_secret_idle_cancel(true);
	}

	if(!player_look_gate_open(_bump_block, _landing_block)){
		player_look_cancel(true);
		return;
	}

	switch(look_phase){
		case PlayerLookPhase.inactive:
			if(_input_direction != PlayerLookDirection.none){
				player_look_begin(_input_direction, 0);
			}
		break;

		case PlayerLookPhase.hold:
			if(_input_direction == PlayerLookDirection.none){
				player_look_release();
			}
			else if(_input_direction != look_direction){
				player_look_begin(_input_direction, 0);
			}
			else if(sprite_current_frame >= PLAYER_LOOK_CAMERA_PAN_START_FRAME){
				player_look_camera_set(look_direction, CAMERA_LOOK_PAN_LERP_FACTOR_PAN);
			}
		break;

		case PlayerLookPhase.release:
			if(_input_direction == look_direction){
				//Resume from the matching point of the intro instead of snapping back to frame 0
				player_look_begin(look_direction, max(0, PLAYER_LOOK_FRAME_INTRO_END - (sprite_current_frame - PLAYER_LOOK_FRAME_RELEASE_START)));
			}
			else if(_input_direction != PlayerLookDirection.none){
				player_look_begin(_input_direction, 0);
			}
			else if(!image.animate){
				player_look_finish();
			}
		break;
	}
}

/// @function player_look_begin
/// @summary Start (or restart) the look pose in a direction from an intro frame.
function player_look_begin(_direction, _frame){
	if(look_phase == PlayerLookPhase.inactive){
		look_face_horizontal_draw_enable_previous = face_horizontal_draw_enable;
	}

	look_phase = PlayerLookPhase.hold;
	look_direction = _direction;

	//Side looks turn Winbo so the release lands in the matching idle facing
	if(_direction == PlayerLookDirection.left){
		face_horizontal = -1;
	}
	else if(_direction == PlayerLookDirection.right){
		face_horizontal = 1;
	}

	//Each direction is authored explicitly, so never mirror it by facing
	face_horizontal_draw_enable = false;

	image_system_setup(look_sprite[_direction], PLAYER_LOOK_FPS, true, true, PLAYER_LOOK_FRAME_LOOP_START, PLAYER_LOOK_FRAME_LOOP_END);
	image_set_frame(image, _frame);

	if(_frame >= PLAYER_LOOK_CAMERA_PAN_START_FRAME){
		player_look_camera_set(_direction, CAMERA_LOOK_PAN_LERP_FACTOR_PAN);
	}
}

/// @function player_look_release
/// @summary Play the release frames and ease the camera back.
function player_look_release(){
	var _frame, _release_frame;
	_frame = sprite_current_frame;
	_release_frame = PLAYER_LOOK_FRAME_RELEASE_START;

	//Released mid-intro: enter the release at the matching pose
	if(_frame < PLAYER_LOOK_FRAME_LOOP_START){
		_release_frame += PLAYER_LOOK_FRAME_INTRO_END - _frame;
	}

	look_phase = PlayerLookPhase.release;

	image_system_setup(look_sprite[look_direction], PLAYER_LOOK_FPS, true, false, 0, IMAGE_LOOP_FULL);
	image_set_frame(image, min(_release_frame, PLAYER_LOOK_FRAME_RELEASE_END));

	player_look_camera_set(PlayerLookDirection.none, CAMERA_LOOK_PAN_LERP_FACTOR_RETURN);
}

/// @function player_look_finish
/// @summary Release animation complete; hand the sprite back to idle.
function player_look_finish(){
	look_phase = PlayerLookPhase.inactive;
	look_direction = PlayerLookDirection.none;
	face_horizontal_draw_enable = look_face_horizontal_draw_enable_previous;

	image_system_setup(sprite_idle, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
}

/// @function player_look_cancel
/// @summary Stop looking immediately (move, jump, dash, hit, death, cutscene, water...).
/// @param _interrupt true snaps the camera back quickly; false uses the gentle release return.
function player_look_cancel(_interrupt = true){
	if(look_phase == PlayerLookPhase.inactive){
		return;
	}

	player_look_camera_set(PlayerLookDirection.none, _interrupt ? CAMERA_LOOK_PAN_LERP_FACTOR_INTERRUPT : CAMERA_LOOK_PAN_LERP_FACTOR_RETURN);

	//Only replace the sprite if nothing else has claimed it this step
	if(sprite_current == look_sprite[look_direction]){
		image_system_setup(sprite_idle, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
	}

	look_phase = PlayerLookPhase.inactive;
	look_direction = PlayerLookDirection.none;
	face_horizontal_draw_enable = look_face_horizontal_draw_enable_previous;
}

/// @function player_look_camera_set
/// @summary Point the camera look pan in a direction (none returns it to centre).
function player_look_camera_set(_direction, _lerp_factor){
	var _x, _y;
	_x = 0;
	_y = 0;

	switch(_direction){
		case PlayerLookDirection.up:	_y = -1;	break;
		case PlayerLookDirection.down:	_y = 1;		break;
		case PlayerLookDirection.left:	_x = -1;	break;
		case PlayerLookDirection.right:	_x = 1;		break;
	}

	with(o_camera){
		look_pan_direction.Set(_x, _y);
		look_pan_lerp_factor = _lerp_factor;
	}
}
