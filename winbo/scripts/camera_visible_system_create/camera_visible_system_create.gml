/// @function camera_visible_system_create
/// @summary Initialize variables used for visibility checks.
function camera_visible_system_create() {
	camera_visible = false;
	camera_visible_position = false;
	camera_visible_gui = false;
	camera_visible_buff_factor = 2;
	camera_visible_buff_width = sprite_width * camera_visible_buff_factor;
	camera_visible_buff_height = sprite_height * camera_visible_buff_factor;
	
	camera_visible_always = false;
}