/// @desc Initializes a bar UI state instance
function bar_state_create(){
	//Get Camera Dimensions
	var _camera_width,_camera_height;
	with(o_camera){
		_camera_width = width_ini;
		_camera_height = height_ini;
	}
	
	//Get Anchor Transform Reference
	var _transform;
	_transform = transform[TransformType.anchor];
	
	#region Position
		var _x_rest,_y_rest;
		switch(bar_direction){
			case BarDirection.up:
				_x_rest = 0;
				_y_rest = distance;
			break;
		
			case BarDirection.down:
				_x_rest = 0;
				_y_rest = _camera_height - distance;
			break;
		
			case BarDirection.left:
				_x_rest = distance;
				_y_rest = 0;
			break;
		
			case BarDirection.right:
				_x_rest = _camera_width - distance;
				_y_rest = 0;
			break;
		}
	
		//X
		transform_set(_transform,TransformValue.x,_x_rest,false);
		transform_set_rest(_transform,TransformValue.x,_x_rest,false);
	
		//Y
		transform_set(_transform,TransformValue.y,_y_rest,false);
		transform_set_rest(_transform,TransformValue.y,_y_rest,false);
	#endregion
	
	//Camera Visible Dimensions
	camera_visible_dimensions();

	//State to Idle
	ui_object_state_set(UIState.idle);

	//Custom Script
	ui_object_state_script_stage_execute(UIState.create,UIStateStage.main);
	ui_object_state_script_stage_execute(UIState.create,UIStateStage.stop);
}