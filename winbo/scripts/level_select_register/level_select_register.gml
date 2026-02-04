/// @function level_select_register
/// @summary Register a level with the level select system.
/// @param {string} _id Unique level identifier
/// @param {asset.GMRoom} _level_room Room asset
/// @param {string} _name Display name
/// @param {real} _order Order in sequence
/// @returns {void}
function level_select_register(_id, _level_room, _name, _order) {
	// Create and store level data
	var _level_data = new LevelData(_id, _level_room, _name, _order);
	ds_map_add(o_director.level_registry, _id, _level_data);
	ds_list_add(o_director.level_order, _id);
	
	// Get the index for this level (0-based, since we just added it)
	var _level_index = ds_list_size(o_director.level_order) - 1;
	
	// Add to console autofill for level commands
	var _action_list = o_console.command_subject[CMDSubject.game].action_list;
	var _action_count = ds_list_size(_action_list);
	
	for (var _i = 0; _i < _action_count; _i++) {
		var _action = _action_list[| _i];
		
		// Add to level_start autofill (starts at index 0)
		if (_action.action_string == "level_start") {
			_action.argument_autofill[0][_level_index] = _id;
		}
		
		// Add to level_unlock autofill (starts at index 1, after "all")
		if (_action.action_string == "level_unlock") {
			_action.argument_autofill[0][_level_index + 1] = _id;
		}
	}
}
