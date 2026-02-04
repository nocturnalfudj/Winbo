#macro SERVER_URL ""

#region API
	#region URLs
		//Authentication
		api_url_auth = SERVER_URL + "/v1/auth";	
	#endregion
	
	#region Endpoints
		#region Enums
			enum Endpoint{						//Priority
				auth_login_android	= 0,		//0
				auth_login_ios		= 1,		//0
				auth_login_steam	= 2,		//0
				auth_logout			= 3,		//100
				auth_refresh_access = 4,		//-100
			
				SIZE
			}
		
			enum EndpointProperty{
				url,
				method,
				request_id,
				body_map,
				body_map_fin,
				
				job_priority,
				
				script_pass,
				
				job_save,
				
				job_num,
				
				job_num_allow_multiple,
			
				SIZE
			}
		#endregion
		
		//Regular Finished Check
		#macro HTTP_FINISH_CHECK_CD_MAX 60
		#macro HTTP_FINISH_CHECK_INDEX_INCR 10
		regular_finish_check_index_current = 0;
		alarm[0] = HTTP_FINISH_CHECK_CD_MAX;
		
		//Defaults
		for(var _i=0;_i<Endpoint.SIZE;_i++){
			api[_i][EndpointProperty.request_id] = noone;
			api[_i][EndpointProperty.body_map] = noone;
			api[_i][EndpointProperty.body_map_fin] = false;
			api[_i][EndpointProperty.job_num] = 0;
			api[_i][EndpointProperty.job_num_allow_multiple] = false;
		}
		
		#region Authentication 
			//Android Login
			api[Endpoint.auth_login_android][EndpointProperty.url] = api_url_auth;
			api[Endpoint.auth_login_android][EndpointProperty.method] = "POST";
			api[Endpoint.auth_login_android][EndpointProperty.job_priority] = 0;
			api[Endpoint.auth_login_android][EndpointProperty.job_save] = false;
			api[Endpoint.auth_login_android][EndpointProperty.script_pass] = noone;
			
			//iOS Login
			api[Endpoint.auth_login_ios][EndpointProperty.url] = api_url_auth;
			api[Endpoint.auth_login_ios][EndpointProperty.method] = "POST";
			api[Endpoint.auth_login_ios][EndpointProperty.job_priority] = 0;
			api[Endpoint.auth_login_ios][EndpointProperty.job_save] = false;
			api[Endpoint.auth_login_ios][EndpointProperty.script_pass] = noone;
			
			//Steam Login
			api[Endpoint.auth_login_steam][EndpointProperty.url] = api_url_auth;
			api[Endpoint.auth_login_steam][EndpointProperty.method] = "POST";
			api[Endpoint.auth_login_steam][EndpointProperty.job_priority] = 0;
			api[Endpoint.auth_login_steam][EndpointProperty.job_save] = false;
			api[Endpoint.auth_login_steam][EndpointProperty.script_pass] = noone;
			
			//Logout
			api[Endpoint.auth_logout][EndpointProperty.url] = api_url_auth;
			api[Endpoint.auth_logout][EndpointProperty.method] = "DELETE";
			api[Endpoint.auth_logout][EndpointProperty.job_priority] = 100;
			api[Endpoint.auth_logout][EndpointProperty.job_save] = false;
			api[Endpoint.auth_logout][EndpointProperty.script_pass] = noone;
			
			//Refresh Access
			api[Endpoint.auth_refresh_access][EndpointProperty.url] = api_url_auth;
			api[Endpoint.auth_refresh_access][EndpointProperty.method] = "PUT";
			api[Endpoint.auth_refresh_access][EndpointProperty.job_priority] = -100;
			api[Endpoint.auth_refresh_access][EndpointProperty.job_save] = false;
			api[Endpoint.auth_refresh_access][EndpointProperty.script_pass] = noone;
		#endregion
	#endregion
	
	#region Authentication
		auth_token_type = noone;
		auth_access_token = noone;
		auth_refresh_token = noone;
		auth_created_at = noone;
		auth_expires_at = noone;
	#endregion
#endregion