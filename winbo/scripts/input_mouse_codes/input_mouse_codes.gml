function input_mouse_codes() {
	global.mouse_keycode_list = ds_list_create();
	var _list = global.mouse_keycode_list;

	//Definitions
	#region List
		_list[| mb_left] = "mb_left";
		_list[| mb_right] = "mb_right";
		_list[| mb_middle] = "mb_middle";
	#endregion
}