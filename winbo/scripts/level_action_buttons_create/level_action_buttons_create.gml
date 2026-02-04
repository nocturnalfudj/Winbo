/// @function level_action_buttons_create
/// @summary Create level unlock and start buttons dynamically from registered levels.
/// @param {real} _y_start Y starting position (relative to anchor)
/// @param {string} _layer Layer name to create buttons on
/// @param {function} _create_script The create state script to use (ui_pause_create_main or ui_tab_home_create_main)
/// @param {real} _anchor_child The AnchorTransformChild to use for parenting
/// @returns {void}
function level_action_buttons_create(_y_start, _layer, _create_script, _anchor_child) {
	var _level_ids = level_select_get_all_ids();
	var _level_count = array_length(_level_ids);
	
	var _y_spacing = 80;
	var _col_spacing = 500;
	var _y = _y_start;
	var _btn;
	
	#region Unlock All Button
		_btn = instance_create_layer(-_col_spacing, _y, _layer, o_txt_btn_level_action);
		with (_btn) {
			transform_parent_anchor_child_id = _anchor_child;
			state_script[UIState.create][UIStateStage.main] = _create_script;
			level_id = "all";
			action_type = "unlock_all";
			text_string = "UNLOCK ALL";
			state_script[UIState.active][UIStateStage.main] = btn_level_unlock_all_active_main;
		}
		_y += _y_spacing;
	#endregion
	
	#region Level Buttons
		for (var _i = 0; _i < _level_count; _i++) {
			var _id = _level_ids[_i];
			var _level_data = level_select_get_data(_id);
			var _is_unlocked = _level_data.unlocked;
			var _status = _is_unlocked ? " [UNLOCKED]" : " [LOCKED]";
			var _colour = _is_unlocked ? c_flat_green_malachite : c_flat_red_monza;
			
			#region Unlock Button
				_btn = instance_create_layer(-_col_spacing, _y, _layer, o_txt_btn_level_action);
				with (_btn) {
					transform_parent_anchor_child_id = _anchor_child;
					state_script[UIState.create][UIStateStage.main] = _create_script;
					level_id = _id;
					action_type = "unlock";
					text_string = "UNLOCK: " + string_upper(_level_data.name) + _status;
					
					var _transform = transform[TransformType.anchor];
					transform_set(_transform, TransformValue.colour, _colour, false);
					transform_set_rest(_transform, TransformValue.colour, _colour, false);
				}
			#endregion
			
			#region Start Button
				_btn = instance_create_layer(_col_spacing, _y, _layer, o_txt_btn_level_action);
				with (_btn) {
					transform_parent_anchor_child_id = _anchor_child;
					state_script[UIState.create][UIStateStage.main] = _create_script;
					level_id = _id;
					action_type = "start";
					text_string = "START: " + string_upper(_level_data.name);
				}
			#endregion
			
			_y += _y_spacing;
		}
	#endregion
}
