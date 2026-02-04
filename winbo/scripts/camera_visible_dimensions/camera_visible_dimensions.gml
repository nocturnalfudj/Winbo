/// @function camera_visible_dimensions
/// @summary Cache the camera buffer dimensions.
/// @returns {void} No return value.
function camera_visible_dimensions(){
	camera_visible_buff_width = width * camera_visible_buff_factor;
	camera_visible_buff_height = height * camera_visible_buff_factor;
}