/// @function User
/// @summary Create a user record used by multiplayer systems.
/// @param {real} _user_id    Unique numeric id for this user.
/// @param {string} _name      Display name.
/// @param {bool} _joined      If true the user has joined the lobby.
/// @param _input             Input mapping or controller reference.
/// @param _input_device      Device index or constant for input.
/// @description
///   Constructs a struct representing a player and initialises
///   default control values and lobby state.
/// @returns {struct} User struct.
function User(_user_id,_name,_joined,_input,_input_device) constructor{
	user_id = _user_id;
	name = _name;
	joined = _joined;
	input = _input;
	input_device = _input_device;
	player_instance = noone;
	team = Team.player;
	
	gamepad_aim_assist = 0.8;
	
	//Initialise Control Array
	for(var _i=0;_i<UserControl.SIZE;_i++){
		control[_i] = noone;
	}
	
	//Create Input Control System
	input_control_system_create();
	
	//Lobby
	spawned = false;
	ready = false;
	
	//Game
	alive = false;
	hp = PLAYER_HP_MAX_DEFAULT;
	hp_vulnerable = true;
}