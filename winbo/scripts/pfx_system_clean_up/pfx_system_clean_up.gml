/// @function pfx_system_clean_up
/// @summary Destroy any emitters created by particle effects.
function pfx_system_clean_up() {
	var _ps,_emitter;
	for(var _i=0;_i<pfx_num;_i++){
		_emitter = pfx[_i][PFXProperty.emitter];
	
		if(_emitter != noone){
			_ps = pfx[_i][PFXProperty.system];
	
			if (part_emitter_exists(_ps,_emitter))
				part_emitter_destroy(_ps,_emitter);
		}
	}
}
