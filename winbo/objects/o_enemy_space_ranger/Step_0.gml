// NOTE: We intentionally do NOT call event_inherited() here because:
// 1. enemy_space_ranger_gamestate_play() handles all state logic, movement, image, and transform updates
// 2. Calling event_inherited() would run enemy_gamestate_play() FIRST, causing double execution
//    of attack states and double countdown decrements
// Instead, we manually apply the floating effect from o_enemy_ranged_flying_parent:
if (global.game_state == GameState.play) {
	draw_adjustment_x = 0;
	draw_adjustment_y = (global.wave_sine_1_scaled - 0.5) * 50;
}

// MCP Debug Logging (every 2 seconds)
if (!variable_instance_exists(id, "debug_log_timer")) {
	debug_log_timer = 0;
	debug_log_interval = SECOND * 2;
}
debug_log_timer -= 1;
if (debug_log_timer <= 0) {
	debug_log_timer = debug_log_interval;
	
	var _st_name = "";
	switch(state) {
		case EnemyState.create: _st_name = "create"; break;
		case EnemyState.idle: _st_name = "idle"; break;
		case EnemyState.move: _st_name = "move"; break;
		case EnemyState.attack_telegraph: _st_name = "telegraph"; break;
		case EnemyState.attack_active: _st_name = "active"; break;
		case EnemyState.attack_recover: _st_name = "recover"; break;
		default: _st_name = string(state); break;
	}
	
	var _log = "[SR] st=" + _st_name;
	_log += " tel_cd=" + string(round(attack_telegraph_countdown));
	_log += " act_cd=" + string(round(attack_active_countdown));
	_log += " rec_cd=" + string(round(attack_recover_countdown));
	_log += " atk_cd=" + string(round(attack_countdown));
	_log += " created=" + string(attack_active_attack_created);
	
	if (state == EnemyState.attack_active || state == EnemyState.attack_recover) {
		_log += " frm=" + string(sprite_current_frame) + "/" + string(image.sprite_number);
	}
	
	__mcp_log(_log);
}

// Game State Switch - Using Space Ranger specific gamestate
switch(global.game_state){
	case GameState.play:
		enemy_space_ranger_gamestate_play();

		// Interact System
		interact_system_update();
	break;

	case GameState.gameover:
		enemy_gamestate_gameover();
	break;

	case GameState.stop:
	case GameState.menu:
		enemy_gamestate_stop_game();
	break;
}
