/// @function input_mouse_sprites
/// @summary Create sprite lookup table for mouse buttons.
/// @returns {void}
function input_mouse_sprites() {
	global.mouse_sprite_list = ds_list_create();
	var _list = global.mouse_sprite_list;

	//Definitions
	#region List
		_list[| mb_left] = Keyboard_Black_Mouse_Left;
		_list[| mb_right] = Keyboard_Black_Mouse_Right;
		_list[| mb_middle] = Keyboard_Black_Mouse_Middle;
	#endregion
}
