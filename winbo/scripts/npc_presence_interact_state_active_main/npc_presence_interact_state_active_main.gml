function npc_presence_interact_state_active_main(){
	//The dialogue animation is authored facing up and right toward The Presence
	with(o_player){
		face_horizontal = 1;
	}

	//Goto Dialogue Game State
	game_state_set_target(GameState.dialogue);
}
