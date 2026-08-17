function player_hit(_damage, _source = noone, _slash = false){
	_damage ??= 1;

	// Ignore hits if we're already reacting or dying (prevents hit-spam loops)
	if (state == PlayerState.hit || state == PlayerState.death || state == PlayerState.destroy) {
		exit;
	}

	// Ignore if invincible
	if (status_effect_active_count[StatusEffect.invincible] > 0) exit;
	if (status_effect_active_count[StatusEffect.invincible_dash] > 0) exit;

	// Apply damage
	hp -= _damage;
	user.hp = hp;

	// Track hit taken
	level_stat_add(LevelStat.hits_taken);
	
	// LETHAL HIT: Go straight to death, do NOT trigger play_player_hit (global freeze)
	if (hp <= 0) {
		character_kill();
		exit;
	}

	// Damage Animation
	image_system_setup(choose(sprite_take_damage_0,sprite_take_damage_1),ANIMATION_FPS_DEFAULT,false,false,0,IMAGE_LOOP_FULL);

	var _hit_direction;
	_hit_direction = 90;
	if(_source != noone){
		_hit_direction = point_direction(_source.x, _source.y, x, y);
	}

	var _hit_sprite;
	_hit_sprite = _slash ? spr_fx_hit_slash : spr_fx_hit_impact;
	fx_spawn_sprite_once(x, y, "lyr_pfx_foreground", _hit_sprite, 1, 1, _hit_direction, 24);

	part_type_direction(o_pfx.pfx_type_player_damage_spark, _hit_direction - 22, _hit_direction + 22, 0, 12);
	part_particles_create(o_pfx.part_system_foreground, x, y, o_pfx.pfx_type_player_damage_spark, irandom_range(6, 10));
	camera_shake_add(0.18, 450, 12, 4, false, false, true, 0.8, , false, 100, 0.6);
	with(o_fade_hud_damage){
		fade_factor = fade_factor_target_active;
	}
	
	// Slow Game Down
	master_time_scale_effect_slow(0.2,hit_countdown.time_max);
	
	// Flash
	flash_alpha = 0.8;
	
	// Reset Hit Countdown
	hit_countdown.Reset();
	
	// Store Current State as Previous State to Return to After Hit
	if(state == PlayerState.dive_spring){
		player_dive_spring_reset();
		hit_state_previous = PlayerState.move;
	}
	else if(state != PlayerState.hit){
		hit_state_previous = state;
	}
	
	// Go to Hit State
	state = PlayerState.hit;
}
