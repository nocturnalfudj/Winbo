function cmd_settings_pfx(_subject,_argument_list) {
	var _pfx_setting;
	_pfx_setting = _argument_list[| 0];
	
	if(string_is_real(_pfx_setting)){
		_pfx_setting = round(real(_pfx_setting));
		if((_pfx_setting >= 0) && (_pfx_setting <= PFXSetting.high)){
			with(o_pfx){
				pfx_setting = _pfx_setting;
				
				sdm("PFX Setting set to " + string(_pfx_setting),LOG_COLOUR_COMMAND_SUCCESS);
				
				pfx_save();
			}
			
			with(o_sldr_pfx_setting){
				value_current = _pfx_setting;
			}
		}
		else{
			sdm("Argument is invalid, must be a whole number between " + string(PFXSetting.off) + " and " + string(PFXSetting.high) + " : " + string(_pfx_setting),LOG_COLOUR_COMMAND_ERROR);
		}
	}
	else{
		sdm("Argument is invalid, must be a whole number between " + string(PFXSetting.off) + " and " + string(PFXSetting.high) + " : " + _pfx_setting,LOG_COLOUR_COMMAND_ERROR);
	}
}