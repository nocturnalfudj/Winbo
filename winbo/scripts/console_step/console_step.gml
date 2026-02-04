/// @function console_step
/// @summary Update the developer console each step based on its current state.
function console_step() {
	//State Switch
	switch(state){
		case ConsoleState.create:
			console_state_create();
		break;
	
		case ConsoleState.idle:
			console_state_idle();
		break;
	
		case ConsoleState.active:
			console_state_active();
		break;
	}

	//Transform Update
	transform_system_update();
}