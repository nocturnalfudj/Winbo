function cmd_room_next(){
	if(room_next(room) != -1){
		room_goto_next();
		
		sdm("Went to next room",LOG_COLOUR_COMMAND_SUCCESS);
	}
	else{
		sdm("No next room",LOG_COLOUR_COMMAND_ERROR);
	}
}