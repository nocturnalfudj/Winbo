/// @function camera_visible_system_create
/// @summary Initialize variables used for visibility checks.
function camera_visible_system_create() {
	camera_visible = false;
	camera_visible_position = false;
	camera_visible_gui = false;
	camera_visible_buff_factor = 2;
	// Room-editor mirroring makes sprite_width negative; the buffer must still widen the view.
	camera_visible_buff_width = abs(sprite_width) * camera_visible_buff_factor;
	camera_visible_buff_height = abs(sprite_height) * camera_visible_buff_factor;
	
	camera_visible_always = false;
}