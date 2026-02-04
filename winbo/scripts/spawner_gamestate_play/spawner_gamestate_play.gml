/// @function spawner_gamestate_play
/// @summary Update the spawner based on its current state during gameplay.
function spawner_gamestate_play(){
	//State Switch
	switch(state){
		case SpawnerState.create:
			spawner_state_create();
		break;
	
		case SpawnerState.idle:
			spawner_state_idle();
		break;
	
		case SpawnerState.spawn:
			spawner_state_spawn();
		break;
	
		case SpawnerState.destroy:
			instance_destroy();
		break;
	}
}