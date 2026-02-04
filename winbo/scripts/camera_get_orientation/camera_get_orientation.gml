/// Get the current display orientation accounting for browser setups.
function camera_get_orientation(){
	if(IS_BROWSER){
		if(browser_width < browser_height){
			return display_portrait;
		}
		else
			return display_landscape;
	}
	else{
		return display_get_orientation();
	}
}