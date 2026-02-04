/// @function CommandAction
/// @summary Container for a console command entry.
/// @param {string} _string Command text typed by the user.
/// @param _script Script to run when invoked.
/// @param {real} _argument_num Expected argument count.
/// @returns {struct} New command action struct.
/// @description
///   Register a command with the console system.
/// @example
///   var c = new CommandAction("quit", game_end, 0);
function CommandAction(_string,_script,_argument_num) constructor{
	action_string = _string;
	action_script = _script;
	argument_num = _argument_num;
	
	argument_autofill[0][0] = noone;
}