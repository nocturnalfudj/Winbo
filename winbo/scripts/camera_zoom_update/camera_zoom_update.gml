/// @function camera_zoom_update
/// @summary Update camera zoom transition over time.
function camera_zoom_update() {
	if(CAMERA_ZOOM_ENABLE){
		var _delta_time;
		if(zoom_time_scale_enable)
			_delta_time = global.delta_time_factor_scaled;
		else
			_delta_time = global.delta_time_factor;
	
		var _zoom_updated;
		_zoom_updated = false;
	
		//Anchor
		with(zoom_anchor){
			if(animating){
				transform_value_update(_delta_time,-1);
				_zoom_updated = true;
			}
		}
	
		//Relative
		with(zoom_relative){
			if(animating){
				transform_value_update(_delta_time,-1);
				_zoom_updated = true;
			}
		}
	
		zoom_updated = _zoom_updated;
	}
}