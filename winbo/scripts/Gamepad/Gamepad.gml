/// @function Gamepad
/// @summary Rumble controller data for a player.
/// @description
///   Holds left and right rumble intensities that are processed
///   each step by the input controller.
/// @returns {struct} New Gamepad rumble data object.
/// @example
///   var pad = new Gamepad();
function Gamepad() constructor{
	connected = noone;
	user = noone;
	
	rumble_left = new TransValue(0);
	rumble_right = new TransValue(0);
}