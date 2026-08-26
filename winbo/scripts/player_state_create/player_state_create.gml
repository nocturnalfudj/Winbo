/// @function player_state_create
/// @summary Initialize the player instance and default state.
function player_state_create(){
	if(spawn_context == PlayerSpawnContext.level_start){
		player_stage_entrance_begin();
		state = PlayerState.stage_entrance;
		return;
	}
	if(spawn_context == PlayerSpawnContext.tutorial_continue){
		player_tutorial_continue_begin();
		state = PlayerState.stage_entrance;
		return;
	}

	// Presence has its own room reveal. Spawn Winbo normally at the authored
	// marker instead of replaying the large level-entry sequence over it.
	if(spawn_context == PlayerSpawnContext.presence_start){
		// The generic Create path starts the actor fully transparent and grows it
		// in. That made a normal Presence-room spawn look absent and left the
		// marker's one-pixel floor overlap untreated. Reuse the one-time entry
		// normalization without playing any level-entry artwork or movement.
		var _presence_transform;
		_presence_transform = transform[TransformType.anchor];
		transform_set(_presence_transform, TransformValue.xscale, 1, false);
		transform_set(_presence_transform, TransformValue.yscale, 1, false);
		transform_set(_presence_transform, TransformValue.alpha, 1, false);
		player_stage_entrance_finish();
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

	// The supplied sequence already contains Winbo's complete horizontal arc.
	// Translate that whole authored arc so frame zero starts just beyond the
	// camera edge. Do not add a second eased journey back to the old centre
	// marker: Andy explicitly noted that a left-side entry would land farther
	// left because the source animation is intentionally short.
	var _entrance_frame_zero_right_x = 67;
	var _entrance_camera_left_x = camera_get_view_x(view_camera[0]);
	var _entrance_landing_x = min(
		x,
		_entrance_camera_left_x
			+ sprite_get_xoffset(sprite_stage_entrance)
			- _entrance_frame_zero_right_x
			- 1
	);
	x = _entrance_landing_x;
	transform_set(_transform, TransformValue.x, x, false);
	draw_adjustment_x = 0;
	stage_entrance_landing_smoke_pending = (room != r_opening_cutscene);
	player_spawn_floor_overlap_resolve();

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
	if(spawn_context == PlayerSpawnContext.tutorial_continue){
		player_state_tutorial_continue();
		return;
	}

	draw_adjustment_x = 0;
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
		if(stage_entrance_landing_smoke_pending){
			stage_entrance_landing_smoke_pending = false;
			fx_spawn_sprite_once(x, bbox_bottom, "lyr_pfx_foreground", spr_fx_smoke_landing, 1, 1, 0, 18);
		}
		player_stage_entrance_finish();
	}
}

function player_tutorial_continue_begin(){
	var _transform = transform[TransformType.anchor];
	transform_set(_transform, TransformValue.xscale, 1, false);
	transform_set(_transform, TransformValue.yscale, 1, false);
	transform_set(_transform, TransformValue.alpha, 1, false);

	draw_adjustment_x = 0;
	draw_adjustment_y = 0;
	velocity.Set(0,0);
	acceleration.Set(0,0);

	stage_entrance_hp_vulnerable_previous = hp_vulnerable;
	stage_entrance_user_hp_vulnerable_previous = user.hp_vulnerable;
	hp_vulnerable = false;
	user.hp_vulnerable = false;
	tutorial_continue_countdown = SECOND * 0.5;

	input_move_direction = 0;
	input_move_magnitude = 1;
	input_aim_direction = 0;
	face_horizontal = 1;
	image_system_setup(sprite_walk, ANIMATION_FPS_DEFAULT, true, true, 4, IMAGE_LOOP_FULL);
}

function player_state_tutorial_continue(){
	input_move_direction = 0;
	input_move_magnitude = 1;
	input_aim_direction = 0;
	face_horizontal = 1;
	acceleration.AddMagnitudeDirection(INPUT_MOVE_ACCELERATION, 0);
	player_movement_update();

	if(sprite_current != sprite_walk){
		image_system_setup(sprite_walk, ANIMATION_FPS_DEFAULT, true, true, 4, IMAGE_LOOP_FULL);
	}

	tutorial_continue_countdown -= global.delta_time_factor_scaled;
	if(tutorial_continue_countdown <= 0 || collision.x == 1){
		player_stage_entrance_finish();
	}
}

function player_stage_entrance_finish(){
	draw_adjustment_x = 0;
	draw_adjustment_y = 0;

	hp_vulnerable = stage_entrance_hp_vulnerable_previous;
	user.hp_vulnerable = stage_entrance_user_hp_vulnerable_previous;
	spawn_context = PlayerSpawnContext.none;
	stage_entrance_landing_smoke_pending = false;

	player_spawn_floor_overlap_resolve();

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

/// @summary Resolve the one-pixel overlap produced when an authored player
/// start marker sits exactly on a platform's collision edge.
function player_spawn_floor_overlap_resolve(){
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
