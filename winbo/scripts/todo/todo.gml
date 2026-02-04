/// @function todo
/// @summary Throw a debug exception to mark unfinished work.
/// @param developer Developer ID using the todo system.
/// @param message Optional message describing the task.
/// @returns {undefined} Never returns; throws an exception.
function todo(_developer,_message){
	var _throw_message;
	_throw_message = "hit a todo -- @" + o_master.developer_name[_developer];
	if(!is_undefined(_message)){
		_throw_message += " " + _message;
	}
		
	throw _throw_message;
}

#macro TODO todo

//TODO(Developer.callum,"finish the todo system");