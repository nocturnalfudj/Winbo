/// @function text_rich_draw_characters
/// @description Draw each rich character with their individual transforms
/// @param {real} _gui_scale The GUI scale to apply (1 for world space, o_ui.gui_scale for GUI space)
/// @param {real} [_offset_x] Optional X offset for surface-local drawing (default: 0)
/// @param {real} [_offset_y] Optional Y offset for surface-local drawing (default: 0)
function text_rich_draw_characters(_gui_scale, _offset_x = 0, _offset_y = 0) {
	//Default to 1 GUI Scale
	_gui_scale ??= 1;
	
	// Skip drawing if all characters are invisible
	if (!rich_text_is_visible) {
		return;
	}
	
	// Fast path: Draw entire string at once when not animating
	if (!rich_text_is_animating) {
		// Calculate base position with alignment
		var _x = x * _gui_scale + _offset_x;
		var _y = y * _gui_scale + _offset_y;
		var _scale_x = image_xscale * _gui_scale;
		var _scale_y = image_yscale * _gui_scale;
		
		// Draw entire string in one call (compatible with surface-based shadows)
		draw_text_ext_transformed_ags(
			_x, _y, 
			text_final_string, 
			sep, 
			width_actual,
			_scale_x, _scale_y, 
			image_angle, 
			image_blend, 
			image_alpha,
			alignment_h, 
			alignment_v, 
			font
		);
		return; // Skip per-character rendering
	}
	
	// Slow path: per-character rendering
	// Set font for measurements
	draw_set_font(font);
	
	// Get font height for center calculation
	var _font_height = string_height("M");
	
	// Set alignment to center/middle so rotation happens around character center
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	// Draw each character
	// NOTE: Character x/y already includes parent position from transform_system_update
	// Character positions are stored as top-left, so we offset to center for drawing
	for (var _i = 0; _i < rich_character_count; _i++) {
		var _char_struct = rich_character[_i];
		
		// Get character's transform values from struct
		var _char_x = _char_struct.x * _gui_scale + _offset_x;
		var _char_y = _char_struct.y * _gui_scale + _offset_y;
		var _char_angle = _char_struct.image_angle;
		var _char_colour = _char_struct.image_blend;
		var _char_alpha = _char_struct.image_alpha;
		var _char_scale_x = _char_struct.image_xscale * _gui_scale;
		var _char_scale_y = _char_struct.image_yscale * _gui_scale;
		var _char_text = _char_struct.char;
		
		// Calculate character dimensions (unscaled, will be scaled by draw_text_transformed)
		var _char_width_unscaled = _char_struct.char_width;
		var _char_height_unscaled = _font_height;
		
		// Calculate center point (with scale applied to offset)
		// Note: The scale is applied by draw_text_transformed AFTER positioning,
		// so we need to offset by the unscaled dimensions
		var _center_x = _char_x + (_char_width_unscaled * _gui_scale) / 2;
		var _center_y = _char_y + (_char_height_unscaled * _gui_scale) / 2;
		
		// Draw shadow if enabled
		if (shadow_enable) {
			var _shadow_x = _center_x + shadow_x * _char_scale_x;
			var _shadow_y = _center_y + shadow_y * _char_scale_y;
			draw_set_alpha(_char_alpha * shadow_alpha);
			draw_set_color(shadow_c);
			draw_text_transformed(
				_shadow_x,
				_shadow_y,
				_char_text,
				_char_scale_x,
				_char_scale_y,
				_char_angle
			);
		}
		
		// Draw character (at center point with center/middle alignment)
		draw_set_alpha(_char_alpha);
		draw_set_color(_char_colour);
		draw_text_transformed(
			_center_x,
			_center_y,
			_char_text,
			_char_scale_x,
			_char_scale_y,
			_char_angle
		);
	}
	
	// Reset draw state
	draw_set_alpha(1);
	draw_set_color(c_white);
}
