///@param user
function input_check_gamepad_user_device_connected(_user) {
	with(o_input){
		if(_user < USER_NUM_MAX){
			var _device;
			_device = user[_user].input_device; 
			if((_device != -1) && (gamepad[_device].connected)){
				return _device;
			}
			else{
				return -1;
			}
		}
		else{
			return -1;
		}
	}
}