/// @function job_queue_save
/// @summary Save all job queues to disk.
/// @returns {real} -1 if not supported, otherwise 0.
function job_queue_save() {
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
		
	for(var _i=0;_i<JobQueue.SIZE;_i++){
		job_queue_save_job_queue(_i);
	}
}