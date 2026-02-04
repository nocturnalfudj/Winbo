/// @function slider_val_update
/// @summary Update slider position and text value based on current settings.
/// @returns {void}
function slider_val_update() {
	//Value Updated
	if((value_previous != value_current) || (value_min_previous != value_min) || (value_max_previous != value_max)){
		//Clamp Val
                if(value_current_clamp_enable)
                        // Ensure value stays within bounds
                        value_current = clamp(value_current,value_min,value_max);
	
		//Value Current Percent
		value_current_percent = (value_current-value_min) / (value_max-value_min);
	
		//Set Pointer Transform
		slider_pointer_transform_animate();
	
		//Text Update
		if(text_value_current_enable){
			var _val;
			if(percent){
				if(percent_of_max)
					_val = value_current_percent*100;
				else
					_val = value_current*100;
				text_value_current = string_format(_val,1,decimal_digits) + "%";
			}
			else{
				_val = value_current;
				text_value_current = string_format(_val,1,decimal_digits);
			}
		}
	}

	//Previous
	value_previous = value_current;
	value_min_previous = value_min;
	value_max_previous = value_max;
}