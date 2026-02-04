/// @function draw_text_outline_background
/// @summary Draw text multiple times to create a blocky outline effect.
/// @param _x       X coordinate
/// @param _y       Y coordinate
/// @param _string  Text to draw
/// @param _scale_x Horizontal scale
/// @param _scale_y Vertical scale
/// @param _width   Outline thickness in pixels
function draw_text_outline_background(_x,_y,_string,_scale_x,_scale_y,_width){
	var _angle;
	_angle = 0;

	draw_text_transformed(_x,_y + _width,_string,_scale_x,_scale_y,_angle);
	draw_text_transformed(_x,_y - _width,_string,_scale_x,_scale_y,_angle);

	draw_text_transformed(_x + _width,_y,_string,_scale_x,_scale_y,_angle);
	draw_text_transformed(_x + _width,_y + _width,_string,_scale_x,_scale_y,_angle);
	draw_text_transformed(_x + _width,_y - _width,_string,_scale_x,_scale_y,_angle);

	draw_text_transformed(_x - _width,_y,_string,_scale_x,_scale_y,_angle);
	draw_text_transformed(_x - _width,_y + _width,_string,_scale_x,_scale_y,_angle);
	draw_text_transformed(_x - _width,_y - _width,_string,_scale_x,_scale_y,_angle);
}