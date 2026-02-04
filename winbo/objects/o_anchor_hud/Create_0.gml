// Inherit the parent event
event_inherited();

//UI Group
ui_group_set(UIGroup.hud,id);

#region Transform
	var _transform;
	_transform = transform[TransformType.anchor];
	
	//Set Coords to 0,0
	transform_set(_transform,TransformValue.x,0,false);
	transform_set(_transform,TransformValue.y,0,false);
	transform_set_rest(_transform,TransformValue.x,0,false);
	transform_set_rest(_transform,TransformValue.y,0,false);
	
	//Appear
	//var _time_current,_time_max,_curve,_target;
	//_time_current = -0.2*SECOND;
	//_time_max = 0.6*SECOND;
	//_curve = ease_back_out;
	//_target = 1;
	//transform_animate(_transform,TransformValue.alpha,0,_target,_time_current,_time_max,_curve);
	//transform_animate(_transform,TransformValue.xscale,0,_target,_time_current,_time_max,_curve);
	//transform_animate(_transform,TransformValue.yscale,0,_target,_time_current,_time_max,_curve);
	
	transform_set(_transform,TransformValue.alpha,1,false);
	transform_set(_transform,TransformValue.xscale,1,false);
	transform_set(_transform,TransformValue.yscale,1,false);
	
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
	
	#macro UI_HUD_SCALE 0.75
	
	//Damage Fade
	_x = 0;
	_y = 0;
	instance_create_layer(_x,_y,"lyr_pfx_foreground",o_fade_hud_damage);
	
	
	var _hud_animate_in_time_delay;
	_hud_animate_in_time_delay = 1 * SECOND;
	
	#region Side Bar & Shadow
		//Shadow
		_x = 0;
		_y = 0;
		with(instance_create_layer(_x,_y,"lyr_hud_back",o_pstr_hud_shadow)){
			transform_parent_anchor_child_id = AnchorTransformChild.top_left;
			
			//Appear
			var _transform,_time_current,_time_max,_curve,_target;
			_transform = transform[TransformType.anchor];
			_time_current = -_hud_animate_in_time_delay;
			_time_max = 0.6*SECOND;
			_curve = ease_back_out;
			_target = 1;
			transform_animate(_transform,TransformValue.alpha,0,_target,_time_current,_time_max,_curve);
			transform_animate(_transform,TransformValue.xscale,0,_target,_time_current,_time_max,_curve);
		}
		
		//Sidebar
		_x = 0;
		_y = 25;
		with(instance_create_layer(_x,_y,"lyr_hud",o_pstr_hud_side_bar)){
			transform_parent_anchor_child_id = AnchorTransformChild.top_left;
			
			//Appear
			var _transform,_time_current,_time_max,_curve,_target;
			_transform = transform[TransformType.anchor];
			_time_current = -_hud_animate_in_time_delay;
			_time_max = 0.6*SECOND;
			_curve = ease_back_out;
			_target = 1;
			transform_animate(_transform,TransformValue.alpha,0,_target,_time_current,_time_max,_curve);
			transform_animate(_transform,TransformValue.xscale,0,_target,_time_current,_time_max,_curve);
		}
	#endregion
	
	//Winbo Lives
	_x = 250;
	_y = 200;
	with(instance_create_layer(_x,_y,"lyr_hud",o_pstr_winbo_lives)){
		transform_parent_anchor_child_id = AnchorTransformChild.top_left;
		
		//Appear
		var _transform,_time_current,_time_max,_curve,_target;
		_transform = transform[TransformType.anchor];
		_time_current = -_hud_animate_in_time_delay;
		_time_max = 0.6*SECOND;
		_curve = ease_back_out;
		_target = 1;
		transform_animate(_transform,TransformValue.alpha,0,_target,_time_current,_time_max,_curve);
		transform_animate(_transform,TransformValue.yscale,0,_target,_time_current,_time_max,_curve);
	}
	
	#region Winbo HP
		_x = 250;
		_y = 450;
		with(instance_create_layer(_x,_y,"lyr_hud",o_pstr_winbo_hp)){
			transform_parent_anchor_child_id = AnchorTransformChild.top_left;
		
			hp_id = 0;
			
			//Appear
			var _transform,_time_current,_time_max,_curve,_target;
			_transform = transform[TransformType.anchor];
			_time_current = -(_hud_animate_in_time_delay + (SECOND * 0.2 * hp_id));
			_time_max = 0.6*SECOND;
			_curve = ease_back_out;
			_target = 1;
			transform_animate(_transform,TransformValue.alpha,0,_target,_time_current,_time_max,_curve);
			transform_animate(_transform,TransformValue.xscale,0,_target,_time_current,_time_max,_curve);
			transform_animate(_transform,TransformValue.yscale,0,_target,_time_current,_time_max,_curve);
		}
		
		_x = 420;
		_y = 450;
		with(instance_create_layer(_x,_y,"lyr_hud",o_pstr_winbo_hp)){
			transform_parent_anchor_child_id = AnchorTransformChild.top_left;
		
			hp_id = 1;
			
			//Appear
			var _transform,_time_current,_time_max,_curve,_target;
			_transform = transform[TransformType.anchor];
			_time_current = -(_hud_animate_in_time_delay + (SECOND * 0.2 * hp_id));
			_time_max = 0.6*SECOND;
			_curve = ease_back_out;
			_target = 1;
			transform_animate(_transform,TransformValue.alpha,0,_target,_time_current,_time_max,_curve);
			transform_animate(_transform,TransformValue.xscale,0,_target,_time_current,_time_max,_curve);
			transform_animate(_transform,TransformValue.yscale,0,_target,_time_current,_time_max,_curve);
		}
	#endregion
	
	#region Score
		//Poster
		_x = -350;
		_y = 620;
		with(instance_create_layer(_x,_y,"lyr_hud",o_pstr_hud_score)){
			transform_parent_anchor_child_id = AnchorTransformChild.top_left;
			
			//Appear
			var _transform,_time_current,_time_max,_curve,_target;
			_transform = transform[TransformType.anchor];
			_time_current = -_hud_animate_in_time_delay;
			_time_max = 0.6*SECOND;
			_curve = ease_back_out;
			_target = 1;
			transform_animate_from_current(_transform,TransformValue.x,350,_time_current,_time_max,_curve);
			transform_animate(_transform,TransformValue.angle,45,0,_time_current,_time_max,_curve);
			transform_animate(_transform,TransformValue.alpha,0,_target,_time_current,_time_max,_curve);
			transform_animate(_transform,TransformValue.xscale,0,_target,_time_current,_time_max,_curve);
			transform_animate(_transform,TransformValue.yscale,0,_target,_time_current,_time_max,_curve);
		}
		
		//Text Poster
		_x = -332;
		_y = 750;
		with(instance_create_layer(_x,_y,"lyr_hud",o_txtPstr_cash)){
			transform_parent_anchor_child_id = AnchorTransformChild.top_left;
			
			//Appear
			var _transform,_time_current,_time_max,_curve,_target;
			_transform = transform[TransformType.anchor];
			_time_current = -_hud_animate_in_time_delay;
			_time_max = 0.6*SECOND;
			_curve = ease_back_out;
			_target = 1;
			transform_animate_from_current(_transform,TransformValue.x,332,_time_current,_time_max,_curve);	
			transform_animate(_transform,TransformValue.angle,45,0,_time_current,_time_max,_curve);
			transform_animate(_transform,TransformValue.alpha,0,_target,_time_current,_time_max,_curve);
			transform_animate(_transform,TransformValue.xscale,0,_target,_time_current,_time_max,_curve);
			transform_animate(_transform,TransformValue.yscale,0,_target,_time_current,_time_max,_curve);
		}
	#endregion
#endregion

#region State Scripts
	state_script[UIState.destroy][UIStateStage.main] = anchor_hud_destroy_main;
#endregion