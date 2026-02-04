/// @function pan_system_create
/// @summary Initialize screen panning variables.
/// @param {bool} [_part_of_drag_pan_system=false] Whether created for drag pan.
function pan_system_create(_part_of_drag_pan_system){
	if(_part_of_drag_pan_system == undefined)
		_part_of_drag_pan_system = false;
		
	pan_enable_x = true;
	pan_enable_y = true;
	
	pan_invert_x = false;
	pan_invert_y = false;
			
	pan_active = false;
	
	pan_mouse_scroll_enable_x = false;
	pan_mouse_scroll_enable_y = false;
	
	#macro PAN_EDGE_SCROLL_BUFF 20
	pan_edge_scroll_enable_x = true;
	pan_edge_scroll_enable_y = true;
	pan_edge_scroll_min = new Vector2(0,0);
	pan_edge_scroll_max = new Vector2(0,0);
	
	#macro PAN_LERP_FACTOR 0.2
	
	//Clamps
	//create if they don't exist
	if(!_part_of_drag_pan_system){
		position_clamp_enable_x = false;
		position_clamp_enable_y = false;
		position_clamp_min = new Vector2(0,0);
		position_clamp_max = new Vector2(0,0);
	}
}