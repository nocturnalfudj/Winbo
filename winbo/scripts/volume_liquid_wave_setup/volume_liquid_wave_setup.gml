function volume_liquid_wave_setup(){
	// Geometry/cache
	wave_last_width_px = abs(bbox_right - bbox_left);
	wave_width_px = wave_last_width_px;
	wave_segments = max(8, floor(wave_width_px / wave_segment_px));
	wave_dx = wave_width_px / wave_segments;

	// State arrays
	wave_y = array_create(wave_segments + 1, 0);
	wave_v = array_create(wave_segments + 1, 0);
}