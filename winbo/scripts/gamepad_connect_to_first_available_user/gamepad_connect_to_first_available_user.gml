function gamepad_connect_to_first_available_user(_pad_index){
	var _user;
	for(var _i=0;_i<USER_NUM_MAX;_i++){
		_user = user[_i];
		if(_user.input_device == -1){
			_user.input_device = _pad_index;
			sdm("user " + string(_i) + " input device set to gamepad: " + string(_pad_index));
						
			gamepad[_pad_index].user = _user;
			sdm("gamepad " + string(_pad_index) + " user set to : " + string(_i));
						
			break;
		}	
	}
}