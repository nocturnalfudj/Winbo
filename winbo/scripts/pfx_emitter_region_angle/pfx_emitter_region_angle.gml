/// @function pfx_emitter_region_angle
/// @summary Position a particle emitter relative to the instance angle.
/// @param _fx Index of the particle system definition.
/// @param _ps Particle system ID.
/// @param _emitter Emitter ID within the system.
/// @returns {void} No return value.
function pfx_emitter_region_angle(_fx,_ps,_emitter) {
	var _w_half,_h_half,_shape,_distribution;
	_w_half = pfx[_fx][PFXProperty.emitter_width_half];
	_h_half = pfx[_fx][PFXProperty.emitter_height_half];
	_shape = pfx[_fx][PFXProperty.emitter_shape];
	_distribution = pfx[_fx][PFXProperty.emitter_distribution];
	
	var _relative_x,_relative_y;
	_relative_x = pfx[_fx][PFXProperty.emitter_relative_x];
	_relative_y = pfx[_fx][PFXProperty.emitter_relative_y];
	
	var _x,_y;
	_x = x + lengthdir_x(_relative_x,image_angle);
	_y = y + lengthdir_y(_relative_x,image_angle);
		
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
		
	part_emitter_region(_ps,_emitter,_x_min,_x_max,_y_min,_y_max,_shape,_distribution);
}