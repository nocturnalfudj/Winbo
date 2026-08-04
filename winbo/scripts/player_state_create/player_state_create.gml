/// @function player_state_create
/// @summary Initialize the player instance and default state.
function player_state_create(){
	if(spawn_context != PlayerSpawnContext.none){
		player_stage_entrance_begin();
		state = PlayerState.stage_entrance;
		return;
	}

	//Grow & Appear
	transform_animate_grow_and_appear();
	
	//State to Idle
	state = PlayerState.idle;
}

function player_stage_entrance_begin(){
	var _transform;
	_transform = transform[TransformType.anchor];

	transform_set(_transform, TransformValue.xscale, 1, false);
	transform_set(_transform, TransformValue.yscale, 1, false);
	transform_set(_transform, TransformValue.alpha, 1, false);

	draw_adjustment_y = stage_entrance_draw_adjustment_y;

	velocity.x = 0;
	velocity.y = 0;
	acceleration.x = 0;
	acceleration.y = 0;

	stage_entrance_hp_vulnerable_previous = hp_vulnerable;
	stage_entrance_user_hp_vulnerable_previous = user.hp_vulnerable;
	hp_vulnerable = false;
	user.hp_vulnerable = false;

	image_system_setup(sprite_stage_entrance, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
	image_set_frame(image, 0);
}

function player_state_stage_entrance(){
	draw_adjustment_y = stage_entrance_draw_adjustment_y;

	velocity.x = 0;
	acceleration.x = 0;

	player_movement_update();

	velocity.x = 0;
	acceleration.x = 0;

	if(sprite_current != sprite_stage_entrance){
		image_system_setup(sprite_stage_entrance, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
		image_set_frame(image, 0);
	}

	if((sprite_current_frame >= (image.sprite_number - 1)) && move_grounded){
		player_stage_entrance_finish();
	}
}

function player_stage_entrance_finish(){
	draw_adjustment_y = 0;

	hp_vulnerable = stage_entrance_hp_vulnerable_previous;
	user.hp_vulnerable = stage_entrance_user_hp_vulnerable_previous;
	spawn_context = PlayerSpawnContext.none;

	// GameMaker collision masks include both bounding-box edges. A room spawn
	// whose feet are authored exactly on the platform top therefore begins one
	// pixel inside the floor. Match the normal downward-collision result by
	// moving that single pixel out before handing control to the player; leaving
	// it overlapped makes horizontal input hit the floor's x collision and push
	// back in the opposite direction until the first jump clears the overlap.
	if(place_meeting(x,y,move_collision_object)
	&& !place_meeting(x,y - 1,move_collision_object)) {
		y -= 1;
		transform_set(
			transform[TransformType.anchor],
			TransformValue.y,
			y,
			false
		);
	}

	// Return every movement field to the normal grounded-play baseline. Without
	// this reset, room-entry state can survive until the first jump refreshes it.
	velocity.Set(0,0);
	acceleration.Set(0,0);
	velocity_retention = velocity_retention_default;
	movement_input_move_acceleration_factor_set(1);
	input_move_direction = 0;
	input_move_magnitude = 0;
	input_move_direction_prev = 0;
	input_move_magnitude_prev = 0;
	input_aim_direction = 0;
	face_horizontal = 1;
	collision.Set(0,0);
	move_collision_object_instance = noone;

	move_grounded = place_meeting(x, y + 1, move_collision_object);
	if(move_grounded){
		move_grounded_instance = instance_place(x, y + 1, move_collision_object);
		move_grounded_close = true;
		move_grounded_close_instance = move_grounded_instance;
	}
	else{
		move_grounded_instance = noone;
		move_grounded_close = false;
		move_grounded_close_instance = noone;
	}
	move_grounded_previous = move_grounded;
	move_grounded_close_prev = move_grounded_close;
	stationary = true;
	stationary_time = 0;

	image_system_setup(sprite_idle, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
	image_set_frame(image, 0);
	state = PlayerState.move;
}

function player_bonus_room_enter_begin(_target_room, _target_x, _target_y, _hold_countdown){
	var _transform;
	_transform = transform[TransformType.anchor];

	transform_set(_transform, TransformValue.xscale, 1, false);
	transform_set(_transform, TransformValue.yscale, 1, false);
	transform_set(_transform, TransformValue.alpha, 1, false);

	velocity.x = 0;
	velocity.y = 0;
	acceleration.x = 0;
	acceleration.y = 0;

	bonus_room_enter_target_room = _target_room;
	bonus_room_enter_start_x = x;
	bonus_room_enter_start_y = y;
	bonus_room_enter_target_x = _target_x;
	bonus_room_enter_target_y = _target_y;
	bonus_room_enter_hold_countdown = max(0, _hold_countdown);
	bonus_room_enter_transition_requested = false;
	bonus_room_enter_hp_vulnerable_previous = hp_vulnerable;
	bonus_room_enter_user_hp_vulnerable_previous = user.hp_vulnerable;
	hp_vulnerable = false;
	user.hp_vulnerable = false;
	image_alpha = 1;

	image_system_setup(sprite_bonus_room_enter, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
	image_set_frame(image, 0);
	state = PlayerState.bonus_room_enter;
}

function player_state_bonus_room_enter(){
	velocity.x = 0;
	velocity.y = 0;
	acceleration.x = 0;
	acceleration.y = 0;

	if(bonus_room_enter_transition_requested){
		return;
	}

	if(sprite_current != sprite_bonus_room_enter){
		image_system_setup(sprite_bonus_room_enter, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
		image_set_frame(image, 0);
	}

	if(bonus_room_enter_hold_countdown > 0){
		bonus_room_enter_hold_countdown = max(0, bonus_room_enter_hold_countdown - global.delta_time_factor);
		image_set_frame(image, 0);
		return;
	}

	var _progress;
	_progress = clamp(sprite_current_frame / max(1, image.sprite_number - 1), 0, 1);
	_progress = _progress * _progress * (3 - 2 * _progress);
	x = lerp(bonus_room_enter_start_x, bonus_room_enter_target_x, _progress);
	y = lerp(bonus_room_enter_start_y, bonus_room_enter_target_y, _progress);

	if(sprite_current_frame >= (image.sprite_number - 1)){
		player_bonus_room_enter_finish();
	}
}

function player_bonus_room_enter_finish(){
	x = bonus_room_enter_target_x;
	y = bonus_room_enter_target_y;
	bonus_room_enter_hold_countdown = 0;

	var _target_room;
	_target_room = bonus_room_enter_target_room;

	if(bonus_room_transition(_target_room)){
		bonus_room_enter_transition_requested = true;
		bonus_room_enter_target_room = noone;
		image_alpha = 0;
		return;
	}

	hp_vulnerable = bonus_room_enter_hp_vulnerable_previous;
	user.hp_vulnerable = bonus_room_enter_user_hp_vulnerable_previous;

	image_system_setup(sprite_idle, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
	image_set_frame(image, 0);
	state = PlayerState.move;
}
