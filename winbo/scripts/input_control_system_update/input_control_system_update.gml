function input_control_system_update(){
	//Input Previous Values
	for(var _i=0;_i<UserControl.SIZE;_i++){
		input_previous[_i] = input_current[_i];
	}
}