function liquid_impulse(_x, _y, _impulse_strength, _impulse_radius, _invert){
	if (!wave_sim_enable) return;

	var	_impulse_radius_ix = ceil(_impulse_radius / max(1, wave_dx));
	var	_left = bbox_left, _right = bbox_right, _top = bbox_top;

	if ((_x < _left) || (_x > _right)) return;

	// clamp to [0, wave_segments - 1]
	var	_i = clamp(round((_x - _left) / max(1, wave_dx)), 0, wave_segments - 1);
	var	_u = _i / max(1, wave_segments - 1);
	var	_taper = power(sin(pi * _u), wave_edge_power);
	var	_base = sin((2 * pi / wave_len_px) * (_i * wave_dx) + wave_phase) * wave_amp_px * _taper;
	var	_y_top_i = _top + _base + wave_y[_i];

	// compute normally, then flip if requested
	var	_signed_mag = (_y_top_i - _y) * 0.03 * _impulse_strength;
	if (_invert) _signed_mag = -_signed_mag;

	var	_r = _impulse_radius_ix;
	var	_sigma2 = max(1, sqr(_r * 0.5));
	for (var _j = max(0, _i - _r); _j <= min(wave_segments - 1, _i + _r); _j++) {
		var	_w = exp(-sqr(_j - _i) / (2 * _sigma2));
		wave_v[_j] += _signed_mag * _w;
	}
}
