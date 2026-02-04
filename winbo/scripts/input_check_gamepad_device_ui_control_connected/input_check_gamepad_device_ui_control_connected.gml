function input_check_gamepad_device_ui_control_connected() {
	if(global.gamepad_device_ui_control == -1)
		return false;
	else
		return true;

	/*
	var _gp_dev_ui_control;
	_gp_dev_ui_control = global.gamepad_device_ui_control;

	if(_gp_dev_ui_control == -1){
		return false;
	}
	else{
		if(o_input.gamepad[_gp_dev_ui_control][gp_dev_atr.connected])
			return true;
		else
			return false;
	}

/* end input_check_gamepad_device_ui_control_connected */
}