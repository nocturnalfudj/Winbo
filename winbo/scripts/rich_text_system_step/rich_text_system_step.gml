/// @function rich_text_system_step
/// @description Per-frame update logic for rich text character system
/// @returns {void}
function rich_text_system_step() {
	// Check if text changed - trigger rebuild if needed
	if (text_final_string != text_final_string_prev) {
		rich_character_rebuild_required = true;
		rich_word_rebuild_required = true;
		text_ui_set_width_height_pre_scale();
		calculate_dimensions = true;
	}
	
	// Handle character rebuild BEFORE transform update
	if (rich_character_rebuild_required) {
		text_rich_rebuild_characters();
	}
	
	// Process continuous effects (wave, jitter, rainbow)
	text_rich_step_continuous_effects();
	
	// Determine if character transforms need updating
	rich_text_transforms_dirty = false;
	
	// Check reasons transforms might be dirty:
	// 1. Continuous effects are active
	if (wave_enabled || jitter_enabled || rainbow_enabled) {
		rich_text_transforms_dirty = true;
	}
	
	// 2. Parent transform was updated
	if (!rich_text_transforms_dirty && transform_updated) {
		rich_text_transforms_dirty = true;
	}
	
	// 3. Check if any character has active animations
	if (!rich_text_transforms_dirty) {
		for (var _i = 0; _i < rich_character_count; _i++) {
			with (rich_character[_i]) {
				if (transform[TransformType.anchor].animating) {
					other.rich_text_transforms_dirty = true;
					break;
				}
			}
		}
	}
	
	// Only update character transforms if dirty
	if (rich_text_transforms_dirty) {
		for (var _i = 0; _i < rich_character_count; _i++) {
			with (rich_character[_i]) {
				transform_system_update();
			}
		}
	}
	
	// Update animation state flag for fast-path rendering
	// (uses same checks but for rendering decision)
	rich_text_is_animating = wave_enabled || jitter_enabled || rainbow_enabled;
	
	if (!rich_text_is_animating) {
		for (var _i = 0; _i < rich_character_count; _i++) {
			with (rich_character[_i]) {
				if (transform[TransformType.anchor].animating) {
					other.rich_text_is_animating = true;
					break;
				}
			}
		}
	}
	
	// Check if text should be visible
	// Skip drawing if all characters have alpha 0 or scale 0
	rich_text_is_visible = true;
	
	if (rich_character_count > 0) {
		var _all_invisible = true;
		
		for (var _i = 0; _i < rich_character_count; _i++) {
			var _char = rich_character[_i];
			// If any character is visible (alpha > 0 AND scale_x > 0 AND scale_y > 0), text is visible
			if (_char.image_alpha > 0 && _char.image_xscale > 0 && _char.image_yscale > 0) {
				_all_invisible = false;
				break;
			}
		}
		
		rich_text_is_visible = !_all_invisible;
	}
	
	// Detect animation completion for callbacks
	if (animation_callback_detecting) {
		// Transition from animating → not animating
		if (animation_was_animating && !rich_text_is_animating) {
			if (animation_callback != noone) {
				script_execute(animation_callback);
				animation_callback = noone;
			}
			animation_callback_detecting = false;
		}
		animation_was_animating = rich_text_is_animating;
	}
}
