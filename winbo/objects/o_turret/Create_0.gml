/// Floor mount: angle 0. Rotate the room instance for wall/ceiling mounts.
mount_angle = image_angle;
neutral_angle = 90 + mount_angle;
aim_angle = neutral_angle;
turn_speed = 2;
aim_half_arc = 60;
detection_range = 2500;
spread_angle = 15;
projectile_speed = 25;
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
