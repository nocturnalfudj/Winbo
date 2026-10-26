// Inherit the parent event
event_inherited();

if(liquid_geometry_left != bbox_left || liquid_geometry_top != bbox_top
|| liquid_geometry_right != bbox_right || liquid_geometry_bottom != bbox_bottom
|| liquid_geometry_count != instance_number(o_volume_liquid)) volume_liquid_body_rebuild();

// One simulation and composite for the whole connected body.
if(liquid_body.owner != id) exit;

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
	if (liquid_body.right + _buffer < _cam_start_x ||
	    liquid_body.left - _buffer > _cam_end_x ||
	    liquid_body.bottom + _buffer < _cam_start_y ||
	    liquid_body.top - _buffer > _cam_end_y) {
	    camera_visible = false;
	}
	else{
		camera_visible = true;
	}

	if(!camera_visible)
		exit;
#endregion

liquid_bubbles_update();
submerged_ripple_time += global.delta_time_factor_scaled / SECOND;

//Texture Position
texture_x += texture_x_speed;
texture_y += texture_y_speed;

// Advance wave phase
wave_phase += wave_speed;

// Exposed surface spans share one simulation across authoring seams.
if(wave_sim_enable){
	for(var _si = 0; _si < array_length(liquid_body.surfaces); _si++){
		var _s = liquid_body.surfaces[_si];
		for(var _i = 1; _i < _s.segments; _i++){
			_s.velocity[_i] += wave_tension * (_s.displacement[_i - 1]
				- 2 * _s.displacement[_i] + _s.displacement[_i + 1]);
		}
		for(var _i = 0; _i <= _s.segments; _i++){
			_s.velocity[_i] = clamp(_s.velocity[_i] * wave_damping, -wave_vel_max, wave_vel_max);
			_s.displacement[_i] += _s.velocity[_i];
		}
		_s.displacement[0] = 0; _s.velocity[0] = 0;
		_s.displacement[_s.segments] = 0; _s.velocity[_s.segments] = 0;
	}
}
