#macro FLOWER_WIND_COAST_DECELERATION 1.1

/// Called by the player's confirmed solid bump, never by ordinary overlap.
function flower_fan_bump(_solid){
    if(_solid == noone){
        return false;
    }
    if(_solid.object_index != o_flower_fan){
        return false;
    }
    if(_solid.fan_state != FlowerFanState.bud){
        return false;
    }
    with(_solid){
        fan_state = FlowerFanState.blooming;
        image_system_setup(spr_flower_fan_bloom, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
        image.image_animation_time_scale_enable = true;
        sprite_current_frame = 0;
    }
    return true;
}

/// Wind containment in the same local space as its rendered tunnel.
/// Use the player's centre so force cannot extend beyond the visible tunnel bounds.
function flower_fan_contains(_fan, _px, _py){
    if(_fan.fan_state != FlowerFanState.active
    || _fan.image_xscale == 0 || _fan.image_yscale == 0){
        return false;
    }
    var _dx = _px - _fan.x;
    var _dy = _py - _fan.y;
    var _cos = dcos(_fan.image_angle);
    var _sin = dsin(_fan.image_angle);
    var _local_x = (_dx * _cos - _dy * _sin) / _fan.image_xscale;
    var _local_y = (_dx * _sin + _dy * _cos) / _fan.image_yscale;
    var _sprite = _fan.wind_sprite;
    _local_x += sprite_get_xoffset(_sprite);
    _local_y += sprite_get_yoffset(_sprite);
    return _local_x >= sprite_get_bbox_left(_sprite)
        && _local_x <= sprite_get_bbox_right(_sprite)
        && _local_y >= sprite_get_bbox_top(_sprite)
        && _local_y <= sprite_get_bbox_bottom(_sprite);
}

/// Player context. Stable first matching fan prevents overlapping tunnels stacking force.
function player_flower_wind_find(){
    if(state != PlayerState.float){
        return noone;
    }
    var _px = (bbox_left + bbox_right) * 0.5;
    var _py = (bbox_top + bbox_bottom) * 0.5;
    var _count = instance_number(o_flower_fan);
    for(var _i = 0; _i < _count; _i++){
        var _fan = instance_find(o_flower_fan, _i);
        if(_fan != flower_wind_spent && flower_fan_contains(_fan, _px, _py)){
            return _fan;
        }
    }
    return noone;
}

/// Player context. Smoothly approach a launch velocity along the tunnel.
/// Crosswind steering remains available; the normal movement solver handles all walls.
function player_flower_wind_apply(_fan){
    var _direction = _fan.image_angle + (_fan.image_yscale >= 0 ? 90 : 270);
    var _ux = lengthdir_x(1, _direction);
    var _uy = lengthdir_y(1, _direction);
    var _along = velocity.x * _ux + velocity.y * _uy;
    var _blend = 1 - power(1 - clamp(_fan.wind_response, 0, 1), global.delta_time_factor_scaled);
    var _change = (max(0, _fan.wind_speed) - _along) * _blend;
    velocity.x += _ux * _change;
    velocity.y += _uy * _change;
}

/// Player state belongs to this airtime, so neither room changes nor landings
/// can carry a spent fan or an old launch into the next jump.
function player_flower_wind_reset(){
    flower_wind_source = noone;
    flower_wind_spent = noone;
    flower_wind_direction = 90;
    flower_wind_end_x = 0;
    flower_wind_end_y = 0;
    flower_wind_coast = 0;
    flower_wind_float_rearm = false;
}

function player_flower_wind_input_update(){
    if(!player_dive_spring_float_input_active()) flower_wind_float_rearm = false;
}

function player_flower_wind_contact(_fan){
    if(_fan != noone){
        if(flower_wind_source != _fan){
            player_air_spin_clear();
            flower_wind_source = _fan;
            flower_wind_direction = _fan.image_angle + (_fan.image_yscale >= 0 ? 90 : 270);
            var _length = (sprite_get_yoffset(_fan.wind_sprite) - sprite_get_bbox_top(_fan.wind_sprite)) * abs(_fan.image_yscale);
            flower_wind_end_x = _fan.x + lengthdir_x(_length, flower_wind_direction);
            flower_wind_end_y = _fan.y + lengthdir_y(_length, flower_wind_direction);
            flower_wind_coast = 0;
        }
        return;
    }
    if(flower_wind_source == noone) return;
    // Only leaving the downwind end launches. Releasing Float or steering out
    // of the side stops the force without giving a remote boost.
    var _px = (bbox_left + bbox_right) * 0.5;
    var _py = (bbox_top + bbox_bottom) * 0.5;
    var _past_end = (_px - flower_wind_end_x) * lengthdir_x(1, flower_wind_direction)
        + (_py - flower_wind_end_y) * lengthdir_y(1, flower_wind_direction);
    if(_past_end >= 0 && (state == PlayerState.move || state == PlayerState.float) && !swim_active){
        // The last movement step can overshoot the tunnel end. Account for
        // that travelled distance so a longer frame does not grant extra range.
        var _ux = lengthdir_x(1, flower_wind_direction);
        var _uy = lengthdir_y(1, flower_wind_direction);
        var _along = max(0, velocity.x * _ux + velocity.y * _uy);
        var _launch_speed = sqrt(max(0, sqr(_along) - 2 * FLOWER_WIND_COAST_DECELERATION * _past_end));
        velocity.x += _ux * (_launch_speed - _along);
        velocity.y += _uy * (_launch_speed - _along);
        flower_wind_coast = SECOND * 0.6;
        flower_wind_spent = flower_wind_source;
        flower_wind_float_rearm = true;
    }
    flower_wind_source = noone;
}

/// Preserve the launch axis through the ordinary collision solver, while
/// retaining normal steering drag across the wind. All overrides are local.
function player_flower_wind_movement_update(){
    var _fan = player_flower_wind_find();
    player_flower_wind_contact(_fan);
    var _coasting = flower_wind_coast > 0;
    if(_fan == noone && !_coasting){
        player_movement_update();
        return;
    }
    if((state != PlayerState.move && state != PlayerState.float) || swim_active){
        flower_wind_coast = 0;
        player_movement_update();
        return;
    }
    var _dt = global.delta_time_factor_scaled;
    var _ux = lengthdir_x(1, flower_wind_direction);
    var _uy = lengthdir_y(1, flower_wind_direction);
    // Keep player steering perpendicular to the launch, so holding towards a
    // horizontal fan does not multiply its launch speed.
    var _input_along = INPUT_MOVE_ACCELERATION * input_move_magnitude
        * (lengthdir_x(1, input_move_direction) * _ux + lengthdir_y(1, input_move_direction) * _uy);
    acceleration.x -= _ux * _input_along;
    acceleration.y -= _uy * _input_along;
    if(_fan != noone){
        player_flower_wind_apply(_fan);
    }
    else{
        var _along = velocity.x * _ux + velocity.y * _uy;
        if(_along <= 0 || _dt <= 0){
            if(_along <= 0) flower_wind_coast = 0;
        }
        else{
            // A short, predictable arc beyond the visible tunnel.
            var _slowdown = min(FLOWER_WIND_COAST_DECELERATION, _along / _dt);
            acceleration.x -= _ux * _slowdown;
            acceleration.y -= _uy * _slowdown;
        }
        flower_wind_coast = max(0, flower_wind_coast - _dt);
    }
    var _gravity = move_gravity_enable;
    var _retention = velocity_retention;
    var _aerial = velocity_retention_aerial;
    move_gravity_enable = false;
    velocity_retention = 1;
    velocity_retention_aerial = 1;
    player_movement_update();
    move_gravity_enable = _gravity;
    velocity_retention = _retention;
    velocity_retention_aerial = _aerial;
    // Do not restore momentum after the solver has stopped us against a wall.
    var _blocked = (collision.x != 0 && collision.x * _ux > 0)
        || (collision.y != 0 && collision.y * _uy > 0);
    if(_blocked){
        if(_fan != noone) flower_wind_spent = _fan;
        flower_wind_source = noone;
        flower_wind_coast = 0;
        flower_wind_float_rearm = true;
    }
    else{
        var _along = velocity.x * _ux + velocity.y * _uy;
        var _cross_x = velocity.x - _ux * _along;
        var _cross_y = velocity.y - _uy * _along;
        var _cross_drag = power(_aerial, _dt);
        velocity.x = _ux * _along + _cross_x * _cross_drag;
        velocity.y = _uy * _along + _cross_y * _cross_drag;
        if(_coasting && _along <= 0) flower_wind_coast = 0;
        velocity_mag = velocity.Magnitude();
        velocity_dir = velocity.Direction();
        velocity_percent = velocity_mag / velocity_terminal;
        velocity_input_percent = velocity_mag / velocity_input_terminal;
    }
}
