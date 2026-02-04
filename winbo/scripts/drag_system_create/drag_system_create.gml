function drag_system_create(_part_of_drag_pan_system){
	if(_part_of_drag_pan_system == undefined)
		_part_of_drag_pan_system = false;
	
	drag_enable_x = true;
	drag_enable_y = true;
	
	drag_invert_x = false;
	drag_invert_y = false;
	
	if(IS_MOBILE)
		drag_input = mb_left;
	else
		drag_input = mb_middle;
	
	drag_active = false;
	drag_let_go_early = false;
	
	drag_target = new Vector2(0,0);
	drag_start = new Vector2(0,0);
	drag_start_mouse = new Vector2(0,0);
		
	#macro DRAG_LERP_FACTOR 0.3
	#macro DRAG_LET_GO_EARLY_LERP_FACTOR 0.2
	#macro DRAG_LET_GO_EARLY_TARGET_DIST_FACTOR 1
	
	//Clamps
	//create if they don't exist
	if(!_part_of_drag_pan_system){
		position_clamp_enable_x = false;
		position_clamp_enable_y = false;
		position_clamp_min = new Vector2(0,0);
		position_clamp_max = new Vector2(0,0);
	}
}