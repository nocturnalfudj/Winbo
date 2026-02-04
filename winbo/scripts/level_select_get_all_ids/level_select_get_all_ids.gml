/// @function level_select_get_all_ids
/// @summary Get an array of all registered level IDs in order.
/// @returns {array} Array of level ID strings
function level_select_get_all_ids() {
	var _count = ds_list_size(o_director.level_order);
	var _result = array_create(_count);
	
	for (var _i = 0; _i < _count; _i++) {
		_result[_i] = o_director.level_order[| _i];
	}
	
	return _result;
}
