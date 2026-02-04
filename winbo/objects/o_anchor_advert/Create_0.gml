// Inherit the parent event
event_inherited();

//UI Group
ui_group_set(UIGroup.advert,id);

#region Transform
	var _transform;
	_transform = transform[TransformType.anchor];
	
	//Set Coords to 0,0
	transform_set(_transform,TransformValue.x,0,false);
	transform_set(_transform,TransformValue.y,0,false);
	transform_set_rest(_transform,TransformValue.x,0,false);
	transform_set_rest(_transform,TransformValue.y,0,false);
	
	//Appear
	var _time_current,_time_max,_curve,_target;
	_time_current = -0.2*SECOND;
	_time_max = 0.6*SECOND;
	_curve = ease_back_out;
	_target = 1;
	transform_animate(_transform,TransformValue.alpha,0,_target,_time_current,_time_max,_curve);
	transform_animate(_transform,TransformValue.xscale,0,_target,_time_current,_time_max,_curve);
	transform_animate(_transform,TransformValue.yscale,0,_target,_time_current,_time_max,_curve);
	
	//Transform Update
	transform_system_update();
#endregion

#region Menu Creation
	var _x,_y,_x_center,_y_center,_x_width,_y_height;
	with(o_camera){
		_x_center = width_ini_half;
		_y_center = height_ini_half;
		_x_width = width_ini;
		_y_height = height_ini;
	}
	
	//Fade
	_x = 0;
	_y = 0;
	instance_create_layer(_x,_y,"lyr_advert_back",o_fade_advert);
	
	//Timer
	_x = -100;
	_y = 100;
	with(instance_create_layer(_x,_y,"lyr_advert",o_txtPstr_advert_timer)){
		transform_parent_anchor_child_id = AnchorTransformChild.top_right;
	}
	
	//Stop Button
	_x = 0;
	_y = 0;
	with(instance_create_layer(_x,_y,"lyr_advert",o_btn_stop_advert)){
		transform_parent_anchor_child_id = AnchorTransformChild.center;
	}
#endregion

#region State Scripts
	state_script[UIState.destroy][UIStateStage.main] = anchor_pause_destroy_main;
#endregion