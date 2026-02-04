/// @function btn_level_action_active_main
/// @summary Callback for level action button - handles unlock/lock toggle or start based on action_type.
/// @returns {void}
function btn_level_action_active_main() {
	if (action_type == "unlock") {
		var _level_data = level_select_get_data(level_id);
		if (!is_undefined(_level_data)) {
			var _transform = transform[TransformType.anchor];
			var _colour;
			
			if (_level_data.unlocked) {
				level_select_lock(level_id);
				text_string = "UNLOCK: " + string_upper(_level_data.name) + " [LOCKED]";
				_colour = c_flat_red_monza;
			}
			else {
				level_select_unlock(level_id);
				text_string = "UNLOCK: " + string_upper(_level_data.name) + " [UNLOCKED]";
				_colour = c_flat_green_malachite;
			}
			
			transform_set(_transform, TransformValue.colour, _colour, false);
			transform_set_rest(_transform, TransformValue.colour, _colour, false);
		}
	}
	else if (action_type == "start") {
		if (global.game_state == GameState.pause) {
			game_unpause();
		}
		level_select_start(level_id);
	}
}
