// Inherit the parent event
event_inherited();

//UI Group
ui_group_set(UIGroup.results,id);

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
	transform_animate(_transform,TransformValue.alpha,0,_target,_time_current,_time_max,_curve,false,true);
	transform_animate(_transform,TransformValue.xscale,0,_target,_time_current,_time_max,_curve,false,true);
	transform_animate(_transform,TransformValue.yscale,0,_target,_time_current,_time_max,_curve,false,true);
	
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
	
	//Title
	_x = 0;
	_y = 500;
	with(instance_create_layer(_x,_y,"lyr_pfx_foreground",o_txtPstr_results_title)){
		transform_parent_anchor_child_id = AnchorTransformChild.top_center;
	}
	
	//Continue
	_x = 0;
	_y = -400;
	with(instance_create_layer(_x,_y,"lyr_pfx_foreground",o_txtPstr_results_continue)){
		transform_parent_anchor_child_id = AnchorTransformChild.bottom_center;
	}
	
	//Calculate score on anchor creation
	with(o_director){
		if(level_results_score_data == noone){
			level_results_score_data = level_score_calculate();
		}
	}
	
	//Create stat text posters (label/value pairs)
	var _stat_y_start = -300;
	var _stat_y_spacing = 100;
	var _label_x = -700;  // Left side
	var _value_x = 700;   // Right side
	
	//Stat 1: Collectibles
	_y = _stat_y_start + (_stat_y_spacing * 0);
	with(instance_create_layer(_label_x,_y,"lyr_pfx_foreground",o_txtPstr_results_stat_collectibles_label)){
		transform_parent_anchor_child_id = AnchorTransformChild.center;
	}
	with(instance_create_layer(_value_x,_y,"lyr_pfx_foreground",o_txtPstr_results_stat_collectibles_value)){
		transform_parent_anchor_child_id = AnchorTransformChild.center;
	}
	
	//Stat 2: Talismans
	_y = _stat_y_start + (_stat_y_spacing * 1);
	with(instance_create_layer(_label_x,_y,"lyr_pfx_foreground",o_txtPstr_results_stat_talismans_label)){
		transform_parent_anchor_child_id = AnchorTransformChild.center;
	}
	with(instance_create_layer(_value_x,_y,"lyr_pfx_foreground",o_txtPstr_results_stat_talismans_value)){
		transform_parent_anchor_child_id = AnchorTransformChild.center;
	}
	
	//Stat 3: Enemies
	_y = _stat_y_start + (_stat_y_spacing * 2);
	with(instance_create_layer(_label_x,_y,"lyr_pfx_foreground",o_txtPstr_results_stat_enemies_label)){
		transform_parent_anchor_child_id = AnchorTransformChild.center;
	}
	with(instance_create_layer(_value_x,_y,"lyr_pfx_foreground",o_txtPstr_results_stat_enemies_value)){
		transform_parent_anchor_child_id = AnchorTransformChild.center;
	}
	
	//Stat 4: Hits
	_y = _stat_y_start + (_stat_y_spacing * 3);
	with(instance_create_layer(_label_x,_y,"lyr_pfx_foreground",o_txtPstr_results_stat_hits_label)){
		transform_parent_anchor_child_id = AnchorTransformChild.center;
	}
	with(instance_create_layer(_value_x,_y,"lyr_pfx_foreground",o_txtPstr_results_stat_hits_value)){
		transform_parent_anchor_child_id = AnchorTransformChild.center;
	}
	
	//Stat 5: Deaths
	_y = _stat_y_start + (_stat_y_spacing * 4);
	with(instance_create_layer(_label_x,_y,"lyr_pfx_foreground",o_txtPstr_results_stat_deaths_label)){
		transform_parent_anchor_child_id = AnchorTransformChild.center;
	}
	with(instance_create_layer(_value_x,_y,"lyr_pfx_foreground",o_txtPstr_results_stat_deaths_value)){
		transform_parent_anchor_child_id = AnchorTransformChild.center;
	}
	
	//Stat 6: Time
	_y = _stat_y_start + (_stat_y_spacing * 5);
	with(instance_create_layer(_label_x,_y,"lyr_pfx_foreground",o_txtPstr_results_stat_time_label)){
		transform_parent_anchor_child_id = AnchorTransformChild.center;
	}
	with(instance_create_layer(_value_x,_y,"lyr_pfx_foreground",o_txtPstr_results_stat_time_value)){
		transform_parent_anchor_child_id = AnchorTransformChild.center;
	}
	
	//Total Score (positioned separately at bottom with bigger font)
	_y = 400;
	with(instance_create_layer(_label_x,_y,"lyr_pfx_foreground",o_txtPstr_results_stat_total_label)){
		transform_parent_anchor_child_id = AnchorTransformChild.center;
	}
	with(instance_create_layer(_value_x,_y,"lyr_pfx_foreground",o_txtPstr_results_stat_total_value)){
		transform_parent_anchor_child_id = AnchorTransformChild.center;
	}
#endregion

#region State Scripts
	state_script[UIState.destroy][UIStateStage.main] = anchor_hud_destroy_main;
#endregion