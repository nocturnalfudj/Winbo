#region Job Queue
	var _job_queue,_job_queue_sz,_job,_job_argument_lst;
	for(var _i=0;_i<JobQueue.SIZE;_i++){
		_job_queue = job_queue[_i];
		
		_job_queue_sz = ds_priority_size(_job_queue);
		
		for(var _j=0;_j<_job_queue_sz;_j++){
			_job = ds_priority_delete_min(_job_queue);
			_job_argument_lst = _job[| JobProperty.argument_list];
			
			if(ds_exists(_job_argument_lst,ds_type_list)){
				ds_list_destroy(_job_argument_lst);
			}
		}
	}
#endregion

#region Save
	var _map;
	_map = save_map;
	if(ds_exists(_map,ds_type_map)){
		ds_map_destroy(_map);
	}	
#endregion