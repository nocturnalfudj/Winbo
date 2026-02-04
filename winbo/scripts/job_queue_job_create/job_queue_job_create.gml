function job_queue_job_create(_job_queue_id,_priority,_job_script,_job_argument_lst) {
	#region Create & Fill Job List
		var _job_list;
		_job_list = ds_list_create();

		_job_list[| JobProperty.stage] = JobStage.idle;
		_job_list[| JobProperty.job_queue] = _job_queue_id;
		_job_list[| JobProperty.priority] = _priority;
		_job_list[| JobProperty.scr] = _job_script;
		_job_list[| JobProperty.argument_list] = _job_argument_lst;
	
		ds_list_mark_as_list(_job_list,JobProperty.argument_list);
	#endregion


	with(o_job_queue){
		#region Find Job Queue & Add Job List
			var _job_queue;
			_job_queue = job_queue[_job_queue_id];

			ds_priority_add(_job_queue,_job_list,_priority);
	
	
			job_queue_empty[_job_queue_id] = false;
		#endregion
	
		job_queue_save_job_queue(_job_queue_id);
	}
}