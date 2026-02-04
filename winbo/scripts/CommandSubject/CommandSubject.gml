/// @function CommandSubject
/// @summary Container that holds command actions with a prefix.
/// @param {string} _prefix Prefix prepended to command strings.
/// @description
///   Used by the console to register command actions.
/// @returns {struct} New command subject struct.
/// @example
///   var subject = new CommandSubject("debug");
function CommandSubject(_prefix) constructor{
	prefix = _prefix;
	
	action_list = ds_list_create();
	action_num = 0;
}