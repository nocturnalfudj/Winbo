// Inherit the parent event
event_inherited();

//Star with No Scale
image_xscale = 0;
image_yscale = 0;

//Sprite Current
sprite_current = sprite_index;

#region State
	enum BulletState{
		create,
		move,
		hit,
		death,
		destroy
	}
	
	state = BulletState.create;
	
	//States
	move_state = BulletState.move;
	death_state = BulletState.death;
	destroy_state = BulletState.destroy;
#endregion

#region Instant Kill Conditions
	if(collision_point(x,y,o_solid,false,true)){
		state = BulletState.death;
	}
#endregion

//Team
team = noone;

//Owner
owner = noone;

#region Movement
	movement_velocity_retention_and_acceleration_max_set(1,100);

	movement_stop_death = false;

	rotate_to_velocity_direction = true;

	// Angle offset for sprite rotation (add to velocity_dir when rotating)
	// Use 180 if sprite is drawn pointing left but should point in velocity direction
	sprite_angle_offset = 0;
#endregion

#region Homing (disabled by default, enable in child objects like o_missile)
	homing_enable = false;
	homing_turn_rate = 1.5;       // Degrees to turn per frame toward target
	homing_target = noone;        // Target instance to track
	homing_delay = 0;             // Delay before homing kicks in
#endregion

#region Bullet
	//Damage
	damage = 10;
	
	//Hit
	hit_target = noone;
	hit_target_prev = noone;
	hit_solid = false;
	
	post_hit_movement_update_enable = false;
	
	#macro BULLET_HIT_TARGET_PREV_CLEAR_ALARM_TIME 30
	
	//Alive Time
	alive_time = infinity;
	
	//Knockback Factor
	knockback_factor = 1;
#endregion

//Create
create_appear_animation_time_max = 0.1 * SECOND;
create_appear_animation_ease_script_scale = ease_quad_out;
create_appear_animation_ease_script_alpha = ease_quad_out;

//Death
death_animation_expand = false;
death_animation_expand_time_max_scale = 0.3 * SECOND;
death_animation_expand_time_max_alpha = 0.15 * SECOND;
