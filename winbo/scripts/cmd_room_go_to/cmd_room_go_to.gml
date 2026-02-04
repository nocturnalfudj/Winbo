/// @function cmd_room_go_to
/// @summary Switch to a specified room using its asset name.
/// @param _subject Console subject (unused).
/// @param _argument_list Arguments: [roomName].
/// @returns {void} No return value.
function cmd_room_go_to(_subject,_argument_list){
	var _room;
	_room = _argument_list[| 0];
	
	var _room_asset;
	_room_asset = asset_get_index(_room);
	
	if(room_exists(_room_asset)){
		room_goto(_room_asset);
		
		sdm("Went to room " + string(_room_asset),LOG_COLOUR_COMMAND_SUCCESS);
	}
	else{
		sdm("Room not found : " + _room,LOG_COLOUR_COMMAND_ERROR);
	}
}