/// @function player_state_create
/// @summary Initialize the player instance and default state.
function player_state_create(){
	//Grow & Appear
	transform_animate_grow_and_appear();
	
	//State to Idle
	state = PlayerState.idle;
}
