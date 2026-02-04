/// @function draw_surface_general_ags
/// @summary Draw a portion of a surface with optional scaling and rotation.
/// @param _surf_id Surface ID to draw from.
/// @param _left Source X offset.
/// @param _top Source Y offset.
/// @param _width Width of the region.
/// @param _height Height of the region.
/// @param _x Destination X position.
/// @param _y Destination Y position.
/// @param _scale_x Horizontal scale.
/// @param _scale_y Vertical scale.
/// @param _angle Rotation angle in degrees.
/// @param _colour_1 Top-left vertex color.
/// @param _colour_2 Top-right vertex color.
/// @param _colour_3 Bottom-right vertex color.
/// @param _colour_4 Bottom-left vertex color.
/// @param _alpha Overall alpha to apply.
function draw_surface_general_ags(_surf_id,_left,_top,_width,_height,_x,_y,_scale_x,_scale_y,_angle,_colour_1,_colour_2,_colour_3,_colour_4,_alpha) {
	if((_alpha > 0) && (surface_exists(_surf_id)) && (_width > 0) && (_height > 0) && (_scale_x != 0) && (_scale_y != 0) && (_left >= 0) && (_top >= 0)){
		if((_angle == 0) && (_colour_1 == _colour_2) && (_colour_1 == _colour_3) && (_colour_1 == _colour_4)){
			if(_colour_1 == c_white){
				draw_surface_part(_surf_id,_left,_top,_width,_height,_x,_y);
			}
			else{
				draw_surface_part_ext(_surf_id,_left,_top,_width,_height,_x,_y,_scale_x,_scale_y,_colour_1,_alpha);
			}
		}
		else{
			draw_surface_general(_surf_id,_left,_top,_width,_height,_x,_y,_scale_x,_scale_y,_angle,_colour_1,_colour_2,_colour_3,_colour_4,_alpha);
		}
	}
}
