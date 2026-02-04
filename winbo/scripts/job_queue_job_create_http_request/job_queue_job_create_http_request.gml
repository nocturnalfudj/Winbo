function job_queue_job_create_http_request(_priority,_endpoint,_auth,_body_map) {
	var _job_num,_job_num_valid,_job_save;
	_job_num = 0;
	_job_num_valid = true;
	with(o_http){
		_job_num = api[_endpoint][EndpointProperty.job_num];
		_job_save = api[_endpoint][EndpointProperty.job_save];
	
		if((api[_endpoint][EndpointProperty.job_num_allow_multiple]) || ((_job_save) || ((!_job_save) && (_job_num <= 0)))){
			_job_num_valid = true;
		
			api[_endpoint][EndpointProperty.job_num] = _job_num + 1;
		}
		else{
			_job_num_valid = false;
		}

		//if(_priority=="")
			_priority = api[_endpoint][EndpointProperty.job_priority];
	}

	if(_job_num_valid){
		var _job_argument_lst,_body;
		_job_argument_lst = ds_list_create();
		_job_argument_lst[| HTTPRequestJobArgument.endpoint] = _endpoint;
		_job_argument_lst[| HTTPRequestJobArgument.auth] = _auth;
		if(_body_map != ""){
			_body = json_encode(_body_map);
	
			ds_map_destroy(_body_map);
		}
		else{
			_body = _body_map;
		}

		_job_argument_lst[| HTTPRequestJobArgument.body] = _body;
		_job_argument_lst[| HTTPRequestJobArgument.request_id] = noone;

		job_queue_job_create(JobQueue.http_actions,_priority,job_script_http_request,_job_argument_lst);
	}
}