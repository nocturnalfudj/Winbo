/// director_room_enter_gameplay()
/// @param {struct} _request Canonical gameplay transition request.
function director_room_enter_gameplay(_request) {
	with(o_director){
		var _depth_layer;
		_depth_layer = layer_get_id("lyr_depth_object_instances");
		if(_depth_layer != -1){
			layer = _depth_layer;
		}
		
		environment_set(_request.environment_id);
		director_room_path_finding_grid_setup();
		
		if(_request.reset_level_timer){
			level_timer = 0;
		}
		if(_request.reset_level_stats){
			for(var _i = 0; _i < LevelStat.SIZE; _i++){
				level_stats[_i] = 0;
			}
		}
		
		director_spawn_player_all_joined(_request.player_spawn_context);
		
		with(o_player){
			hp = PLAYER_HP_MAX_DEFAULT;
			with(user){
				hp = PLAYER_HP_MAX_DEFAULT;
				alive = true;
			}
		}
		
		with(o_camera){
			if(instance_number(o_player) > 0){
				state = CameraState.follow;
				follow_target_id = o_player;
				follow_target_difference.x = 0;
				follow_target_difference.y = 0;
				follow_method_previous = CameraFollowMethod.lerp_to_targ;
				follow_method = CameraFollowMethod.new_room_snap;
			}
			else{
				state = CameraState.move;
			}
		}
	}
}
