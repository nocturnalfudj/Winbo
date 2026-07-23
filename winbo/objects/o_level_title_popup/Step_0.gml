if(global.game_state != GameState.play) exit;

var _dt = min(global.delta_time,0.05) * o_master.time_scale * o_master.time_effect_scale;

if(title_delay_countdown > 0) {
	title_delay_countdown = max(0,title_delay_countdown - _dt);
	exit;
}

title_frame += title_fps * _dt;
if(title_frame >= title_frame_count) {
	instance_destroy();
}
