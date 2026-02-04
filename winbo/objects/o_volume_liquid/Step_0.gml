// Inherit the parent event
event_inherited();

#region Camera Visible
	// Camera frustum culling - skip rendering if completely off-screen
	var _buffer = camera_visible_buffer; // Account for wave effects extending beyond bbox
	var _cam_start_x, _cam_end_x, _cam_start_y, _cam_end_y;
	with(o_camera){
		_cam_start_x = start_x;
		_cam_end_x = end_x;
		_cam_start_y = start_y;
		_cam_end_y = end_y;
	}
	if (bbox_right + _buffer < _cam_start_x || 
	    bbox_left - _buffer > _cam_end_x ||
	    bbox_bottom + _buffer < _cam_start_y || 
	    bbox_top - _buffer > _cam_end_y) {
	    camera_visible = false;
	}
	else{
		camera_visible = true;
	}
	
	if(!camera_visible)
		exit;
#endregion

//Texture Position
texture_x += texture_x_speed;
texture_y += texture_y_speed;

// Advance wave phase
wave_phase += wave_speed;

// Rebuild arrays on width/segment change
if(wave_sim_enable){
	var _width_px;
	_width_px = abs(bbox_right - bbox_left);
	if((_width_px != wave_last_width_px) || (wave_dx <= 0)){
		wave_width_px = _width_px;
		wave_segments = max(8, floor(wave_width_px / wave_segment_px));
		wave_dx = wave_width_px / wave_segments;
		impulse_radius_ix = ceil(impulse_radius_px / max(1, wave_dx));
		wave_y = array_create(wave_segments + 1, 0);
		wave_v = array_create(wave_segments + 1, 0);
		wave_last_width_px = _width_px;
	}

	// Stable Laplacian-based tension update with damping
	var _accel;
	for(var i=1; i<wave_segments; i++){
		_accel = wave_tension * (wave_y[i-1] - 2*wave_y[i] + wave_y[i+1]);
		wave_v[i] += _accel;
	}

	// Damping, clamp velocity, integrate displacement
	for(var i=0; i<=wave_segments; i++){
		wave_v[i] *= wave_damping;
		wave_v[i] = clamp(wave_v[i], -wave_vel_max, wave_vel_max);
		wave_y[i] += wave_v[i];
	}

	// Pin endpoints (edges cannot move)
	wave_y[0] = 0; wave_v[0] = 0;
	wave_y[wave_segments] = 0; wave_v[wave_segments] = 0;
}