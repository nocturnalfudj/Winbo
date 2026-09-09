if(global.game_state != GameState.play) exit;
var _dt = global.delta_time_factor_scaled;
var _previous_target = target_instance;
target_instance = noone;
var _desired_angle = neutral_angle;
var _camera = instance_find(o_camera, 0);
var _on_screen = false;
if(_camera != noone){
    _on_screen = point_in_rectangle(x, y, _camera.start_x, _camera.start_y, _camera.end_x, _camera.end_y);
}
var _player = instance_nearest(x, y, o_player);
if(_on_screen && _player != noone && _player.target_can_be_targeted[TargetType.attack]){
    var _tx = (_player.bbox_left + _player.bbox_right) * 0.5;
    var _ty = (_player.bbox_top + _player.bbox_bottom) * 0.5;
    var _direction = point_direction(x, y, _tx, _ty);
    if(point_distance(x, y, _tx, _ty) <= detection_range
    && abs(angle_difference(_direction, neutral_angle)) <= aim_half_arc
    && collision_line(x, y, _tx, _ty, o_solid, false, true) == noone){
        target_instance = _player;
        _desired_angle = _direction;
    }
}
aim_angle += clamp(angle_difference(_desired_angle, aim_angle), -turn_speed * _dt, turn_speed * _dt);
if(shot_animating){
    shot_frame += 15 * _dt / SECOND;
    if(shot_frame >= sprite_get_number(spr_turret_back)){
        shot_frame = 0;
        shot_animating = false;
    }
}
if(target_instance == noone){
    fire_countdown = telegraph_time;
    reticle_frame = 0;
    exit;
}
if(target_instance != _previous_target){
    fire_countdown = telegraph_time;
    reticle_frame = 0;
}
reticle_frame = min(reticle_lock_frame, reticle_frame + 15 * _dt / SECOND);
fire_countdown = max(0, fire_countdown - _dt);
if(fire_countdown > 0 || abs(angle_difference(_desired_angle, aim_angle)) > 2) exit;
// The source artwork points up, with its pivot at the bottom centre.
var _muzzle_distance = 416 * abs(image_yscale);
var _mx = x + lengthdir_x(_muzzle_distance, aim_angle);
var _my = y + lengthdir_y(_muzzle_distance, aim_angle);
if(collision_line(x, y, _mx, _my, o_solid, false, true) != noone) exit;
for(var _i = -1; _i <= 1; _i++){
    var _bullet = instance_create_layer(_mx, _my, "lyr_player", o_bullet);
    _bullet.team = team;
    _bullet.owner = id;
    _bullet.damage = projectile_damage;
    _bullet.sprite_index = spr_apocalypse_survivor_projectile;
    _bullet.sprite_current = spr_apocalypse_survivor_projectile;
    with(_bullet) image_system_setup(spr_apocalypse_survivor_projectile, 15, true, true, 0, IMAGE_LOOP_FULL);
    _bullet.mask_index = spr_apocalypse_survivor_projectile;
    _bullet.sprite_angle_offset = 180;
    _bullet.death_anim_sprite = spr_apocalypse_survivor_projectile_impact;
    _bullet.death_anim_fps = 18;
    _bullet.acceleration.AddMagnitudeDirection(projectile_speed, aim_angle + _i * spread_angle);
}
fire_countdown = fire_interval;
shot_frame = 0;
shot_animating = true;
