//GameState Operate
var _game_state,_game_state_operate;
_game_state = global.game_state;
_game_state_operate = game_state_operate[_game_state];
switch(_game_state_operate){
	case UIGameStateOperate.full_step:
		slider_step();
	break;
	
	case UIGameStateOperate.no_interaction:
		slider_step_no_interaction();
	break;
	
	case UIGameStateOperate.transform_update:
		//Transform Update
		slider_transform_update();
	break;
}