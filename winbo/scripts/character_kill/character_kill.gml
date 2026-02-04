/// @function character_kill
/// @summary Trigger death behavior for the controlled actor.
/// @returns {void} No return value.
function character_kill(){
	//Go to Death State
	state = death_state;
}