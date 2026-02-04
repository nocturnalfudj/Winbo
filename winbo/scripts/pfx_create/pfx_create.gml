/// @function pfx_create
/// @summary Configure a new particle effect entry.
/// @param _pfx_id            Index into the global effect array.
/// @param _system            Particle system handle.
/// @param _type              Particle type ID.
/// @param _gui               Whether the effect is drawn in GUI space.
/// @param _emitter           Optional emitter ID or noone.
/// @param _emitter_x         Relative X offset of the emitter.
/// @param _emitter_y         Relative Y offset of the emitter.
/// @param _emitter_height_half Half height of the emitter region.
/// @param _emitter_width_half  Half width of the emitter region.
/// @param _emitter_shape     Shape constant for the emitter.
/// @param _emitter_distribution Distribution constant for the emitter.
/// @param _emitter_reg_scr   Script for emitter region setup.
/// @param _burst_num         Number of particles when triggered.
/// @param _burst_script      Script executed when the effect bursts.
function pfx_create(_pfx_id,_system,_type,_gui,_emitter,_emitter_x,_emitter_y,_emitter_height_half,_emitter_width_half,_emitter_shape,_emitter_distribution,_emitter_reg_scr,_burst_num,_burst_script) {
	pfx[_pfx_id][PFXProperty.system] = _system;
	pfx[_pfx_id][PFXProperty.type] = _type;
	pfx[_pfx_id][PFXProperty.gui] = _gui;
	pfx[_pfx_id][PFXProperty.emitter] = _emitter;
	pfx[_pfx_id][PFXProperty.emitter_relative_x] = _emitter_x;
	pfx[_pfx_id][PFXProperty.emitter_relative_y] = _emitter_y;
	pfx[_pfx_id][PFXProperty.emitter_height_half] = _emitter_height_half;
	pfx[_pfx_id][PFXProperty.emitter_width_half] = _emitter_width_half;
	pfx[_pfx_id][PFXProperty.emitter_shape] = _emitter_shape;
	pfx[_pfx_id][PFXProperty.emitter_distribution] = _emitter_distribution;
	pfx[_pfx_id][PFXProperty.emitter_region_script] = _emitter_reg_scr;

	pfx[_pfx_id][PFXProperty.burst_num] = _burst_num;
	pfx[_pfx_id][PFXProperty.burst_script] = _burst_script;
	pfx[_pfx_id][PFXProperty.burst_active] = false;

	pfx_num++;
}
