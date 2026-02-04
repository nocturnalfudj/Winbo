///@param argument
///@param [colour]
///@descr	Script to print something to the log and also add to the Console object with an optional colour
function sdm(_string,_log_colour) {
	//Only run if logging is enabled
	if(SDM_ENABLE){
		//Print string to actual log
		show_debug_message(_string);

		//Console hasn't been created yet – fall back to just debug message
		if (!instance_exists(o_console)) {
			return;
		}

		//Add string to Console object log
		with(o_console){
			if(is_undefined(_log_colour))
				_log_colour = c_white;
				
			//Add string to log list at the front
			ds_list_insert(log,0,_string)
		
			//Add Log Colour at the front
			ds_list_insert(log_colour,0,_log_colour);
	
			//Check if log limit has been reached
			//and delete the logs at the end if it has
			var _sz = ds_list_size(log);
			while(_sz > CONSOLE_LOG_MAX){
				ds_list_delete(log,_sz-1);
				ds_list_delete(log_colour,_sz-1);
				_sz = ds_list_size(log);
			}
		}
	}
}