/// master_game_state_loading()
function master_game_state_loading() {
	var _request;
	_request = gameplay_loading_request;
	if(_request == noone){
		gameplay_loading_phase = GameplayLoadingPhase.finished;
		master_screen_fade_set_immediate(0);
		gameplay_loading_active = false;
		return;
	}
	
	var _copy_groups;
	_copy_groups = function(_source) {
		var _group_count;
		_group_count = array_length(_source);
		
		var _copy;
		_copy = array_create(_group_count);
		for(var _i = 0; _i < _group_count; _i++){
			_copy[_i] = _source[_i];
		}
		
		return _copy;
	};
	
	var _get_target_game_state;
	_get_target_game_state = function(_request) {
		var _target_game_state;
		_target_game_state = _request.target_game_state;
		if(is_undefined(_target_game_state)){
			_target_game_state = GameState.play;
		}
		
		return _target_game_state;
	};

	var _get_loading_game_state;
	_get_loading_game_state = function(_request) {
		var _target_game_state;
		_target_game_state = _request.target_game_state;
		if(is_undefined(_target_game_state)){
			_target_game_state = GameState.play;
		}
		if(_target_game_state == GameState.play){
			return GameState.pre_game;
		}

		return _target_game_state;
	};

	var _get_origin_game_state;
	_get_origin_game_state = function(_request) {
		var _origin_game_state;
		_origin_game_state = _request.origin_game_state;
		if(is_undefined(_origin_game_state)){
			_origin_game_state = GameState.play;
		}
		
		return _origin_game_state;
	};

	var _force_game_state;
	_force_game_state = function(_game_state) {
		if(global.game_state != _game_state || global.game_state_target != noone){
			global.game_state = _game_state;
			global.game_state_target = noone;
			global.game_state_one_step_complete = false;
		}
	};

	var _phase_fail;
	_phase_fail = function(_message) {
		sdm(_message, LOG_COLOUR_COMMAND_ERROR);
		gameplay_loading_request = noone;
		gameplay_loading_phase = GameplayLoadingPhase.finished;
		gameplay_loading_active = false;
		master_screen_fade_set_immediate(0);
		with(o_director){
			level_transitioning = false;
		}
		
		var _origin_game_state;
		_origin_game_state = _request.origin_game_state;
		if(is_undefined(_origin_game_state)){
			_origin_game_state = GameState.play;
		}
		
		_force_game_state(_origin_game_state);
	};
	
	var _phase_script_run;
	_phase_script_run = function(_script, _request, _phase_name) {
		if(is_undefined(_script) || _script == noone){
			return true;
		}
		
		if(script_execute(_script, _request) == false){
			_phase_fail("Gameplay transition phase failed: " + _phase_name);
			return false;
		}
		
		return true;
	};

	var _player_ready;
	_player_ready = function(_request) {
		var _target_game_state;
		_target_game_state = _request.target_game_state;
		if(is_undefined(_target_game_state)){
			_target_game_state = GameState.play;
		}
		
		if(_target_game_state != GameState.play){
			return true;
		}
		
		return instance_exists(o_player);
	};

	var _camera_ready;
	_camera_ready = function(_request) {
		var _target_game_state;
		_target_game_state = _request.target_game_state;
		if(is_undefined(_target_game_state)){
			_target_game_state = GameState.play;
		}
		
		if(_target_game_state != GameState.play){
			return true;
		}
		
		if(!instance_exists(o_player) || !instance_exists(o_camera)){
			return false;
		}
		
		if(o_camera.state != CameraState.follow){
			return false;
		}
		
		if(o_camera.follow_target_id != o_player){
			return false;
		}
		
		if(o_camera.follow_method == CameraFollowMethod.new_room_snap){
			return false;
		}
		
		return true;
	};
	
	switch(gameplay_loading_phase){
		case GameplayLoadingPhase.transition_in:
			if(_request.start_black){
				master_screen_fade_set_immediate(1);
				gameplay_loading_phase = GameplayLoadingPhase.resolve_target;
			}
			else{
				if(!screen_fade_active && screen_fade_alpha < 1){
					master_screen_fade_begin(screen_fade_alpha, 1, SCREEN_FADE_GAMEPLAY_TO_BLACK_TIME);
				}
				
				if(!screen_fade_active && screen_fade_alpha >= 1){
					gameplay_loading_phase = GameplayLoadingPhase.resolve_target;
				}
			}
		break;
		
		case GameplayLoadingPhase.resolve_target:
			if(_phase_script_run(_request.resolve_script, _request, "resolve_target")){
				gameplay_loading_phase = GameplayLoadingPhase.teardown_current_room;
			}
		break;
		
		case GameplayLoadingPhase.teardown_current_room:
			if(_phase_script_run(_request.teardown_script, _request, "teardown_current_room")){
				gameplay_loading_phase = GameplayLoadingPhase.load_assets;
			}
		break;
		
		case GameplayLoadingPhase.load_assets:
			var _finished_loading;
			_finished_loading = true;
			for(var _i = 0; _i < array_length(_request.load_groups); _i++){
				_finished_loading = texturegroup_load_ags(_request.load_groups[_i], _finished_loading);
			}
			
			if(_finished_loading){
				gameplay_loading_phase = GameplayLoadingPhase.goto_target_room;
			}
		break;
		
		case GameplayLoadingPhase.goto_target_room:
			if(room != _request.target_room){
				room_goto(_request.target_room);
			}
			gameplay_loading_phase = GameplayLoadingPhase.wait_target_room;
		break;
		
		case GameplayLoadingPhase.wait_target_room:
			if(room == _request.target_room){
				gameplay_loading_phase = GameplayLoadingPhase.setup_target_room;
			}
		break;
		
		case GameplayLoadingPhase.setup_target_room:
			if(room == _request.target_room){
				if(_phase_script_run(_request.setup_script, _request, "setup_target_room")){
					gameplay_loading_phase = GameplayLoadingPhase.enter_target_state;
				}
			}
		break;
		
		case GameplayLoadingPhase.enter_target_state:
			var _target_game_state;
			_target_game_state = _get_target_game_state(_request);
			_force_game_state(_get_loading_game_state(_request));
			
			if(_target_game_state == GameState.play || _target_game_state == GameState.start){
				with(o_audio){
					audio_gameplay_music_apply(_request.target_room);
				}
			}
			gameplay_loading_phase = GameplayLoadingPhase.wait_for_player;
		break;

		case GameplayLoadingPhase.wait_for_player:
			if(_player_ready(_request)){
				gameplay_loading_phase = GameplayLoadingPhase.wait_for_camera;
			}
		break;

		case GameplayLoadingPhase.wait_for_camera:
			if(_camera_ready(_request)){
				gameplay_loading_phase = GameplayLoadingPhase.finalize_target_room;
			}
		break;

		case GameplayLoadingPhase.finalize_target_room:
			if(_phase_script_run(_request.finalize_script, _request, "finalize_target_room")){
				gameplay_loading_phase = GameplayLoadingPhase.unload_previous_assets;
			}
		break;
		
		case GameplayLoadingPhase.unload_previous_assets:
			var _finished_unloading;
			_finished_unloading = true;
			
			for(var _i = 0; _i < array_length(gameplay_loading_groups_current); _i++){
				var _loaded_group;
				_loaded_group = gameplay_loading_groups_current[_i];
				
				var _keep_group;
				_keep_group = false;
				for(var _j = 0; _j < array_length(_request.load_groups); _j++){
					if(_request.load_groups[_j] == _loaded_group){
						_keep_group = true;
						break;
					}
				}
				
				if(!_keep_group){
					_finished_unloading = texturegroup_unload_ags(_loaded_group, _finished_unloading);
				}
			}
			
			if(_finished_unloading){
				gameplay_loading_groups_current = _copy_groups(_request.load_groups);
				gameplay_loading_phase = GameplayLoadingPhase.garbage_collect;
			}
		break;
		
		case GameplayLoadingPhase.garbage_collect:
			gc_collect();
			gameplay_loading_phase = GameplayLoadingPhase.transition_out;
		break;
		
		case GameplayLoadingPhase.transition_out:
			if(!screen_fade_active && screen_fade_alpha > 0){
				master_screen_fade_begin(screen_fade_alpha, 0, SCREEN_FADE_GAMEPLAY_FROM_BLACK_TIME);
			}
			
			if(!screen_fade_active && screen_fade_alpha <= 0){
				gameplay_loading_phase = GameplayLoadingPhase.finished;
			}
		break;
		
		case GameplayLoadingPhase.finished:
			_force_game_state(_get_target_game_state(_request));
			gameplay_loading_request = noone;
			master_screen_fade_set_immediate(0);
			gameplay_loading_active = false;
		break;
	}
}
