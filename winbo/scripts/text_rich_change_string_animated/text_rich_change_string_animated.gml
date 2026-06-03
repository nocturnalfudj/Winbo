/// @function text_rich_change_string_animated
/// @description Animate text string change with fade out, change, then fade in
/// @param {string} _new_string New string to display
/// @param {real} [_fade_out_duration=0.2] Fade out duration in seconds
/// @param {real} [_fade_in_duration=0.3] Fade in duration in seconds
/// @param {real} [_delay_per_char=0.02] Character stagger delay in seconds
/// @param {real} [_delay_between=0] Delay between fade out and fade in in seconds
function text_rich_change_string_animated(_new_string, _fade_out_duration, _fade_in_duration, _delay_per_char, _delay_between) {
	_fade_out_duration ??= 0.2;
	_fade_in_duration ??= 0.3;
	_delay_per_char ??= 0.02;
	_delay_between ??= 0;
	
	// If we're already animating to this target, don't restart
	if (text_change_in_progress && text_change_target_string == _new_string) {
		return;
	}
	
	// Mark animation as in progress
	text_change_in_progress = true;
	
	// Store parameters for use in callback
	text_change_target_string = _new_string;
	text_change_fade_in_duration = _fade_in_duration;
	text_change_delay_per_char = _delay_per_char;
	
	// If there are no characters to animate (empty string), skip straight to change
	if (rich_character_count == 0 || text_string == "") {
		// Directly change the string and fade in
		text_string = _new_string;
		
		// Update the final string (prefix + text + suffix)
		text_final_string = prefix_string + text_string + suffix_string;
		
		// Force character rebuild before animating
		rich_character_rebuild_required = true;
		text_rich_rebuild_characters();
		
		// Now we can safely fade in
		text_rich_fade_in(_delay_per_char, _fade_in_duration, 0);
		
		// Set up callback to clear the in-progress flag when fade in completes
		text_rich_animation_callback_setup(method(id, function() {
			text_change_in_progress = false;
		}));
		return;
	}
	
	// Calculate fade out delay per char (reverse order for fade out)
	var _fade_out_delay = _delay_per_char;
	
	// Stop any existing animations
	text_rich_stop_animations();
	
	// Start fade out animation (reverse order for more natural exit)
	text_rich_fade_out(_fade_out_delay, _fade_out_duration, 0);
	
	// Set up callback to handle string change and fade in
	text_rich_animation_callback_setup(method(id, function() {
		// Change the text string
		text_string = text_change_target_string;
		
		// Update the final string (prefix + text + suffix)
		text_final_string = prefix_string + text_string + suffix_string;
		
		// Force character rebuild before animating
		rich_character_rebuild_required = true;
		text_rich_rebuild_characters();
		
		// Start fade in animation after string change and rebuild
		text_rich_fade_in(text_change_delay_per_char, text_change_fade_in_duration, 0);
		
		// Set up another callback to clear the in-progress flag when fade in completes
		text_rich_animation_callback_setup(method(id, function() {
			text_change_in_progress = false;
		}));
	}));
}
