#region Filter Layer Update
	//Apply
	camera_filter_settings_update_layers(true);
#endregion

#region Position & Transform
	x = width_ini_half;
	y = height_ini_half;
	
	var _x,_y;
	_x = x;
	_y = y;
	with(transform[TransformType.anchor]){
		with(value[TransformValue.x]){
			rest = _x;
			current = _x;
		}
		
		with(value[TransformValue.y]){
			rest = _y;
			current = _y;
		}
	}
	
	//Update Stationary Target
	stationary_target.Set(width_ini_half,height_ini_half);

	//Update Camera Position
	camera_view_pos_update();
	
	//Update Camera Dimensions
	camera_zoom_set_dimensions();
	
	//Limit camera to move anywhere in the room
	position_clamp_min = new Vector2(width_half, height_half);  // Left/top edge
	position_clamp_max = new Vector2(room_width - width_half, room_height - height_half);  // Right/bottom edge
#endregion