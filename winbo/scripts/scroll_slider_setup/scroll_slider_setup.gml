/// @function scroll_slider_setup
/// @summary Configure a slider to control the given scroll container.
/// @param _scroll Scroll object instance to manipulate.
function scroll_slider_setup(_scroll){
	//Set Scroll
	scroll = _scroll;
	
	#region Value
		if(vertical){
			value_current = scroll.y;
			value_max = scroll.position_clamp_max.y;
			value_min = scroll.position_clamp_min.y;
		}
		else{
			value_current = scroll.x;
			value_max = scroll.position_clamp_max.x;
			value_min = scroll.position_clamp_min.x;
		}
		
		value_previous = value_current;
		value_max_previous = value_max;
		value_min_previous = value_min;
		
		value_current_percent = (value_current-value_min) / (value_max-value_min);
	#endregion
}