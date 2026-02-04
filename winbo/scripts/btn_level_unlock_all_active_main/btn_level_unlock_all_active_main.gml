/// @function btn_level_unlock_all_active_main
/// @summary Callback for unlock all button - unlocks all levels and updates button texts/colors.
/// @returns {void}
function btn_level_unlock_all_active_main() {
	level_select_unlock_all();
	
	with (o_txt_btn_level_action) {
		if (action_type == "unlock") {
			var _level_data = level_select_get_data(level_id);
			if (!is_undefined(_level_data)) {
				text_string = "UNLOCK: " + string_upper(_level_data.name) + " [UNLOCKED]";
				
				var _transform = transform[TransformType.anchor];
				var _colour = c_flat_green_malachite;
				transform_set(_transform, TransformValue.colour, _colour, false);
				transform_set_rest(_transform, TransformValue.colour, _colour, false);
			}
		}
	}
}
