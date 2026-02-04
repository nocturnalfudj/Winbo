/// @function text_group_default_ui
/// @summary Returns a list containing default UI text strings.
function text_group_default_ui() {
	var _default;
	_default = ds_list_create();

	//0 - 9 Grid Details
	_default[| TextRow.language] = "default";
	_default[| TextRow.author] = "Author : Callum Lory";
	_default[| TextRow.version] = "Version : 2.0.0";
	_default[| TextRow.date] = "Date : 30/04/2020";
	_default[| TextRow.name] = "UI Text Sheet - Default";
	
	//10 - 19 Links
	_default[| 10] = "Privacy Policy";
	_default[| 11] = "Terms & Conditions";
	_default[| 12] = "Website";
	_default[| 13] = "Discord";
	_default[| 14] = "Twitter";
	_default[| 15] = "Instagram";
	_default[| 16] = "Facebook";
	_default[| 17] = "Reddit";
	_default[| 18] = "YouTube";
	_default[| 19] = "Steam";
	
	#region 100 Controls
		_default[| 100] = "CONSOLE";
		
		_default[| 101] = "START";
		_default[| 102] = "PAUSE";
		_default[| 103] = "PAUSE CONTINUE";
		_default[| 104] = "PAUSE STOP";
		_default[| 105] = "PAUSE MUTE MUSIC";
		_default[| 106] = "PAUSE MUTE SFX";
		
		_default[| 110] = "UP";
		_default[| 111] = "DOWN";
		_default[| 112] = "LEFT";
		_default[| 113] = "RIGHT";
		_default[| 114] = "JUMP";
		_default[| 115] = "DASH";
		_default[| 116] = "ATTACK";
		_default[| 117] = "INTERACT";
		_default[| 118] = "EQUIP";
		_default[| 119] = "FLOAT";
	#endregion

	#region 200 Main Menu
		//Play Text Button
		_default[| 200] = "PLAY";

		//Sliders
		_default[| 220] = "Resolution";
		_default[| 221] = "Master";
		_default[| 222] = "Music";
		_default[| 223] = "Sound Effects";
		_default[| 224] = "Particle Effects";
		_default[| 225] = "Anti Aliasing";
	#endregion
	
	return _default;
}
