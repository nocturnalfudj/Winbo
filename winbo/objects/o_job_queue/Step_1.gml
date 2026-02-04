#region GameState Switch
	switch(global.game_state){
		case GameState.boot:
			//Save / Load
			if(save_map == -1){
				save_map = ds_map_create();
		
				job_queue_save();
			}
			else{
				job_queue_load();
			}
		break;
	}
#endregion

#region Job Queue
	if(global.tick_now){
		if((!job_queue_empty[JobQueue.http_actions]) && (global.network_connected)){
			job_queue_execute_next(JobQueue.http_actions);
		}
	}
#endregion