/// @function director_spawn_player_all_joined
/// @summary Spawn player instances for all joined users.
function director_spawn_player_all_joined(){
	//If Player Doesn't Exist
	if(instance_number(o_player) == 0){
		#region Spawn Player/s
			var _users,_user,_player_instance;
			_users = o_input.user;
		
			for(var _i=0;_i<USER_NUM_MAX;_i++){
				_user = _users[_i];
				
				//sdm("user " + string(_i) + " joined: " + string(_user.joined));
			
				if(_user.joined){
					//_user.alive = true;
					
					_player_instance = director_spawn_player(_user);
				}
			}
		#endregion
	}
}