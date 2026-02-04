/// @function pfx_burst_emitter
/// @summary Emit particles using a preconfigured emitter.
/// @param _fx Index of the effect definition.
/// @param _ps Particle system to emit into.
/// @param _emitter Emitter ID to use when bursting.
function pfx_burst_emitter(_fx,_ps,_emitter) {
	var _type,_burst_num;
	_type = pfx[_fx][PFXProperty.type];
	_burst_num = pfx[_fx][PFXProperty.burst_num];
	part_emitter_burst(_ps,_emitter,_type,_burst_num);
}
