//Zoom Control Enabled
if(CAMERA_ZOOM_ENABLE && zoom_control_enable){
	//Camera is in Move State
	if(state == CameraState.move){
		//Either Playing or in Menu
		if((global.game_state == GameState.play) || (global.game_state == GameState.menu)){
			zoom_control_pinch_active = true;

			zoom_control_pinch_start_value = zoom_anchor.current;

			var _pos_1_x,_pos_1_y,_pos_2_x,_pos_2_y;
			_pos_1_x = event_data[? "guiposX1"];
			_pos_1_y = event_data[? "guiposY1"];
			_pos_2_x = event_data[? "guiposX2"];
			_pos_2_y = event_data[? "guiposY2"];
			zoom_control_pinch_start_distance = point_distance(_pos_1_x,_pos_1_y,_pos_2_x,_pos_2_y);

			//Drag
			var _transform,_x,_y;
			_transform = transform[TransformType.anchor];

			with(_transform){
				_x = value[TransformValue.x].current;
				_y = value[TransformValue.y].current;
			}
			drag_target.Set(_x,_y);
		}
	}
}