function slider_state_create() {
	#region Dimensions
		//Transform Update Scale
		transform_system_update_scale();
	
		#region Dimensions
			dimensions_system_update(sprite_current);
		
			slider_sprite_width = sprite_get_width(sprite_current);
			slider_sprite_height = sprite_get_height(sprite_current);
	
			slider_sprite_width_half = slider_sprite_width/2;
			slider_sprite_height_half = slider_sprite_height/2;
	
			if(draw_part){
				draw_slider_x = -slider_sprite_width/2;
				draw_slider_y = -slider_sprite_height/2;
			
				if(vertical){
					draw_part_len = pointer_position.current - draw_slider_y;
				}
				else{
					draw_part_len = pointer_position.current - draw_slider_x;
				}
			}
		#endregion
		
		//Camera Visible Dimensions
		camera_visible_dimensions();
	#endregion
	
	//Value Update
	value_previous = value_current - 1;
	slider_val_update();

	//Transform Update
	slider_transform_update();

	#region Set Slider Starting Transform
		var _position;
		if(vertical){
			_position = slider_sprite_height_half - slider_sprite_height*((value_current-value_min)/(value_max-value_min));
		}
		else{
			_position = slider_sprite_width*((value_current-value_min)/(value_max-value_min)) - slider_sprite_width_half;
		}
		transform_value_set(pointer_position,_position,false);
	#endregion

	//State to Idle
	ui_object_state_set(UIState.idle);

	//Custom Script
	ui_object_state_script_stage_execute(UIState.create,UIStateStage.main);
	ui_object_state_script_stage_execute(UIState.create,UIStateStage.stop);
}