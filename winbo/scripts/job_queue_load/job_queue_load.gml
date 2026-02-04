function job_queue_load() {
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
		
	var _save_str;
	var _job_queue,_job_queue_sz,_job,_priority,_script,_arg_lst;
	var _endpoint
	for(var _i=0;_i<JobQueue.SIZE;_i++){
		_job_queue = job_queue[_i];
		
		_save_str = "job_queue_"+string(_i)+"_sz";
		_job_queue_sz = save_map[? _save_str];
	
		sdm(_save_str + ": " + string(_job_queue_sz));
		
		if(_job_queue_sz > 0){
		
			for(var _j=0;_j<_job_queue_sz;_j++){
				_save_str = "job_queue_"+string(_i)+"_job_"+string(_j);
			
				_job = ds_map_find_value(save_map,_save_str);
			
				if((_job != undefined) && (ds_exists(_job,ds_type_list))){
					_arg_lst = _job[| JobProperty.argument_list];			
					_endpoint = _arg_lst[| HTTPRequestJobArgument.endpoint];
			
					if(o_http.api[_endpoint][EndpointProperty.job_save]){
						//sdm(_save_str + ": JOB LOADED");
				
						_priority = _job[| JobProperty.priority];
						_script = _job[| JobProperty.scr];
				
						job_queue_job_create(_i,_priority,job_script_http_request,_arg_lst);
					}
			
					//sdm(_save_str + " stage: " + string(_job[| JobProperty.stage]));
					//sdm(_save_str + " job_queue: " + string(_job[| JobProperty.job_queue]));
					//sdm(_save_str + " priority: " + string(_job[| JobProperty.priority]));
					//sdm(_save_str + " script: " + string(_job[| JobProperty.scr]));
					//sdm(_save_str + " arg_lst: " + string(_job[| JobProperty.argument_list]));	
				}
			}
		}
		//sdm("");
	}
	//sdm("");
}