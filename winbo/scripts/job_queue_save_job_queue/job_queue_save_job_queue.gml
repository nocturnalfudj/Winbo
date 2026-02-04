///@param JobQueue
function job_queue_save_job_queue(_job_queue_id) {
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
		
	var _save_str;
	var _job_queue_temp = ds_priority_create();
	var _job_queue,_job_queue_sz,_job;

	_job_queue = job_queue[_job_queue_id];
		
	_job_queue_sz = ds_priority_size(_job_queue);
		
	if(_job_queue_sz > 0){
		ds_priority_copy(_job_queue_temp,_job_queue);
		
		for(var _j=0;_j<_job_queue_sz;_j++){
			_job = ds_priority_delete_min(_job_queue_temp);
		
			_save_str = "job_queue_"+string(_job_queue_id)+"_job_"+string(_j);
			ds_map_delete(save_map,_save_str);
			ds_map_add_list(save_map,_save_str,_job);
		
			//sdm(_save_str + ": JOB SAVED");
		}
		
		_save_str = "job_queue_"+string(_job_queue_id)+"_sz";
		ds_map_delete(save_map,_save_str);
		save_map[? _save_str] = _job_queue_sz;
	}
	//sdm("");

	ds_priority_destroy(_job_queue_temp);

	ds_map_secure_save(save_map,SAVE_FILE_JOB_QUEUE);
}