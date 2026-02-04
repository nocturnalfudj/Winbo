/// @function tabBtn_create_main
/// @summary Initialize a tab button with the tab sprite and dimensions.
/// @returns {void} No return value.
function tabBtn_create_main(){
	#region Image
		var _sprite;
		_sprite = noone;
		
		with(tab){
			_sprite = sprite;
		}
		
		sprite_index = _sprite;
		sprite_current = _sprite;
		toggle_sprite_true = sprite_current;
		toggle_sprite_false = sprite_current;
	#endregion
	
	//Dimensions
	dimensions_system_update(sprite_current);
}