/// @function job_queue_execute_next
/// @summary Execute the highest priority job from a given queue.
/// @param _job_queue_id Identifier of the queue within o_job_queue
/// @returns {void} No return value.
function job_queue_execute_next(_job_queue_id) {
	var _job_queue,_job_queue_sz;
	_job_queue = o_job_queue.job_queue[_job_queue_id];
	_job_queue_sz = ds_priority_size(_job_queue);

	var _job,_job_stage,_job_script,_job_argument_lst;
	for(var _i=0;_i<_job_queue_sz;_i++){
		_job = ds_priority_find_min(_job_queue);
		_job_stage = _job[| JobProperty.stage];

		if((_job_stage == JobStage.execute) || ((_job_stage == JobStage.blocked))){
			//sdm("Job Executing OR Blocked");
			exit;
		}
		else if(_job_stage == JobStage.idle){
			if(global.network_connected){
				_job_script = _job[| JobProperty.scr];
				_job_argument_lst = _job[| JobProperty.argument_list];

				script_execute(_job_script,_job_argument_lst);

				_job[| JobProperty.stage] = JobStage.execute;

				sdm("Job Executed");
			}

			exit;
		}
		else if (_job_stage == JobStage.fin){
			sdm("Job Finished");

			job_queue_job_remove(_job_queue_id,_job);

			ds_priority_delete_min(_job_queue);
			job_queue_save_job_queue(_job_queue_id);

			if(ds_exists(_job,ds_type_list))
				ds_list_destroy(_job);


			if(_i == _job_queue_sz - 1){
				o_job_queue.job_queue_empty[_job_queue_id] = true;

				sdm("Job Queue Empty");
			}
		}
	}
}