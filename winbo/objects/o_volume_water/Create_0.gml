// Inherit the parent event
event_inherited();

//Gravity
gravity_factor = 0.8;

//Reflection
reflection_enable = true;
reflection_alpha = 0.2;

// Wave (wavy top parameters)
wave_amp_px = 4;
wave_len_px = 500;
wave_speed = 0.01;
wave_edge_power = 0.5;
wave_segment_px = 8;

//Texture
texture_x_speed = 0.25;
texture_y_speed = -0.15;

//Rerun Wave Setup With Above Values
volume_liquid_wave_setup();

// Simulation params
wave_tension = 1;       // Laplacian spring factor
wave_damping = 0.95;    // slightly lower for faster settle (0..1)