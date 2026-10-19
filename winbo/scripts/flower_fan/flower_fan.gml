#macro FLOWER_WIND_COAST_DECELERATION 1.1
#macro FLOWER_WIND_ACCELERATION 1.5
#macro FLOWER_WIND_RAMP_TIME (SECOND * 0.4)
#macro FLOWER_WIND_GRAVITY_SCALE 0.15
#macro FLOWER_WIND_FLUTTER_FADE (SECOND * 0.25)
#macro FLOWER_WIND_FLUTTER_X 3
#macro FLOWER_WIND_FLUTTER_Y 2

/// Player context. Called with the solid that stopped the player's downward
/// movement. Only standing on top of a bud opens it; side and underside
/// contact never reach this.
function flower_fan_land(_solid){
    if(_solid == noone){
        return false;
    }
    if(_solid.object_index != o_flower_fan){
        return false;
    }
    if(_solid.fan_state != FlowerFanState.bud){
        return false;
    }
    if(bbox_bottom > _solid.bbox_top + 1){
        return false;
    }
    if(swim_active || (state != PlayerState.move && state != PlayerState.float
    && state != PlayerState.dash && state != PlayerState.dive_spring)){
        return false;
    }
    player_spring_bounce(input_move_acceleration_jump * 2);
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

/// Player context. An ordinary airborne jump is never carried, but a wind
/// tunnel lightens its gravity while rising and while descending.
function player_flower_wind_drift_find(){
    if(state != PlayerState.move || move_grounded || swim_active || air_spin_active || move_trapped){
        return false;
    }
    var _px = (bbox_left + bbox_right) * 0.5;
    var _py = (bbox_top + bbox_bottom) * 0.5;
    var _count = instance_number(o_flower_fan);
    for(var _i = 0; _i < _count; _i++){
        var _fan = instance_find(o_flower_fan, _i);
        if(flower_fan_contains(_fan, _px, _py)){
            return true;
        }
    }
    return false;
}

/// Player context. Approach the tunnel speed under an acceleration limit that
/// builds with time in the wind, so entry is a gradual pick-up, not a jet kick.
/// Crosswind steering remains available; the normal movement solver handles all walls.
function player_flower_wind_apply(_fan){
    var _direction = _fan.image_angle + (_fan.image_yscale >= 0 ? 90 : 270);
    var _ux = lengthdir_x(1, _direction);
    var _uy = lengthdir_y(1, _direction);
    var _dt = global.delta_time_factor_scaled;
    var _along = velocity.x * _ux + velocity.y * _uy;
    var _blend = 1 - power(1 - clamp(_fan.wind_response, 0, 1), _dt);
    var _limit = FLOWER_WIND_ACCELERATION * flower_wind_strength * _dt;
    var _change = clamp((max(0, _fan.wind_speed) - _along) * _blend, -_limit, _limit);
    velocity.x += _ux * _change;
    velocity.y += _uy * _change;
}

/// Player state belongs to this airtime, so neither room changes nor landings
/// can carry a spent fan or an old launch into the next jump. Create also
/// initialises the render-only flutter; gameplay resets let it fade by itself.
function player_flower_wind_reset(_reset_render = true){
    flower_wind_source = noone;
    flower_wind_spent = noone;
    flower_wind_direction = 90;
    flower_wind_end_x = 0;
    flower_wind_end_y = 0;
    flower_wind_coast = 0;
    flower_wind_strength = 0;
    flower_wind_drift = false;
    flower_wind_float_hold = false;
    if(_reset_render){
        flower_wind_flutter = 0;
        flower_wind_flutter_time = 0;
    }
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
    // Only leaving the downwind end keeps its momentum. Releasing Float or
    // steering out of the side stops the force without giving a remote boost.
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
    }
    flower_wind_source = noone;
}

/// Run the usual rise/fall gravity blend, then keep only part of what it
/// added. The gravity vectors themselves are untouched, so full weight
/// returns as soon as Winbo is outside the tunnel.
function player_flower_wind_drift_movement_update(){
    var _gravity = move_gravity_enable;
    var _acceleration_y = acceleration.y;
    movement_gravity_update();
    acceleration.y -= (acceleration.y - _acceleration_y) * (1 - FLOWER_WIND_GRAVITY_SCALE) * flower_wind_strength;
    move_gravity_enable = false;
    player_movement_update();
    move_gravity_enable = _gravity;
}

/// Render only: a light flutter of the drawn body while wind acts on Winbo.
/// It rides the character draw offset, so position and collision mask never
/// move. Once faded out, the offset is left to its other owners.
function player_flower_wind_visual_update(){
    var _windy = (flower_wind_source != noone) || flower_wind_drift;
    if(!_windy && flower_wind_flutter <= 0) return;
    var _dt = global.delta_time_factor_scaled;
    flower_wind_flutter = clamp(flower_wind_flutter + (_windy ? _dt : -_dt) / FLOWER_WIND_FLUTTER_FADE, 0, 1);
    flower_wind_flutter_time += _dt;
    draw_adjustment_x = flower_wind_flutter * FLOWER_WIND_FLUTTER_X
        * (dsin(flower_wind_flutter_time * 37) * 0.65 + dsin(flower_wind_flutter_time * 61 + 40) * 0.35);
    draw_adjustment_y = flower_wind_flutter * FLOWER_WIND_FLUTTER_Y * dsin(flower_wind_flutter_time * 29 + 115);
}

/// Preserve the launch axis through the ordinary collision solver, while
/// retaining normal steering drag across the wind. All overrides are local.
function player_flower_wind_movement_update(){
    var _dt = global.delta_time_factor_scaled;
    var _fan = player_flower_wind_find();
    player_flower_wind_contact(_fan);
    flower_wind_drift = (_fan == noone) && player_flower_wind_drift_find();
    // One shared build-up eases in both the carry and the lighter gravity.
    flower_wind_strength = clamp(flower_wind_strength
        + ((_fan != noone || flower_wind_drift) ? _dt : -_dt) / FLOWER_WIND_RAMP_TIME, 0, 1);
    var _coasting = flower_wind_coast > 0;
    if(_fan == noone && !_coasting){
        if(flower_wind_drift){
            player_flower_wind_drift_movement_update();
        }
        else{
            player_movement_update();
        }
        return;
    }
    if((state != PlayerState.move && state != PlayerState.float) || swim_active){
        flower_wind_coast = 0;
        player_movement_update();
        return;
    }
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
