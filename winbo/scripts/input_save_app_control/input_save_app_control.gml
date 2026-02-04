///@param control
function input_save_app_control(_control) {	
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
		
	save(	"app_control_" + string(_control) + "_gamepad",
			app_control[_control].input[Input.gamepad][InputProperty.key]);
	
	save(	"app_control_" + string(_control) + "_keyboard",
			app_control[_control].input[Input.keyboard][InputProperty.key]);
	
	save(	"app_control_" + string(_control) + "_mouse",
			app_control[_control].input[Input.mouse][InputProperty.key]);
	
	save(	"app_control_" + string(_control) + "_mouse_and_keyboard",
			app_control[_control].input[Input.mouse_and_keyboard][InputProperty.key]);
	
	//ds_map_secure_save(save_map,SAVE_FILE_INPUT);
	
	map_save_json(save_map,SAVE_FILE_INPUT);
}