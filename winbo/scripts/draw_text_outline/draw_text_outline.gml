/// @function draw_text_outline
/// @summary Draw text with a simple pixel outline.
/// @param {real} _x X coordinate.
/// @param {real} _y Y coordinate.
/// @param {string} _string Text to draw.
/// @param {real} _scale_x Horizontal scale.
/// @param {real} _scale_y Vertical scale.
/// @param _colour Text color.
/// @param _outline_colour Outline color.
/// @param {real} _outline_width Outline thickness in pixels.
/// @returns {void} No return value.
function draw_text_outline(_x,_y,_string,_scale_x,_scale_y,_colour,_outline_colour,_outline_width){
	var _angle;
	_angle = 0;
	
	//Draw Outline
	draw_set_color(_outline_colour);
	draw_text_outline_background(_x,_y,_string,_scale_x,_scale_y,_outline_width);
	
	//Draw Text
	draw_set_color(_colour);
	draw_text_transformed(_x,_y,_string,_scale_x,_scale_y,_angle);
}