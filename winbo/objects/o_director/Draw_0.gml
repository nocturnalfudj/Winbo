if(o_master.debug_navigation_grid_enable){
	draw_set_alpha(0.2);
	mp_grid_draw(global.path_finding_grid);
	draw_set_alpha(1);
	
	// Get the camera bounds
	var _x1, _x2, _y1, _y2;
	with(o_camera){
		_x1 = start_x;
		_y1 = start_y;
		_x2 = end_x;
		_y2 = end_y;
	}

	// Calculate the start and end positions for grid lines
	var _startX, _endX, _startY, _endY;
	_startX = floor(_x1 / CELL_WIDTH) * CELL_WIDTH;
	_endX   = ceil(_x2 / CELL_WIDTH) * CELL_WIDTH;
	_startY = floor(_y1 / CELL_HEIGHT) * CELL_HEIGHT;
	_endY   = ceil(_y2 / CELL_HEIGHT) * CELL_HEIGHT;

	// Optionally set the grid line color
	draw_set_color(c_white);

	// Draw vertical grid lines
	for(var _x = _startX; _x <= _endX; _x += CELL_WIDTH)
	{
		draw_line(_x, _y1, _x, _y2);
	}

	// Draw horizontal grid lines
	for(var _y = _startY; _y <= _endY; _y += CELL_HEIGHT)
	{
		draw_line(_x1, _y, _x2, _y);
	}

}

#region Depth Grid
	draw_set_halign(fa_middle);
	draw_set_valign(fa_center);
	draw_set_font(fnt_bahnschrift_32);
	
	var _instance;
	
	for(var _i=0;_i<DepthObjectLayer.SIZE;_i++){
		depth_grid_draw_event_state = 0;
		for(var _j=0;_j<depth_grid_height[_i];_j++){
			_instance = depth_grid[_i][# DepthGrid.instance,_j];
		
			with(_instance){
				event_perform(ev_draw,0);
			}
		}
		depth_grid_draw_event_state = 1;
		for(var _j=0;_j<depth_grid_height[_i];_j++){
			_instance = depth_grid[_i][# DepthGrid.instance,_j];
		
			with(_instance){
				event_perform(ev_draw,0);
			}
		}
	}
	#endregion
	
	#region Parallax Foreground
		var _environment_data;
		_environment_data = environment[environment_current];
		if(is_undefined(_environment_data)){
			_environment_data = environment[Environment.default_environment];
		}
		
		var _front_layers = _environment_data.background_front_layers;
		if(is_undefined(_front_layers))
			_front_layers = [];
		var _front_layer_count = array_length(_front_layers);
		if(_front_layer_count > 0){
			var _camera_x, _camera_y, _camera_width, _camera_height;
			with(o_camera){
				_camera_x = start_x;
				_camera_y = start_y;
				_camera_width = width;
				_camera_height = height;
			}
			
			var _tex_filter_old = gpu_get_tex_filter();
			gpu_set_tex_filter(false);
			
			for(var _i = 0; _i < _front_layer_count; _i++){
				var _layer = _front_layers[_i];
				switch(_layer.mode){
				case "normal":
					var _repeat_x = !variable_struct_exists(_layer, "repeat_x") || _layer.repeat_x;
					var _clamp_y = !variable_struct_exists(_layer, "clamp_y") || _layer.clamp_y;
					director_draw_parallax_layer(
						_layer.sprite,
						_camera_x,
						_camera_y,
						_camera_width,
						_camera_height,
						_layer.parallax_x,
						_layer.parallax_y,
						_layer.offset_y,
						_repeat_x,
						_clamp_y
					);
				break;
					
					case "variant_once":
						director_draw_parallax_layer_variant(
							_layer.sprite_first,
							_layer.sprite_loop,
							_camera_x,
							_camera_y,
							_camera_width,
							_camera_height,
							_layer.parallax_x,
							_layer.parallax_y,
							_layer.offset_y
						);
					break;
					
					case "animated":
						var _frame_count = sprite_get_number(_layer.sprite);
						var _frame = 0;
						if(_frame_count > 1){
							var _fps = variable_struct_exists(_layer, "fps") ? _layer.fps : ANIMATION_FPS_DEFAULT;
							_frame = floor(bg_anim_time_seconds * _fps) mod _frame_count;
						}
						
						director_draw_parallax_layer_frame(
							_layer.sprite,
							_frame,
							_camera_x,
							_camera_y,
							_camera_width,
							_camera_height,
							_layer.parallax_x,
							_layer.parallax_y,
							_layer.offset_y
						);
					break;
				}
			}
			
			gpu_set_tex_filter(_tex_filter_old);
		}
	#endregion

	#region Foreground
		if(environment_foreground_sprite != noone){
		var _x,_y,_scale;
		_x = 0;
		_y = 0;
		_scale = 1;
		with(o_camera){
			_x = x;
			_y = start_y;
			_scale = zoom_resultant;
		}
		draw_sprite_ext(environment_foreground_sprite,0,_x,_y,_scale,_scale,0,c_white,ENVIRONMENT_FOREGROUND_ALPHA);
	}
#endregion
