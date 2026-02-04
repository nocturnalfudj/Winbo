//GameState Operate
var _game_state,_game_state_operate;
_game_state = global.game_state;
_game_state_operate = game_state_operate[_game_state];
switch(_game_state_operate){
	case UIGameStateOperate.full_step:
		window_step();
	break;
	
	case UIGameStateOperate.no_interaction:
		window_step_no_interaction();
	break;
	
	case UIGameStateOperate.transform_update:
		//Transform Update
		transform_system_update();
	
		var _surface_redraw;
		_surface_redraw = transform_updated;
	
		with(scroll){
			//Move
			_surface_redraw = movement_drag_pan_update(false,1);
			
			//Transform Update
			transform_system_update();
			
			if(transform_updated)
				_surface_redraw = true;
		}
		
		if(_surface_redraw)
			window_surface_redraw_set(2);
	break;
}