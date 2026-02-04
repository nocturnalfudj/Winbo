/// @function btn_stop_advert_active_main
/// @summary Skip any active adverts and resume the game.
function btn_stop_advert_active_main() {
	//Trigger Master Advert Alarm Next Step
	with(o_master){
		advert_force_exit_countdown.SetTime(1);
	}
}