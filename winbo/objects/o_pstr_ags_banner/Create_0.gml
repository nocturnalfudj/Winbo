// Inherit the parent event
event_inherited();

#region Image
	sprite_current = spr_ags_banner;
#endregion

#region Transform
	var _x_center,_y_center;
	with(o_camera){
		_x_center = width_ini_half;
		_y_center = height_ini_half;
	}
		
	var _transform
	_transform = transform[TransformType.anchor];
	
	transform_set(_transform,TransformValue.x,_x_center,false);
	transform_set(_transform,TransformValue.y,_y_center,false);
	
	transform_set_rest(_transform,TransformValue.x,_x_center,false);
	transform_set_rest(_transform,TransformValue.y,_y_center,false);
#endregion

#region State Scripts
	state_script[UIState.idle][UIStateStage.main] = pstr_ags_banner_idle_main;
#endregion