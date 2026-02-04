/// @function draw_ring_loading
/// @summary Rotating, pulsing loading ring with 15% less expansion and end-anchored arc.
/// @param _x X position.
/// @param _y Y position.
/// @param _outer_radius Outer radius.
/// @param _inner_radius Inner radius.
/// @param _segment_count Number of segments.
/// @param _color_for_ring Colour of the ring.
/// @param _alpha_for_ring Alpha transparency.
/// @param _rotation_speed_degrees_per_second Rotation speed.
/// @param _arc_minimum_fraction Minimum arc fraction.
/// @param _arc_maximum_fraction Maximum arc fraction.
/// @param _arc_pulse_speed_cycles_per_second Arc pulsing speed.
/// @returns {void} No return value.

function draw_ring_loading(
	_x, 
	_y, 
	_outer_radius, 
	_inner_radius,
	_segment_count,
	_color_for_ring,
	_alpha_for_ring,
	_rotation_speed_degrees_per_second,
	_arc_minimum_fraction,
	_arc_maximum_fraction,
	_arc_pulse_speed_cycles_per_second
){
	// defaults
	_segment_count                     ??= 64;
	_color_for_ring                    ??= c_white;
	_alpha_for_ring                    ??= 1;
	_rotation_speed_degrees_per_second ??= 180;
	_arc_minimum_fraction              ??= 0.1;
	_arc_maximum_fraction              ??= 0.8;
	_arc_pulse_speed_cycles_per_second ??= 0.5;

	// total frames elapsed
	var _frame_count = o_master.current_time_scaled;

	// rotation: degrees per frame = deg/sec ÷ frames/sec
	var _degrees_per_frame = _rotation_speed_degrees_per_second / SECOND;
	var _current_rotation_angle = (_frame_count * _degrees_per_frame) mod 360;

	// reduce expansion range by 15%
	var _full_range       = _arc_maximum_fraction - _arc_minimum_fraction;
	var _adjusted_range   = _full_range * 0.85;
	var _arc_maximum_adj  = _arc_minimum_fraction + _adjusted_range;

	// pulse speed in cycles per frame
	var _cycles_per_frame = _arc_pulse_speed_cycles_per_second / SECOND;
	var _current_arc_fraction = wave_ags(
		_arc_minimum_fraction,
		_arc_maximum_adj,
		_cycles_per_frame,
		_frame_count
	);

	// anchor the expanding end at the rotating tip
	var _start_angle_for_arc = (_current_rotation_angle - _current_arc_fraction * 360 + 360) mod 360;

	// draw it
	draw_ring(
		_x, 
		_y,
		_outer_radius, 
		_inner_radius,
		_color_for_ring, 
		_alpha_for_ring,
		_segment_count,
		_current_arc_fraction,
		_start_angle_for_arc,
		true
	);
}
