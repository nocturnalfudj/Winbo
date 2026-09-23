// Preserve pickup collection, hover and fade behaviour.
event_inherited();

// Animate only during play, using the actor's scaled animation clock.
if(global.game_state == GameState.play){
	image_system_update();
}
