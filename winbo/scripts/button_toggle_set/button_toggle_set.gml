/// @function button_toggle_set
/// @summary Change the toggle state of a UI button and run its callback.
/// @param {bool} _toggle_state - New toggle value.
function button_toggle_set(_toggle_state){
	//Update Toggle State
	toggle = _toggle_state;
	
	//Update Sprite
	sprite_current = toggle? toggle_sprite_true : toggle_sprite_false;
	
	#region Toggle Script
		//Find the Script Matching the Toggle State
		var _toggle_script;
		if(toggle){
			_toggle_script = toggle_script_true;
		}
		else{
			_toggle_script = toggle_script_false;
		}
	
		//If Toggle Script is Valid Execute it
		if(_toggle_script != noone){
			script_execute(_toggle_script);
		}
	#endregion
}