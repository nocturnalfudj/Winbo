/// @function sldr_anti_aliasing_active_main
/// @summary Apply anti-aliasing level based on slider value.
function sldr_anti_aliasing_active_main() {
	var _value_current;
	switch(value_current){
		case 0:
			_value_current = 0;
		break;
			
		case 1:
			_value_current = 2;
		break;
			
		case 2:
			_value_current = 4;
		break;
			
		case 3:
			_value_current = 8;
		break;
	}
	
	with(o_camera){
		if((_value_current != anti_aliasing) && (anti_aliasing_supported[_value_current])){
			anti_aliasing = _value_current;
				
			camera_save();
						
			display_reset(anti_aliasing,vsync);
		}
	}
}