function player_hit(_damage){
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
	
	// Slow Game Down
	master_time_scale_effect_slow(0.2,hit_countdown.time_max);
	
	// Flash
	flash_alpha = 1;
	
	// Reset Hit Countdown
	hit_countdown.Reset();
	
	// Store Current State as Previous State to Return to After Hit
	if(state != PlayerState.hit)
		hit_state_previous = state;
	
	// Go to Hit State
	state = PlayerState.hit;
}