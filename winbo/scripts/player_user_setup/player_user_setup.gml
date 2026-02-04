function player_user_setup(_user_id){
	user_id = _user_id;
	user = o_input.user[user_id];
	user.player_instance = id;
	
	//Set to Alive
	user.alive = true;
	
	//Set HP
	hp = user.hp;
}