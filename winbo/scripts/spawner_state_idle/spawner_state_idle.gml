function spawner_state_idle(){
	//Only Check on Certain Tick
	//Tick is chosen in Create Event
	//Or Always Run if Check Tick not Enabled
	if((spawn_check_tick_enable == false) || (global.tick_now == spawn_check_tick)){
		//Default Spawn pass to fail
		var _spawn_pass;
		_spawn_pass = false;
		
		if(spawn_check_condition_script != noone)
			_spawn_pass = script_execute(spawn_check_condition_script);
	
		//If Spawn Pass passes
		//Go to local state spawn
		if(_spawn_pass){
			state = SpawnerState.spawn;
		}
	}
}