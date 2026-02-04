function sldr_gamepad_aim_assist_active_main() {
	if(value_current != value_previous){
		user.gamepad_aim_assist = value_current;
	}
}