/// @function input_gp_sprites
/// @summary Populate global gamepad button sprites.
function input_gp_sprites() {
	global.gamepad_sprite_list = ds_list_create();
	var _list = global.gamepad_sprite_list;

	//Definitions
	#region List
		_list[| gp_face1] = PS4_Cross;
		_list[| gp_face2] = PS4_Circle;
		_list[| gp_face3] = PS4_Square;
		_list[| gp_face4] = PS4_Triangle;
		_list[| gp_shoulderl] = PS4_L1;
		_list[| gp_shoulderr] = PS4_R1;
		_list[| gp_shoulderlb] = PS4_L2;
		_list[| gp_shoulderrb] = PS4_R2;
		_list[| gp_select] = noone;
		_list[| gp_start] = PS4_Options;
		_list[| gp_stickl] = PS4_Left_Stick;
		_list[| gp_stickr] = PS4_Right_Stick;
		_list[| gp_padu] = PS4_Dpad_Up;
		_list[| gp_padd] = PS4_Dpad_Down;
		_list[| gp_padl] = PS4_Dpad_Left;
		_list[| gp_padr] = PS4_Dpad_Right;
		_list[| gp_axislh] = PS4_Left_Stick;
		_list[| gp_axislv] = PS4_Left_Stick;
		_list[| gp_axisrh] = PS4_Right_Stick;
		_list[| gp_axisrv] = PS4_Right_Stick;
	#endregion
}