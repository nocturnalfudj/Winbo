/// @function camera_filter_settings_update_layers
/// @summary Apply camera filter settings to their respective layer effects.
/// @param _override_previous_comparison Force update even if value unchanged.
/// @returns {void} No return value.
function camera_filter_settings_update_layers(_override_previous_comparison){
	if((room != r_boot) && (room != r_loading_app) && (room != r_intro)){
		_override_previous_comparison ??= false;
		
		var _layer_fx,_filter,_value,_value_previous;
		
		_filter = CameraFilter.brightness;
		_value = filter_setting[_filter];
		_value_previous = filter_setting_previous[_filter];
		if((_value != _value_previous) || (_override_previous_comparison)){
			filter_setting_previous[_filter] = _value;
			_layer_fx = layer_get_fx("lyr_filter_brightness");
			fx_set_parameter(_layer_fx,"g_ContrastBrightness",_value);
		}
		
		_filter = CameraFilter.contrast;
		_value = filter_setting[_filter];
		_value_previous = filter_setting_previous[_filter];
		if((_value != _value_previous) || (_override_previous_comparison)){
			filter_setting_previous[_filter] = _value;
			_layer_fx = layer_get_fx("lyr_filter_contrast");
			fx_set_parameter(_layer_fx,"g_ContrastIntensity",_value);
		}
		
		_filter = CameraFilter.saturation;
		_value = filter_setting[_filter];
		_value_previous = filter_setting_previous[_filter];
		if((_value != _value_previous) || (_override_previous_comparison)){
			filter_setting_previous[_filter] = _value;
			_layer_fx = layer_get_fx("lyr_filter_saturation");
			fx_set_parameter(_layer_fx,"g_HueSaturation",_value);
		}
		
		//_filter = CameraFilter.noise_additional;
		//_value = filter_setting[_filter];
		//_value_previous = filter_setting_previous[_filter];
		//if((_value != _value_previous) || (_override_previous_comparison)){
		//	filter_setting_previous[_filter] = _value;
		//	_layer_fx = layer_get_fx("lyr_filter_noise");
		//	fx_set_parameter(_layer_fx,"g_WhiteNoiseIntensity",_value);
		//}
		
		_filter = CameraFilter.vignette;
		_value = filter_setting[_filter];
		_value_previous = filter_setting_previous[_filter];
		if((_value != _value_previous) || (_override_previous_comparison)){
			filter_setting_previous[_filter] = _value;
			_layer_fx = layer_get_fx("lyr_filter_vignette");
			fx_set_parameter(_layer_fx,"g_VignetteSharpness",lerp(8,1,_value));
			fx_set_parameter(_layer_fx,"g_VignetteEdges",[lerp(1,0.3,_value),lerp(2,1,_value)]);
		}
	}
}