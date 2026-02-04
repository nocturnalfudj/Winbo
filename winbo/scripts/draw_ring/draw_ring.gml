/// @function draw_ring
/// @summary Draw a filled ring with an adjustable arc.
/// @param {real} _x X coordinate of the center.
/// @param {real} _y Y coordinate of the center.
/// @param {real} _outerRadius Outer radius in pixels.
/// @param {real} _innerRadius Inner radius in pixels.
/// @param _color Draw color.
/// @param {real} _alpha Alpha 0..1.
/// @param {real} _segments Number of segments used to approximate the arc.
/// @param {real} _percentage Portion of the circle to render [0,1].
/// @param {real} _startAngle Starting angle in degrees.
/// @param {bool} _clockwise Direction of arc rendering.
/// @returns {void} No return value.
function draw_ring(_x, _y, _outerRadius, _innerRadius, _color, _alpha, _segments, _percentage, _startAngle, _clockwise)
{
	// Set the color and alpha
	draw_set_color(_color);
	draw_set_alpha(_alpha);

	// Convert start angle to radians
	var _sa = degtorad(_startAngle);

	// Determine direction (1 = clockwise, -1 = counterclockwise)
	var _sign = (_clockwise) ? 1 : -1;

	// Final angle based on percentage
	var _fa = _sa + _sign * (2 * pi * _percentage);

	// Step size (angle per segment)
	var _step = _sign * (2 * pi / _segments);

	// Current angle and its sine/cosine
	var _angle1 = _sa;
	var _cos1   = cos(_angle1);
	var _sin1   = sin(_angle1);

	// Draw until we reach or pass the final angle (depending on direction)
	while ((_sign > 0 && _angle1 < _fa) || (_sign < 0 && _angle1 > _fa))
	{
		// Angle for the next segment
		var _angle2 = _angle1 + _step;

		// Clamp the next angle if it goes beyond the final angle (so we can draw a partial segment if needed)
		var _angle2_clamped = (_sign > 0) ? min(_angle2, _fa) : max(_angle2, _fa);

		// Compute sine/cosine for this clamped angle
		var _cos2 = cos(_angle2_clamped);
		var _sin2 = sin(_angle2_clamped);

		// Outer points
		var _x1 = _x + _outerRadius * _cos1;
		var _y1 = _y + _outerRadius * _sin1;
		var _x2 = _x + _outerRadius * _cos2;
		var _y2 = _y + _outerRadius * _sin2;

		// Inner points
		var _x3 = _x + _innerRadius * _cos1;
		var _y3 = _y + _innerRadius * _sin1;
		var _x4 = _x + _innerRadius * _cos2;
		var _y4 = _y + _innerRadius * _sin2;

		// Draw two triangles per segment
		draw_triangle(_x1, _y1, _x3, _y3, _x4, _y4, false);
		draw_triangle(_x1, _y1, _x2, _y2, _x4, _y4, false);

		// Advance: next iteration starts at _angle2_clamped
		_angle1 = _angle2_clamped;
		_cos1   = _cos2;
		_sin1   = _sin2;
	}

	// Restore alpha
	draw_set_alpha(1);
}