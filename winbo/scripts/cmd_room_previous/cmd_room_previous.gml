/// @function cmd_room_previous
/// @summary Console command to move back to the previous room if one exists.
/// @returns {void}
function cmd_room_previous(){
	if(room_previous(room) != -1){
		room_goto_previous();
		
		sdm("Went to previous room",LOG_COLOUR_COMMAND_SUCCESS);
	}
	else{
		sdm("No previous room",LOG_COLOUR_COMMAND_ERROR);
	}
}