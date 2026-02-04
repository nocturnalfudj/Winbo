#region State
	enum UIState{
		create,
		idle,
		hover,
		down,
		edit,
		active,
		selected,
		destroy,
		deactivate,
		activate
	}

	state = UIState.create;
#endregion

#region GameState Operate
	enum UIGameStateOperate{
		full_step,
		no_interaction,
		transform_update,
		nothing,
		
		SIZE
	}
	
	//Default No Interaction All Game States
	for(var _i=0;_i<GameState.SIZE;_i++){
		game_state_operate[_i] = UIGameStateOperate.full_step;
	}

	//Specific Nothing Game States
	game_state_operate[GameState.boot]				= UIGameStateOperate.nothing;
	game_state_operate[GameState.loading_app]		= UIGameStateOperate.nothing;
	game_state_operate[GameState.os_paused]			= UIGameStateOperate.nothing;
	game_state_operate[GameState.freeze]			= UIGameStateOperate.nothing;
	game_state_operate[GameState.stop]				= UIGameStateOperate.nothing;
	game_state_operate[GameState.close]				= UIGameStateOperate.nothing;
#endregion

#region Interaction
	mouse_collision = false;
	mouse_collision_enable = true;
	mouse_collision_down_required = true;
	
	mouse_device = 0;
	
	mouse_control_button = mb_left;
	input_active_pressed_required = true;
#endregion

//GUI
gui = true;

//HUD
hud = false;

//Live
live = false;

//Window
window = noone;

#region Notification
	notification_active = false;
	notification_sprite = noone;
	notification_x = 0;
	notification_y = 0;
#endregion

//Create Dimensions System
dimension_system_create();

//Camera Visible System
camera_visible_system_create();

//Create Transform System
transform_system_create();

//Start Invisible
image_alpha = 0;

#region State Scripts
	enum UIStateStage{
		start,
		main,
		stop,
		
		SIZE
	}
	
	var _state;
	_state = UIState.create;
	state_script[_state][UIStateStage.start] = noone;
	state_script[_state][UIStateStage.main] = noone;
	state_script[_state][UIStateStage.stop] = noone;
	
	_state = UIState.idle;
	state_script[_state][UIStateStage.start] = noone;
	state_script[_state][UIStateStage.main] = noone;
	state_script[_state][UIStateStage.stop] = noone;
	
	_state = UIState.hover;
	state_script[_state][UIStateStage.start] = noone;
	state_script[_state][UIStateStage.main] = noone;
	state_script[_state][UIStateStage.stop] = noone;
	
	_state = UIState.down;
	state_script[_state][UIStateStage.start] = noone;
	state_script[_state][UIStateStage.main] = noone;
	state_script[_state][UIStateStage.stop] = noone;
	
	_state = UIState.edit;
	state_script[_state][UIStateStage.start] = noone;
	state_script[_state][UIStateStage.main] = noone;
	state_script[_state][UIStateStage.stop] = noone;
	
	_state = UIState.active;
	state_script[_state][UIStateStage.start] = noone;
	state_script[_state][UIStateStage.main] = noone;
	state_script[_state][UIStateStage.stop] = noone;
	
	_state = UIState.selected;
	state_script[_state][UIStateStage.start] = noone;
	state_script[_state][UIStateStage.main] = noone;
	state_script[_state][UIStateStage.stop] = noone;
	
	_state = UIState.destroy;
	state_script[_state][UIStateStage.start] = noone;
	state_script[_state][UIStateStage.main] = ui_object_state_destroy_main;
	state_script[_state][UIStateStage.stop] = noone;
	
	_state = UIState.activate;
	state_script[_state][UIStateStage.start] = noone;
	state_script[_state][UIStateStage.main] = noone;
	state_script[_state][UIStateStage.stop] = noone;
	
	_state = UIState.deactivate;
	state_script[_state][UIStateStage.start] = noone;
	state_script[_state][UIStateStage.main] = noone;
	state_script[_state][UIStateStage.stop] = noone;
#endregion