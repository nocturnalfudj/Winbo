// Begin Step keeps the rendered body and its collision ellipse together
// before player_collisions runs, regardless of instance creation order.
if(global.game_state != GameState.play){
	exit;
}
motion_time += global.delta_time_factor_scaled;
x = anchor_x + sin(motion_time * 2 * pi / sway_period) * sway_distance;
y = anchor_y + sin(motion_time * 2 * pi / bob_period) * bob_distance;
