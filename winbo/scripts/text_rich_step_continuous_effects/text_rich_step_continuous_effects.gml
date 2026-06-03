/// @function text_rich_step_continuous_effects
/// @description Process continuous animation effects (wave, jitter, rainbow) each step
function text_rich_step_continuous_effects() {
	var _delta = global.delta_time_factor;
	
	// Wave effect
	if (wave_enabled) {
		// Get base time like master waves do
		var _time_base = o_master.current_time_scaled / 10;
		
		for (var _i = 0; _i < rich_character_count; _i++) {
			var _char_struct = rich_character[_i];
			
			// Each character has a time offset to create the wave propagation
			var _char_time = _time_base + (_i * wave_offset_per_char);
			
			// Use wave_ags to calculate proper sine wave (same as master waves)
			// Creates wave from -1 to 1 for proper oscillation around center
			var _wave_value = wave_ags(-1, 1, 0.3, _char_time);
			var _wave_offset = _wave_value * wave_amplitude;
			
			with (_char_struct) {
				var _base_y = transform[TransformType.anchor].value[TransformValue.y].rest;
				var _target_y = _base_y + _wave_offset;
				
				// Lerp for smooth transition (prevents snapping when enabled)
				var _current_y = transform[TransformType.anchor].value[TransformValue.y].current;
				var _lerped_y = lerp(_current_y, _target_y, 0.2);
				
				transform_set(transform[TransformType.anchor], TransformValue.y, _lerped_y, false);
			}
		}
	}
	
	// Jitter effect
	if (jitter_enabled) {
		for (var _i = 0; _i < rich_character_count; _i++) {
			var _char_struct = rich_character[_i];
			
			// Random jitter with controlled speed
			if (random(1) < jitter_speed) {
				var _jitter_x = random_range(-jitter_intensity, jitter_intensity);
				var _jitter_y = random_range(-jitter_intensity, jitter_intensity);
				
				with (_char_struct) {
					var _base_x = transform[TransformType.anchor].value[TransformValue.x].rest;
					var _base_y = transform[TransformType.anchor].value[TransformValue.y].rest;
					
					var _target_x = _base_x + _jitter_x;
					var _target_y = _base_y + _jitter_y;
					
					// Set directly (no lerp) - jitter_speed controls update frequency
					transform_set(transform[TransformType.anchor], TransformValue.x, _target_x, false);
					transform_set(transform[TransformType.anchor], TransformValue.y, _target_y, false);
				}
			}
		}
	}
	
	// Rainbow effect
	if (rainbow_enabled) {
		// Use current_time_scaled like master waves (milliseconds / 10 for smooth cycling)
		var _time = o_master.current_time_scaled / 10;
		
		// Calculate hue based on time with proper cycling
		var _base_hue = (_time / rainbow_cycle_duration) * 360;
		_base_hue = _base_hue mod 360;
		
		for (var _i = 0; _i < rich_character_count; _i++) {
			var _char_struct = rich_character[_i];
			
			// Calculate hue for this character
			var _char_hue = (_base_hue + (_i * rainbow_offset_per_char)) mod 360;
			
			// Convert HSV to RGB (saturation = 1, value = 1)
			var _color = make_color_hsv(_char_hue, 255, 255);
			
			// Apply color
			with (_char_struct) {
				transform_set(transform[TransformType.anchor], TransformValue.colour, _color, false);
			}
		}
	}
}
