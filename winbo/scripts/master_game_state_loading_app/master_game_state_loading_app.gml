/// @function master_game_state_loading_app
/// @summary Handle resource loading when the game starts.
/// @returns {void}
function master_game_state_loading_app() {
	//AUTO FINISH STATE
	//REPLACE WITH LOADING IF NECESSARY
	var _finished_loading;
	_finished_loading = true;
	
	var _texture_group,_texture_group_status;
	
	#region Unload
		_texture_group = "intro";
		_finished_loading = texturegroup_unload_ags(_texture_group,_finished_loading);
	#endregion
	
	#region Load
		//Load Textures
		_finished_loading = texturegroup_load_ags("fonts",_finished_loading);
		_finished_loading = texturegroup_load_ags("main_menu",_finished_loading);
		_finished_loading = texturegroup_load_ags("menu",_finished_loading);
		_finished_loading = texturegroup_load_ags("hud",_finished_loading);
		_finished_loading = texturegroup_load_ags("game",_finished_loading);
	#endregion
	
	//If Finished with Boot
	if(_finished_loading){
		//Go to Game Room
		room_goto(r_game);

		//Game State to Menu
		game_state_set_target(GameState.menu);
	}
}