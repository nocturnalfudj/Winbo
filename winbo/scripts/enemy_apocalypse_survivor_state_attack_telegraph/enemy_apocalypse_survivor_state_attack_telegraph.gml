function enemy_apocalypse_survivor_state_attack_telegraph(){
	// Track aim during telegraph
	character_health();
	var _delta_time = time_scale_enable ? global.delta_time_factor_scaled : global.delta_time_factor;

	target_update(TargetType.attack);
	aim_angle = point_direction(x, y, target[TargetType.attack].x, target[TargetType.attack].y);
	face_horizontal = (target[TargetType.attack].x >= x) ? 1 : -1;

	// Run telegraph countdown + transition using base behaviour
	enemy_state_attack_telegraph();
}
