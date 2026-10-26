/// Called in the body owner's context at an exposed surface crossing.
function liquid_impulse(_x, _y, _impulse_strength, _impulse_radius, _invert){
	if(!wave_sim_enable) return;
	for(var _si = 0; _si < array_length(liquid_body.surfaces); _si++){
		var _s = liquid_body.surfaces[_si];
		if(_x < _s.left || _x >= _s.right || abs(_y - _s.top) > 1) continue;
		var _i = clamp(round((_x - _s.left) / _s.dx), 0, _s.segments);
		var _radius = ceil(_impulse_radius / _s.dx);
		var _sigma2 = max(1, sqr(_radius * 0.5));
		var _strength = (_invert ? 1 : -1) * _impulse_strength;
		for(var _j = max(1, _i - _radius); _j <= min(_s.segments - 1, _i + _radius); _j++)
			_s.velocity[_j] += _strength * exp(-sqr(_j - _i) / (2 * _sigma2));
	}
}
