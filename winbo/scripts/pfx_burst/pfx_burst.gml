/// @function pfx_burst
/// @summary Emit particles directly from the owning instance.
/// @param _fx Index of the effect to activate.
/// @param _ps Particle system to emit into.
function pfx_burst(_fx,_ps) {
	var _type,_burst_num,_w_half,_h_half;
	_type = pfx[_fx][PFXProperty.type];
	_burst_num = pfx[_fx][PFXProperty.burst_num];
	_w_half = pfx[_fx][PFXProperty.emitter_width_half];
	_h_half = pfx[_fx][PFXProperty.emitter_height_half];
	
	var _relative_x,_relative_y;
	_relative_x = pfx[_fx][PFXProperty.emitter_relative_x];
	_relative_y = pfx[_fx][PFXProperty.emitter_relative_y];
	
	var _x,_y;
	_x = x + lengthdir_x(_relative_x, image_angle) + lengthdir_x(_relative_y, image_angle - 90);
    _y = y + lengthdir_y(_relative_x, image_angle) + lengthdir_y(_relative_y, image_angle - 90);

	var _x_min,_x_max,_y_min,_y_max;
	_x_min = _x - _w_half;
	_x_max = _x + _w_half;
	_y_min = _y - _h_half;
	_y_max = _y + _h_half;
	
	if(pfx[_fx][PFXProperty.gui]){
		var _gui_scale;
		_gui_scale = o_ui.gui_scale;
		_x_min *= _gui_scale;
		_x_max *= _gui_scale;
		_y_min *= _gui_scale;
		_y_max *= _gui_scale;
	}

	var _brst_x,_brst_y;
	for(var _i=0;_i<_burst_num;_i++){
		_brst_x = irandom_range(_x_min,_x_max);
		_brst_y = irandom_range(_y_min,_y_max);

		part_particles_create(_ps,_brst_x,_brst_y,_type,1);
	}
}
