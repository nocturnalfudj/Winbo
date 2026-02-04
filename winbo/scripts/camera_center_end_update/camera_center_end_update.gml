/// Update cached start and end coordinates based on current position.
function camera_center_end_update() {
	start_x = x - width_half;
	start_y = y - height_half;
	end_x = x + width_half;
	end_y = y + height_half;
}