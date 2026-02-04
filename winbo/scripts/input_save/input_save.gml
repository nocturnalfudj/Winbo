function input_save() {
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
		
	//Save All App Controls
	for(var _i=0;_i<AppControl.SIZE;_i++){
		input_save_app_control(_i);
	}
	
	//Save All User Values
	for(var _i=0;_i<USER_NUM_MAX;_i++){
		with(user[_i]){
			//Game Pad Aim Assist
			input_save_user_gamepad_aim_assist();
			
			//Controls
			for(var _j=0;_j<UserControl.SIZE;_j++){
				input_save_user_control(_j);
			}
		}
	}
}