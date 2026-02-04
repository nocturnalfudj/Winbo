function control_map_jump_edit_stop() {
	var _control;
	_control = control;
	with(user){
		input_save_user_control(_control);
	}
	
	//with(o_player){
	//	//Shoot
	//	in_shoot_key = user.control[UserControl.shoot].input[Input.keyboard][InputProperty.key];
	//}
}