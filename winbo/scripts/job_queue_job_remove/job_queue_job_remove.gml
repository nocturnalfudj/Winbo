/// @function job_queue_job_remove
/// @summary Delete a job entry from a persistent queue.
/// @param _job_queue_id Identifier of the queue.
/// @param _job_remove Value identifying the job to remove.
/// @returns {void} No return value.
function job_queue_job_remove(_job_queue_id,_job_remove) {
	var _save_str;
	var _job_queue,_job_queue_sz,_job;
	_job_queue = job_queue[_job_queue_id];
	_save_str = "job_queue_"+string(_job_queue_id)+"_sz";
	_job_queue_sz = save_map[? _save_str];
		
	var _removed;
	_removed = false;
	if(_job_queue_sz > 0){
		for(var _i=0;_i<_job_queue_sz;_i++){
			_save_str = "job_queue_"+string(_job_queue_id)+"_job_"+string(_i);
			_job = save_map[? _save_str];
		
			if(_job == _job_remove){
				ds_map_delete(save_map,_save_str);
			
				sdm(_save_str + ": JOB REMOVED");
			
				_removed = true;
			}
		}
		
		_save_str = "job_queue_"+string(_job_queue_id)+"_sz";
		ds_map_delete(save_map,_save_str);
		if(_removed){
			_job_queue_sz -= 1;
		}
		save_map[? _save_str] = _job_queue_sz;
	}
	ds_map_secure_save(save_map,SAVE_FILE_JOB_QUEUE);
}