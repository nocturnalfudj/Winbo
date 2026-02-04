/// @function sldr_anti_aliasing_down_main
/// @summary Update subtitle text when the anti-aliasing slider moves.
/// @returns {void} No return value.
function sldr_anti_aliasing_down_main() {
	if(value_current != value_previous){
		switch(value_current){
			case 0:
				subtitle_string = "off";
			break;
			
			case 1:
				subtitle_string = "x2";
			break;
			
			case 2:
				subtitle_string = "x4";
			break;
			
			case 3:
				subtitle_string = "x8";
			break;
		}
	}
}