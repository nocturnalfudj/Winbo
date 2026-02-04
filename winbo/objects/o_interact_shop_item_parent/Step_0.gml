// Inherit the parent event
event_inherited();

//Game State Switch
switch(global.game_state){
	case GameState.play:
		//Lerp Cost Title to Target
		cost_title_x = lerp_with_gap_close(cost_title_x,cost_title_x_target,0.2,0.1,false);
		cost_title_y = lerp_with_gap_close(cost_title_y,cost_title_y_target,0.2,0.1,false);
	break;
}