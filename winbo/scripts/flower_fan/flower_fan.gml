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
        if(flower_fan_contains(_fan, _px, _py)){
            return _fan;
        }
    }
    return noone;
}

/// Player context. Smoothly approach a slow carry velocity along the tunnel.
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
