/// @function text_rich_rebuild_characters
/// @description Intelligently rebuild character array using diff-based algorithm to minimize allocations
function text_rich_rebuild_characters() {
	// Calculate new character positions
	var _new_positions = text_rich_calculate_character_positions();
	var _new_count = array_length(_new_positions);
	var _old_count = rich_character_count;
	
	// Determine minimum count for comparison loop
	var _min_count = min(_old_count, _new_count);
	
	// Update existing characters (reuse structs wherever possible)
	for (var _i = 0; _i < _min_count; _i++) {
		var _existing_char = rich_character[_i];
		var _new_data = _new_positions[_i];
		
		// Check if character changed
		var _char_changed = (_existing_char.char != _new_data.char);
		
		// Check if position changed (with small tolerance for float comparison)
		var _pos_changed = (abs(_existing_char.transform[TransformType.anchor].value[TransformValue.x].current - _new_data.x) > 0.01) ||
		                    (abs(_existing_char.transform[TransformType.anchor].value[TransformValue.y].current - _new_data.y) > 0.01);
		
		// Update character data if changed
		if (_char_changed) {
			_existing_char.char = _new_data.char;
			_existing_char.char_width = _new_data.width;
			_existing_char.bounding_box_width = _new_data.width;
			// Width recalculates during transform_system_update
		}
		
		// Update line and index (always, they might have changed due to wrapping)
		_existing_char.line = _new_data.line;
		_existing_char.index = _new_data.index;
		
		// Update position in transform anchor if changed
		if (_pos_changed || _char_changed) {
			with (_existing_char) {
				// Stop any ongoing animations when position or character changes
				for (var _j = 0; _j < TransformValue.SIZE; _j++) {
					with (transform[TransformType.anchor].value[_j]) {
						animating = false;
						time_current = time_max;
						target = current;
					}
				}
				transform[TransformType.anchor].animating = false;
				
				// Update position
				transform[TransformType.anchor].value[TransformValue.x].current = _new_data.x;
				transform[TransformType.anchor].value[TransformValue.x].target = _new_data.x;
				transform[TransformType.anchor].value[TransformValue.x].rest = _new_data.x;
				transform[TransformType.anchor].value[TransformValue.y].current = _new_data.y;
				transform[TransformType.anchor].value[TransformValue.y].target = _new_data.y;
				transform[TransformType.anchor].value[TransformValue.y].rest = _new_data.y;
				
				// CRITICAL: Force full transform recalculation
				// Setting transform_force_update_all ensures transform_system_update
				// recalculates x/y from the NEW transform values (including parent offset)
				transform_force_update_all = true;
				transform_updated = true;
			}
		}
	}
	
	// Handle string growth (new characters added)
	if (_new_count > _old_count) {
		for (var _i = _old_count; _i < _new_count; _i++) {
			var _new_data = _new_positions[_i];
			
			// Create new character struct (dimension_system_create called in constructor)
			var _new_char = new TextRichCharacter();
			_new_char.char = _new_data.char;
			_new_char.line = _new_data.line;
			_new_char.index = _new_data.index;
			_new_char.char_width = _new_data.width;
			_new_char.bounding_box_width = _new_data.width;  // Set after dimension_system_create
			
			// Update position AFTER constructor has set default scale values
			// The constructor already initialized image_xscale=1 and image_yscale=1
			_new_char.x = _new_data.x;
			_new_char.y = _new_data.y;
			
			// Initialize transform system for this character
			var _parent_id = id;  // Save parent reference
			with (_new_char) {
				transform_system_create(false);  // No relative transform needed
				
				// Set transform parent to the parent's TransformChild struct
				// All rich characters share transform_child[0] as their parent
				transform_parent = _parent_id.transform_child[0];
				
				// CRITICAL: Force transform update on first frame
				// New characters need this to properly calculate screen position from parent offset
				transform_force_update_all = true;
			}
			
			// Add to rich_character array
			// NOTE: We do NOT add to transform_child[] - that's only for TransformChild metadata structs
			// Characters automatically become children by setting transform_parent
			rich_character[_i] = _new_char;
		}
	}
	// Handle string shrinkage (characters removed)
	else if (_new_count < _old_count) {
		// Remove characters from the end
		// The structs will be garbage collected when we remove references
		// No need to manually destroy anything or update transform_child[]
		// since characters aren't in that array
		
		// Resize the rich_character array
		array_resize(rich_character, _new_count);
	}
	
	// Update character count
	rich_character_count = _new_count;
	
	// Reset rebuild flag
	rich_character_rebuild_required = false;
	
	// Rebuild words after characters are updated
	if (rich_word_rebuild_required) {
		text_rich_rebuild_words();
	}
	
	// Force animation check after rebuild
	rich_text_is_animating = true;
	rich_text_transforms_dirty = true;  // Also force transform update
}
