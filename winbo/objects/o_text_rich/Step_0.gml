//GameState Operate
var _game_state,_game_state_operate;
_game_state = global.game_state;
_game_state_operate = game_state_operate[_game_state];

switch(_game_state_operate){
	case UIGameStateOperate.full_step:
		text_rich_step();
	break;
	
	case UIGameStateOperate.no_interaction:
		text_rich_step();
	break;
	
	case UIGameStateOperate.transform_update:
		transform_system_update();
	break;
}
