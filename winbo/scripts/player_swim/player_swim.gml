/// Swimming shares the move/dash states so hazards, damage and room transitions
/// continue through the normal player collision path.
function player_swim_setup(){
	swim_active = false;
	liquid_surface_previous = noone;
	liquid_surface_previous_x = x;
	liquid_surface_previous_y = bbox_bottom;
	liquid_surface_left = 0;
	liquid_surface_right = 0;
	liquid_surface_top = 0;
	liquid_surface_colour = c_white;
	swim_dash_visual = false;
	swim_dash_direction = 0;
	swim_direction_previous = -1;
	swim_bubble_countdown = 0;
	swim_dash_recovery = 0;
	swim_acceleration = 1.8;
	swim_drag = 0.88;
	swim_dash_factor = 0.55;
	swim_dash_recovery_max = SECOND * 0.6;
}

function player_swim_contact_update(){
	var _can_swim = state == PlayerState.move || state == PlayerState.dash
		|| state == PlayerState.float || state == PlayerState.dive_spring;
	var _liquid = instance_position(x, y, o_volume_liquid);
	player_liquid_surface_crossing_update(instance_position(x, bbox_bottom, o_volume_liquid));
	var _submerged = _can_swim && (_liquid != noone);
	if(_submerged == swim_active) return;
	swim_active = _submerged;
	swim_direction_previous = -1;
	swim_dash_visual = false;
	if(swim_active){
		player_look_cancel(true);
		player_secret_idle_cancel(false);
		player_frolic_clear();
		player_air_spin_clear();
		player_dive_spring_reset();
		if(state != PlayerState.dash) state = PlayerState.move;
		landing_smoke_armed = false;
		jump_hold_allow_countdown = 0;
		velocity.MultiplyFactor(0.65);
		swim_dash_recovery = 0;
		dash_stamina = dash_stamina_max;
		dash_stamina_depleted = false;
		image_system_setup(spr_player_swim, 15, true, true, 5, IMAGE_LOOP_FULL);
		image_set_frame(image, 0);
		if(state == PlayerState.dash){
			swim_dash_direction = input_move_direction;
			swim_dash_visual = true;
			swim_dash_recovery = swim_dash_recovery_max;
			image_system_setup(spr_player_swim_dash, 15, true, false, 0, IMAGE_LOOP_FULL);
		}
		player_swim_bubbles(false, 90, true);
	}
	else{
		// Release the water-specific pose immediately on leaving the surface.
		if(_can_swim){
			image_system_setup(state == PlayerState.dash ? sprite_dash : sprite_fall,
				ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
		}
	}
}

function player_swim_bubbles(_fast, _direction, _entry = false){
	var _scale = random_range(0.75, 1.25);
	var _px = x, _py = y;
	var _sprite = _fast ? spr_fx_bubbles_fast : spr_fx_bubbles_slow;
	// Slow artwork ascends; fast artwork trails left of its right-hand origin.
	var _angle = _fast ? _direction : _direction + 90;
	if(_entry){
		_py = bbox_top;
		_angle = 0;
	}
	else{
		_px -= lengthdir_x(width * 0.3, _direction);
		_py -= lengthdir_y(height * 0.3, _direction);
	}
	var _fx = fx_spawn_sprite_once(_px, _py, "lyr_pfx_foreground", _sprite, _scale, _scale, _angle, 15);
	liquid_bubbles_clip(_fx, instance_position(x, y, o_volume_liquid));
}

function player_swim_tick(){
	var _dt = global.delta_time_factor_scaled;
	swim_bubble_countdown = max(0, swim_bubble_countdown - _dt);
	swim_dash_recovery = max(0, swim_dash_recovery - _dt);
	if(swim_dash_recovery <= 0 && state != PlayerState.dash){
		dash_stamina = dash_stamina_max;
		dash_stamina_depleted = false;
	}
}

function player_swim_integrate(){
	// Restore every movement option after the actual integrator, including
	// the grounded case, so exiting water cannot leak altered land physics.
	var _gravity = move_gravity_enable;
	var _retention = velocity_retention;
	var _aerial_retention = velocity_retention_aerial;
	var _retention_y = velocity_retention_enable.y;
	move_gravity_enable = false;
	velocity_retention = swim_drag;
	velocity_retention_aerial = power(swim_drag, global.delta_time_factor_scaled);
	velocity_retention_enable.y = true;
	player_movement_update();
	move_gravity_enable = _gravity;
	velocity_retention = _retention;
	velocity_retention_aerial = _aerial_retention;
	velocity_retention_enable.y = _retention_y;
}

function player_swim_move(){
	character_health();
	if(state != PlayerState.move) return;
	player_swim_tick();
	if(input_move_magnitude > 0.15){
		var _direction = (round(input_move_direction / 90) * 90) mod 360;
		if(swim_direction_previous >= 0 && _direction != swim_direction_previous && swim_bubble_countdown <= 0){
			player_swim_bubbles(false, input_move_direction);
			swim_bubble_countdown = SECOND * 0.2;
		}
		swim_direction_previous = _direction;
		dash_no_input_direction = input_move_direction;
		acceleration.AddMagnitudeDirection(swim_acceleration * min(1, input_move_magnitude), input_move_direction);
	}
	character_face(false);
	// A submerged floor is still swimmable, including the dash input.
	var _grounded = move_grounded;
	move_grounded = false;
	character_dash();
	move_grounded = _grounded;
	if(state == PlayerState.dash){
		swim_dash_direction = input_move_direction;
		swim_dash_recovery = swim_dash_recovery_max;
		swim_dash_visual = true;
		speed_stretch_enable = false;
		image_system_setup(spr_player_swim_dash, 15, true, false, 0, IMAGE_LOOP_FULL);
		image_set_frame(image, 0);
		player_swim_bubbles(true, input_move_direction);
	}
	player_collisions();
	player_swim_integrate();
	if(x < 0 || x > room_width || y < 0 || y > room_height) character_kill();
}

function player_swim_dash(){
	player_input();
	// Dash direction stays locked through the impulse; input polling still
	// consumes button edges so holding dash never repeats automatically.
	input_move_direction = swim_dash_direction;
	input_aim_direction = swim_dash_direction;
	character_health();
	if(state != PlayerState.dash) return;
	player_swim_tick();
	bump_allow_countdown = bump_allow_countdown_max;
	dash_countdown -= global.delta_time_factor_scaled;
	if(dash_countdown > 0){
		acceleration.AddMagnitudeDirection(dash_acceleration * swim_dash_factor, swim_dash_direction);
	}
	else{
		state = PlayerState.move;
		velocity_retention = velocity_retention_default;
		speed_stretch_enable = false;
	}
	character_face(false);
	player_collisions();
	player_swim_integrate();
}

function player_swim_visual_update(){
	if(!swim_active || (state != PlayerState.move && state != PlayerState.dash)) return;
	if(swim_dash_visual){
		if(sprite_current == spr_player_swim_dash && image.animate) return;
		swim_dash_visual = false;
	}
	if(sprite_current != spr_player_swim){
		image_system_setup(spr_player_swim, 15, true, true, 5, IMAGE_LOOP_FULL);
		image_set_frame(image, 5);
	}
}

function liquid_bubbles_update(){
	if(!ambient_bubbles_enable || global.game_state != GameState.play) return;
	ambient_bubbles_countdown -= global.delta_time_factor_scaled;
	if(ambient_bubbles_countdown > 0) return;
	ambient_bubbles_countdown = random_range(SECOND * 0.6, SECOND * 1.4);
	var _scale = random_range(0.75, 1.25);
	var _margin = min(90, (bbox_bottom - bbox_top) * 0.25);
	var _fx = fx_spawn_sprite_once(random_range(bbox_left, bbox_right), random_range(bbox_top + _margin, bbox_bottom),
		"lyr_pfx_foreground", spr_fx_bubbles_slow, _scale, _scale, 0, 15, 0.5);
	liquid_bubbles_clip(_fx, id);
}

// Snapshot the source volume so bubbles never spill above the surface or
// dereference a liquid instance after a room transition.
function liquid_bubbles_clip(_fx, _liquid){
	if(_liquid == noone) return;
	_fx.fx_liquid_clip_enable = true;
	_fx.fx_liquid_clip_left = _liquid.bbox_left;
	_fx.fx_liquid_clip_top = _liquid.bbox_top;
	_fx.fx_liquid_clip_right = _liquid.bbox_right;
	_fx.fx_liquid_clip_bottom = _liquid.bbox_bottom;
}

/// Surface crossing is geometric, independent of hit/swim states, so changing
/// state underwater cannot spawn repeated splashes. Snapshot bounds for exits.
function player_liquid_surface_crossing_update(_liquid){
    var _enter = _liquid != noone && _liquid != liquid_surface_previous;
    var _exit = liquid_surface_previous != noone && _liquid != liquid_surface_previous;
    if(_exit && liquid_surface_previous_y >= liquid_surface_top && bbox_bottom < liquid_surface_top){
        player_liquid_splash(liquid_surface_left, liquid_surface_right,
            liquid_surface_top, liquid_surface_colour);
    }
    if(_liquid != noone){
        liquid_surface_left = _liquid.bbox_left;
        liquid_surface_right = _liquid.bbox_right;
        liquid_surface_top = _liquid.bbox_top;
        liquid_surface_colour = _liquid.splash_colour;
        if(_enter && liquid_surface_previous_y < liquid_surface_top && bbox_bottom >= liquid_surface_top){
            player_liquid_splash(liquid_surface_left, liquid_surface_right,
                liquid_surface_top, liquid_surface_colour);
        }
    }
    liquid_surface_previous = _liquid;
    liquid_surface_previous_x = x;
    liquid_surface_previous_y = bbox_bottom;
}

function player_liquid_splash(_left, _right, _top, _colour){
    var _cross_fraction = (_top - liquid_surface_previous_y) / (bbox_bottom - liquid_surface_previous_y);
    var _cross_x = lerp(liquid_surface_previous_x, x, clamp(_cross_fraction, 0, 1));
    if(_cross_x < _left || _cross_x > _right) return;
    var _spread = (bbox_right - bbox_left) * 0.45;
    var _count = irandom_range(12, 18);
    for(var _i = 0; _i < _count; _i++){
        part_particles_create_colour(o_pfx.part_system_foreground,
            clamp(_cross_x + random_range(-_spread, _spread), _left, _right), _top,
            o_pfx.pfx_type_liquid_splash, _colour, 1);
    }
}
