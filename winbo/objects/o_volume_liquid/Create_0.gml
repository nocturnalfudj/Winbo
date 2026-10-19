// Inherit the parent event
event_inherited();

#region Camera Visible
	camera_visible = true;
	camera_visible_buffer = 50;
#endregion

//Gravity
gravity_factor = 0.75;

//Underwater Background
underwater_background_surface = -1;

//Underwater
underwater_surface = -1;
underwater_composite_surface = -1;

//Mask
water_mask_surface = -1;

//Reflection
reflection_enable = true;
reflection_alpha = 0.2;
reflection_surface = -1;
reflection_composite_surface = -1;

//Texture
texture_x = 0;
texture_y = 0;
texture_x_speed = 1;
texture_y_speed = -1;

// Wave (wavy top parameters)
wave_amp_px = 4;
wave_len_px = 500;
wave_speed = 0.01;
wave_edge_power = 0.5;
wave_segment_px = 8;
wave_phase = 0;

// Wave simulation
wave_sim_enable = true;

// Geometry/cache
wave_last_width_px = abs(bbox_right - bbox_left);
wave_width_px = wave_last_width_px;
wave_segments = max(8, floor(wave_width_px / wave_segment_px));
wave_dx = wave_width_px / wave_segments;

// State arrays
wave_y = array_create(wave_segments + 1, 0);
wave_v = array_create(wave_segments + 1, 0);

// Simulation params
wave_tension = 1;       // Laplacian spring factor
wave_damping = 0.95;       // slightly lower for faster settle (0..1)

// Safety clamps (only velocity now)
wave_vel_max = 8000;

// Surface dimension cache (optimization to prevent unnecessary resizing)
cached_surf_w = -1;
cached_surf_h = -1;
render_scale = 1;
render_height_buffer = 0;
render_capture_top = 0;

// One owner for the existing volatile GPU surface checks. A zero size releases
// the surface; Draw Begin updates every surface before either draw pass uses it.
liquid_surface_update = function(_surface, _width, _height) {
	if (!surface_exists(_surface)) {
		return (_width > 0 && _height > 0) ? surface_create(_width, _height) : -1;
	}
	if (_width <= 0 || _height <= 0) {
		surface_free(_surface);
		return -1;
	}
	if (surface_get_width(_surface) != _width || surface_get_height(_surface) != _height) {
		surface_resize(_surface, _width, _height);
	}
	return _surface;
};

// Unavailable scene pixels must stay transparent. Copying beyond the application
// surface can stretch its edge pixels into the water when the camera moves.
liquid_scene_capture = function() {
	var _camera = view_camera[0];
	var _source_x = floor((bbox_left - camera_get_view_x(_camera)) * render_scale);
	var _source_y = floor((bbox_top - render_height_buffer - camera_get_view_y(_camera)) * render_scale);
	var _copy_x = max(0, _source_x);
	var _copy_y = max(0, _source_y);
	var _destination_x = _copy_x - _source_x;
	var _destination_y = _copy_y - _source_y;
	render_capture_top = _destination_y / cached_surf_h;
	var _copy_width = min(cached_surf_w - _destination_x, surface_get_width(application_surface) - _copy_x);
	var _copy_height = min(cached_surf_h - _destination_y, surface_get_height(application_surface) - _copy_y);

	surface_set_target(underwater_surface);
	draw_clear_alpha(c_black, 0);
	surface_reset_target();
	if (_copy_width > 0 && _copy_height > 0) {
		surface_copy_part(underwater_surface, _destination_x, _destination_y,
			application_surface, _copy_x, _copy_y, _copy_width, _copy_height);
	}
};

ambient_bubbles_enable = false;
ambient_bubbles_countdown = random_range(SECOND * 0.6, SECOND * 1.4);

// Surface effects are configured before any drawing or contact checks.
splash_colour = make_colour_rgb(129, 196, 253);
submerged_ripple_time = 0;
submerged_ripple_strength = 4;
submerged_ripple_uniform_time = shader_get_uniform(sh_liquid_ripple, "u_time");
submerged_ripple_uniform_texel = shader_get_uniform(sh_liquid_ripple, "u_texel");
submerged_ripple_uniform_strength = shader_get_uniform(sh_liquid_ripple, "u_strength");
submerged_ripple_uniform_fade_top = shader_get_uniform(sh_liquid_ripple, "u_fade_top");
