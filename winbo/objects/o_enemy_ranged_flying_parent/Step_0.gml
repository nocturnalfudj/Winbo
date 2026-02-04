//Inherit Actor
event_inherited();

//Game State Switch
switch(global.game_state){
	case GameState.play:
		//Draw Adjustment
		draw_adjustment_x = 0;
		draw_adjustment_y = (global.wave_sine_1_scaled - 0.5) * 50;
	break;
}