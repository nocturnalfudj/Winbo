/// Floor mount: angle 0. Rotate the room instance for wall/ceiling mounts.
mount_angle = image_angle;
neutral_angle = 90 + mount_angle;
aim_angle = neutral_angle;
// Distance from the bottom-centre pivot to the restored barrel mouth.
muzzle_distance = 416;
turn_speed = 2;
aim_half_arc = 60;
detection_range = 2500;
spread_angle = 15;
projectile_speed = 20;
projectile_damage = 1;
telegraph_time = SECOND;
fire_interval = SECOND * 2;
fire_countdown = telegraph_time;
shot_frame = 0;
shot_animating = false;
target_instance = noone;
reticle_frame = 0;
// Frames 31-38 fade out; hold the last locked pose until sight is lost.
reticle_lock_frame = 30;
team = Team.enemy;
image_speed = 0;

// The pivot is embedded in its mounting platform. Only that platform may
// intersect the barrel; the muzzle and the sightline still have to be clear.
turret_barrel_clear = function(_mx, _my) {
    var _mount = collision_point(x, y, o_solid, false, true);
    var _hits = ds_list_create();
    var _count = collision_line_list(x, y, _mx, _my, o_solid, false, true, _hits, false);
    var _clear = true;
    for(var _i = 0; _i < _count; _i++){
        if(_hits[| _i] != _mount){
            _clear = false;
            break;
        }
    }
    ds_list_destroy(_hits);
    return _clear && collision_point(_mx, _my, o_solid, false, true) == noone;
};
