//Job Queue List
enum JobQueue{
	http_actions = 0,
	
	SIZE
}

enum JobProperty{
	stage,
	job_queue,
	priority,
	scr,
	argument_list,
	
	SIZE
}

enum JobStage{
	idle,
	execute,
	fin,
	
	blocked
}

enum HTTPRequestJobArgument{
	endpoint,
	auth,
	body,
	request_id
}

job_queue[JobQueue.http_actions] = ds_priority_create();

job_queue_empty[JobQueue.http_actions] = true;

#region Save & Load
	#macro SAVE_FILE_JOB_QUEUE "job_queue.save"
	save_map = ds_map_secure_load(SAVE_FILE_JOB_QUEUE);
	epoch_update();
	
	bad_load = false;
	bad_load_string = "Job Queue BAD LOAD: ";
	
	//Initial Load MUST be Handled in Boot Game State
	//As HTTP Actions rely on HTTP object existing
#endregion