function slider_transform_update() {
	transform_system_update();
	
	#region Pointer
		//Animmate Transform
		if(transform_updated){
			slider_pointer_transform_animate();
		}
	
		var _pointer_position_update;
		_pointer_position_update = false;
		
		//Update Value
		with(pointer_position){
			if(animating){
				transform_value_update(global.delta_time_factor,-1);
				_pointer_position_update = true;
			}
		}
		
		//Update Draw Values
		if((_pointer_position_update) && (draw_part)){
			if(vertical){
				draw_part_len = -draw_slider_y - pointer_position.current;
			}
			else{
				draw_part_len = pointer_position.current - draw_slider_x;
			}
		}
	#endregion
}