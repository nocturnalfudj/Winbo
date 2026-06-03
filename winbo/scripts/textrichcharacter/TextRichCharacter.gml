/// @function TextRichCharacter
/// @description Constructor for a single rich text character with its own transform system
/// @returns {struct} TextRichCharacter instance
function TextRichCharacter() constructor {
	// Character data
	char = "";
	line = 0;
	index = 0;
	char_width = 0;
	
	// Position and transform properties
	// CRITICAL: These MUST exist before transform_system_create is called
	x = 0;
	y = 0;
	image_xscale = 1;
	image_yscale = 1;
	image_alpha = 1;
	image_angle = 0;
	image_blend = c_white;
	
	// Dimension system (required by transform_system_update)
	dimension_system_create();
}
