/// @function rich_text_system_create
/// @description Initialize the rich text character system for an object
/// @returns {void}
function rich_text_system_create() {
	// Transform child slot for rich characters
	// All rich character structs will point to transform_child[0]
	transform_system_new_transform_child();
	
	#region Rich Character System
		rich_character = [];              // Array of TextRichCharacter structs
		rich_character_count = 0;
		rich_character_rebuild_required = true;  // Trigger initial build
	#endregion
	
	#region Rich Word System
		rich_word = [];                   // Array of TextRichWord structs
		rich_word_count = 0;
		rich_word_rebuild_required = true;  // Trigger initial build
	#endregion
	
	#region Rich Animation State
		// Wave effect
		wave_enabled = false;
		wave_amplitude = 20;
		wave_offset_per_char = 0.3;  // Time offset between characters
		
		// Jitter effect
		jitter_enabled = false;
		jitter_intensity = 2;
		jitter_speed = 0.1;
		
		// Rainbow effect
		rainbow_enabled = false;
		rainbow_cycle_duration = 180;  // Duration in steps (SECOND = 60, so 180 = 3 seconds)
		rainbow_offset_per_char = 30;  // Hue offset between characters (degrees)
	#endregion
	
	#region Rich Animation Tracking
		// Track if ANY character is currently animating (for fast-path rendering)
		rich_text_is_animating = false;

		// Keep static and animated rich text on the same layout path.
		rich_text_force_character_draw = true;
		
		// Track if text should be drawn (false if all characters are invisible)
		rich_text_is_visible = true;
		
		// Track if character transforms need updating this frame
		rich_text_transforms_dirty = false;
	#endregion
	
	#region Rich Animation Callbacks
		// Callback system for detecting animation completion
		animation_callback = noone;           // Script to call when animations complete
		animation_callback_detecting = false; // Whether to check for completion
		animation_was_animating = false;      // Track previous frame state
		
		// String change animation state
		text_change_in_progress = false;      // Flag to prevent restarting animations
		text_change_target_string = "";       // Target string for animated changes
		text_change_fade_in_duration = 0.3;   // Fade in duration for string change
		text_change_delay_per_char = 0.02;    // Character stagger for fade in
	#endregion
}
