var _id,_status,_status_code,_script,_fail,_job_stage_new,_endpoint;
_id = async_load[? "id"];
_status = async_load[? "status"];
_status_code = async_load[? "http_status"];

sdm("");

if(_status == 1){
	sdm("HTTP Request Downloading: id - " + string(_id));
}
else{
	_job_stage_new = JobStage.execute;
	
	
	#region Fail Check
		_fail = noone;
		if(_status < 0){
			_fail = true;
		}
		else if(_status == 0){
			_fail = false;
		}
	#endregion
	
	if(_fail != noone){
		#region Get Endpoint
			_endpoint = noone;
			for(var _i=0;_i<Endpoint.SIZE;_i++){
				if(_id == api[_i][EndpointProperty.request_id]){
					_endpoint = _i;
					break;
				}
			}
		#endregion
		
		if(_endpoint != noone){
			if(_fail){
				#region Request Failed
					var _url;
					_url = api[_endpoint][EndpointProperty.url];
					
					http_request_sdm_fail(_url);
					
					_job_stage_new = JobStage.idle;
				#endregion
			}
			else{
				#region Request Successful
					var _result;
					_result = async_load[? "result"];
					sdm("HTTP result: " + string(_result));
					
					switch(_status_code){
						case 200:
						case 201:
						case 202:
						case 203:
						case 204:
						case 205:
						case 206:
						case 207:
						case 208:
						case 226:
							#region Pass
								var _body_map;
								_body_map = json_decode(_result);
								//var _old_map;
								//_old_map = api[_endpoint][EndpointProperty.body_map];
								//if(!is_undefined(_old_map) && (_old_map != noone)){
								//	if(ds_exists(_old_map,ds_type_map))
								//		ds_map_destroy(_old_map);
								//}
								api[_endpoint][EndpointProperty.body_map] = _body_map;
					
								_script = api[_endpoint][EndpointProperty.script_pass];
								script_execute(_script,_body_map);
						
								_job_stage_new = JobStage.fin;
							#endregion
						break;
							
						case 400:
							break;
							
						case 401:
							#region Refresh Access / Sign In Again
								if(_endpoint == Endpoint.auth_refresh_access){
									//NEED TO SIGN IN
								
									_job_stage_new = JobStage.blocked;
								}
								else{	
									job_queue_job_create_http_request(-1,Endpoint.auth_refresh_access,true,"");
								
									sdm("HTTP Request Status Code 401 - Refresh Access Requested");
								
									_job_stage_new = JobStage.idle;
								}
							#endregion
						break;
						
						case 429:
							#region Pass
								sdm("HTTP Request Status Code 429 - Too Many Requests");
						
								_job_stage_new = JobStage.blocked;
							#endregion
						break;
						
						case 500:
						break;
						
						default:
							sdm("HTTP Request Status Code Unassigned");
							_job_stage_new = JobStage.blocked;
						break;
					}
				#endregion
			}
		}
		else{
			sdm("HTTP Request No Endpoint Match");
		}
	}
	else{
		#region Reuqest Invalid
			sdm("HTTP Request Invalid: id - " + string(_id) + ", status - " + string(_status));
			_job_stage_new = JobStage.blocked;
		#endregion
	}
	
	#region Update Job Stage
		with(o_job_queue){
			var _job_queue,_job_queue_sz;
			_job_queue = job_queue[JobQueue.http_actions];
			_job_queue_sz = ds_priority_size(_job_queue);
			
			var _job_queue_temp = ds_priority_create();
			
			if(_job_queue_sz > 0){
				ds_priority_copy(_job_queue_temp,_job_queue);
				
				var _job,_job_stage,_job_argument_lst;
				for(var _i=0;_i<_job_queue_sz;_i++){
					_job = ds_priority_delete_min(_job_queue_temp);
					_job_stage = _job[| JobProperty.stage];
	
					if(_job_stage == JobStage.execute){
						_job_argument_lst = _job[| JobProperty.argument_list];
									
						if(_job_argument_lst[| HTTPRequestJobArgument.request_id] == _id){
							_job[| JobProperty.stage] = _job_stage_new;
							
							#region Handle New Stages
								switch(_job_stage_new){
									case JobStage.blocked:
										sdm("Job stage blocked");
									break;
								
									case JobStage.idle:
										sdm("Job failed, stage return to idle");
									break;
								
									case JobStage.fin:
										o_http.api[_endpoint][EndpointProperty.job_num] -= 1;
									break;
								}
							#endregion
						
							break;
						}	
					}
				}
			
			}
			ds_priority_destroy(_job_queue_temp);
		}
	#endregion
}

sdm("");