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
underwater_background_surface_width = abs(bbox_left - bbox_right);
underwater_background_surface_height = abs(bbox_top - bbox_bottom);

//Underwater
underwater_surface = -1;
underwater_composite_surface = -1;
underwater_surface_width = abs(bbox_left - bbox_right);
underwater_surface_height = abs(bbox_top - bbox_bottom);

//Mask
water_mask_surface = -1;

//Reflection
reflection_enable = true;
reflection_alpha = 0.2;
reflection_surface = -1;
reflection_composite_surface = -1;
reflection_surface_width = abs(bbox_left - bbox_right);
reflection_surface_height = abs(bbox_top - bbox_bottom);

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