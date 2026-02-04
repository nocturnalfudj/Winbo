/// @function pfx_system_execute
/// @summary Update active particle effects and run burst scripts.
function pfx_system_execute() {
        var _ps,_emitter;
	var _emitter_reg_scr;
	var _burst_script,_brst_active;

	for(var _i=0;_i<pfx_num;_i++){
		//Ignore if Part Type Doesn't Exist
		if(pfx[_i][PFXProperty.type] == noone)
			continue;
		
		_brst_active = pfx[_i][PFXProperty.burst_active];
	
		if(_brst_active != false){
			_ps = pfx[_i][PFXProperty.system];
			_emitter = pfx[_i][PFXProperty.emitter];
		
			_burst_script = pfx[_i][PFXProperty.burst_script];
			
			if(_burst_script != noone){
				if(_emitter != noone){
					_emitter_reg_scr = pfx[_i][PFXProperty.emitter_region_script];
					if(_emitter_reg_scr != noone)
						script_execute(_emitter_reg_scr,_i,_ps,_emitter);

					script_execute(_burst_script,_i,_ps,_emitter);
				}
				else{
					script_execute(_burst_script,_i,_ps);
				}
			}
		
			if(_brst_active == true){
				 pfx[_i][PFXProperty.burst_active] = false;
			}
		}
	}
}
