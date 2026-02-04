function input_gp_codes() {
	global.gamepad_keycode_list = ds_list_create();
	var _list = global.gamepad_keycode_list;

	//Definitions
	#region List
		_list[| gp_face1] = "gp_face1 /X";
		_list[| gp_face2] = "gp_face2 B/O";
		_list[| gp_face3] = "gp_face3 X/[]";
		_list[| gp_face4] = "gp_face4 Y//\\";
		_list[| gp_shoulderl] = "gp_shoulderl";
		_list[| gp_shoulderr] = "gp_shoulderr";
		_list[| gp_shoulderlb] = "gp_shoulderlb";
		_list[| gp_shoulderrb] = "gp_shoulderrb";
		_list[| gp_select] = "gp_select";
		_list[| gp_start] = "gp_start";
		_list[| gp_stickl] = "gp_stickl";
		_list[| gp_stickr] = "gp_stickr";
		_list[| gp_padu] = "gp_padu";
		_list[| gp_padd] = "gp_padd";
		_list[| gp_padl] = "gp_padl";
		_list[| gp_padr] = "gp_padr";
		_list[| gp_axislh] = "gp_axislh";
		_list[| gp_axislv] = "gp_axislv";
		_list[| gp_axisrh] = "gp_axisrh";
		_list[| gp_axisrv] = "gp_axisrv";
	#endregion
}