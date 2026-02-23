/// @function bullet_begin_deflect_flyoff
/// @summary Convert a projectile deflect into a harmless fly-off.
/// @param _direction Direction to launch the fly-off projectile.
function bullet_begin_deflect_flyoff(_direction){
	if(_direction == undefined){
		_direction = velocity_dir;
	}

	deflect_flyoff_active = true;
	state = BulletState.move;

	// Fly-off projectiles should not home or collide with solids.
	homing_enable = false;
	homing_target = noone;
	homing_delay = 0;
	move_collision_object = noone;

	// Make deflected projectile harmless.
	damage = 0;
	team = Team.player;
	owner = noone;

	// Suppress death visuals when transitioning from deflect to fly-off.
	death_anim_suppressed = true;
	death_anim_started = false;
	post_hit_movement_update_enable = false;

	// Set launch velocity directly so it immediately leaves the player.
	velocity.x = lengthdir_x(deflect_flyoff_speed, _direction);
	velocity.y = lengthdir_y(deflect_flyoff_speed, _direction);
	acceleration.Set(0, 0);

	if(alive_time == infinity){
		alive_time = deflect_flyoff_lifetime;
	}
	else{
		alive_time = min(alive_time, deflect_flyoff_lifetime);
	}
}
