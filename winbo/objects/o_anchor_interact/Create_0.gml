// Inherit the parent event
event_inherited();

//UI Group
ui_group_set(UIGroup.interact_system,id);

//GameState Operate
game_state_operate[GameState.play] = UIGameStateOperate.full_step;

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
	_time_current = 0;//-0.2*SECOND;
	_time_max = 0.2*SECOND;
	_curve = ease_back_out;
	_target = 1;
	transform_animate(_transform,TransformValue.alpha,0,_target,_time_current,_time_max,_curve);
	transform_animate(_transform,TransformValue.xscale,0,_target,_time_current,_time_max,_curve);
	transform_animate(_transform,TransformValue.yscale,0,_target,_time_current,_time_max,_curve);
	
	//Transform Update
	transform_system_update();
#endregion

#region UI Creation
	var _x,_y,_x_center,_y_center,_x_width,_y_height;
	with(o_camera){
		_x_center = width_ini_half;
		_y_center = height_ini_half;
		_x_width = width_ini;
		_y_height = height_ini;
	}
#endregion

//Space
interact_space = noone;

//Interact User
interact_user_id = noone;

//Distribution Script
distribution_script = anchor_interact_group_distribution_list_horizontal;

//Position Relative Instance
position_relative_instance = noone;
position_relative_x = 0;
position_relative_y = 0;

//Instance References
interact_system_instance = noone;
interactor_instance = noone;

//Interact UI Children
interact_ui_children = ds_list_create();

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = anchor_interact_create_main;
	state_script[UIState.idle][UIStateStage.main] = anchor_interact_idle_main;
	state_script[UIState.destroy][UIStateStage.main] = anchor_interact_destroy_main;
#endregion