/// @function level_select_unlock_all
/// @summary Unlock all levels.
/// @returns {void}
function level_select_unlock_all() {
	var _key = ds_map_find_first(o_director.level_registry);
	while (!is_undefined(_key)) {
		var _level_data = o_director.level_registry[? _key];
		_level_data.unlocked = true;
		_key = ds_map_find_next(o_director.level_registry, _key);
	}
	sdm("All levels unlocked", LOG_COLOUR_COMMAND_SUCCESS);
}
