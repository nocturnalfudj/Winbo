/// @function camera_state_follow
/// @summary Follow one or more targets while keeping them on screen.
function camera_state_follow() {
	#region Update Targets Coordinates IF Target Exists
		//Initialise Follow Target Position as 0
		var _follow_targ_x,_follow_targ_y,_follow_targ_count;
		_follow_targ_count = 0;
		_follow_targ_x = 0;
		_follow_targ_y = 0;
		
		if(instance_exists(follow_target_id)){
			var _follow_target_user_needs_to_be_alive,_follow_target_user_is_alive;
			_follow_target_user_needs_to_be_alive = follow_target_user_needs_to_be_alive;
				
			#region Calculate Follow Target Position
				//Go Through All Follow Targets
				with(follow_target_id){
					//If Target is User
					if(_follow_target_user_needs_to_be_alive){
						//If User is Alive
						if(variable_instance_exists(id,"user") && _follow_target_user_needs_to_be_alive){
							//Default to User Not Being Alive
							_follow_target_user_is_alive = false;
							
							//Check User Data
							with(user){
								// Consider the player a valid target if they are currently dying
								var _is_dying = (variable_instance_exists(other, "state") && (other.state == PlayerState.death || other.state == PlayerState.destroy));
								if(alive || _is_dying){
									_follow_target_user_is_alive = true;
								}
							}
							
							//If Alive
							if(_follow_target_user_is_alive){
								//Consider Player for Target Position
								_follow_targ_count++;
								_follow_targ_x += x;
								_follow_targ_y += y;
							}
						}
					}
					else{
						//Consider Target for Target Position
						_follow_targ_count++;
						_follow_targ_x += x;
						_follow_targ_y += y;
					}
				}
				
				//Find the Average Target Position
				if(_follow_targ_count > 0){
					_follow_targ_x /= _follow_targ_count;
					_follow_targ_y /= _follow_targ_count;
				}
				else{
					_follow_targ_x = follow_target.x;
					_follow_targ_y = follow_target.y;
				}
			#endregion
			
			#region Multi Target Zoom
				//Get the Distance Targets are from Target Position
				var _distance_from_targ;
				_distance_from_targ = -1;
				with(follow_target_id){
					//If Target is User
					if(_follow_target_user_needs_to_be_alive ){
						//If User is Alive
						if(variable_instance_exists(id,"user") && _follow_target_user_needs_to_be_alive){
							//Default to User Not Being Alive
							_follow_target_user_is_alive = false;
							
							//Check User Data
							with(user){
								// Consider the player a valid target if they are currently dying
								var _is_dying = (variable_instance_exists(other, "state") && (other.state == PlayerState.death || other.state == PlayerState.destroy));
								if(alive || _is_dying){
									_follow_target_user_is_alive = true;
								}
							}
							
							//If Alive
							if(_follow_target_user_is_alive){
								_distance_from_targ = point_distance(x,y,_follow_targ_x,_follow_targ_y);
							
								//All Targets Should be Equal Distance so Only One Calculation Needed
								break;
							}
						}
					}
					else{
						_distance_from_targ = point_distance(x,y,_follow_targ_x,_follow_targ_y);
						
						//All Targets Should be Equal Distance so Only One Calculation Needed
						break;
					}
				}
				
				if(_distance_from_targ != -1){
					//Calculate Multi Target Zoom Value
					var _multi_target_zoom_distance_percent,_multi_target_zoom_target;
					_distance_from_targ = clamp(_distance_from_targ,CAMERA_ZOOM_ANCHOR_PLAY_MULTI_FOLLOW_TARGET_DISTANCE_MIN,CAMERA_ZOOM_ANCHOR_PLAY_MULTI_FOLLOW_TARGET_DISTANCE_MAX);
					_multi_target_zoom_distance_percent = (_distance_from_targ - CAMERA_ZOOM_ANCHOR_PLAY_MULTI_FOLLOW_TARGET_DISTANCE_MIN) / (CAMERA_ZOOM_ANCHOR_PLAY_MULTI_FOLLOW_TARGET_DISTANCE_MAX - CAMERA_ZOOM_ANCHOR_PLAY_MULTI_FOLLOW_TARGET_DISTANCE_MIN);
					_multi_target_zoom_target = zoom_anchor.rest + _multi_target_zoom_distance_percent;
				
					zoom_anchor.target = _multi_target_zoom_target;
					zoom_anchor.current = lerp(zoom_anchor.current,_multi_target_zoom_target,0.15);
				}
			#endregion
			
			#region Player Aim Offset
				if(follow_target_user_aim_offset_enable){
					var _aim_target_x,_aim_target_y;
					if(IS_MOBILE){
						//Assume Singleplayer in Mobile
						if(o_ui.mouse_active[0]){
							with(o_player){
								var _drag_dist;
								_drag_dist = 500 * input_move_magnitude_prev;
								_aim_target_x = lengthdir_x(_drag_dist,input_move_direction);
								_aim_target_y = lengthdir_y(_drag_dist/2,input_move_direction);
					
								//_follow_targ_x = _aim_target_x;//lerp(_follow_targ_x,_aim_target_x,0.5);
								//_follow_targ_y = _aim_target_y;//lerp(_follow_targ_y,_aim_target_y,0.5);
							}
						
							follow_offset_target.x = _aim_target_x;
							follow_offset_target.y = _aim_target_y;
						}
						else{
							follow_offset_target.x = 0;
							follow_offset_target.y = 0;
						}
					}
					else{
						_aim_target_x = 0;
						_aim_target_y = 0;
					
						with(o_input){
							var _user;
							for(var _i=0;_i<USER_NUM_MAX;_i++){
								_user = user[_i];
						
								// Consider the player a valid target if they are currently dying
								var _instance = other.follow_target_id; // o_camera's follow_target_id
								var _is_dying = false;
								if(instance_exists(_instance)){
									with(_instance){
										if(variable_instance_exists(id, "state") && (state == PlayerState.death || state == PlayerState.destroy)){
											_is_dying = true;
										}
									}
								}

								if(_follow_target_user_needs_to_be_alive && _user.joined && (_user.alive || _is_dying)){
									if(_user.gamepad_using){
										_aim_target_x += _user.gamepad_aim_x;
										_aim_target_y += _user.gamepad_aim_y;
									}
									else if(_i == 0){
										_aim_target_x += mouse_x;
										_aim_target_y += mouse_y;
									}
								}
							}
						}
				
						if(_follow_targ_count > 0){
							_aim_target_x /= _follow_targ_count;
							_aim_target_y /= _follow_targ_count;
						}
						else{
							_aim_target_x = 0;
							_aim_target_y = 0;
						}
				
						_follow_targ_x = lerp(_follow_targ_x,_aim_target_x,0.25);
						_follow_targ_y = lerp(_follow_targ_y,_aim_target_y,0.25);
					}
				}
			#endregion
		
			#region Follow Offset Target
				follow_offset.LerpFactors(follow_offset_target,CAMERA_FOLLOW_OFFSET_LERP_FACTOR_X,CAMERA_FOLLOW_OFFSET_LERP_FACTOR_Y);
			
				_follow_targ_x += follow_offset.x;
				_follow_targ_y += follow_offset.y;
			
				if(position_clamp_enable_x)
					_follow_targ_x = clamp(_follow_targ_x,position_clamp_min.x,position_clamp_max.x);
				
				if(position_clamp_enable_y)
					_follow_targ_y = clamp(_follow_targ_y,position_clamp_min.y,position_clamp_max.y);
			
				follow_target.Set(_follow_targ_x,_follow_targ_y);
			#endregion
		}
		else{
			stationary_target.Copy(follow_target);
			state = CameraState.stationary;
		}
	#endregion

	#region Follow Method
		var _transform;
		_transform = transform[TransformType.anchor];
		
		var _x,_y;
	
		switch(follow_method){
			case CameraFollowMethod.lerp_to_targ:
				_x = _transform.value[TransformValue.x].current;
				_y = _transform.value[TransformValue.y].current;
			
				_x = lerp_with_gap_close(_x,follow_target.x,CAMERA_FOLLOW_TARG_LERP_FACTOR_X,0.1,true);
				
				// Apply jump dampening to Y-axis following
				var _camera_y_lerp_factor = CAMERA_FOLLOW_TARG_LERP_FACTOR_Y;
				
				if(follow_jump_dampening_enable){
					// Only dampen when camera would move UP (target is above current position)
					if(follow_target.y < _y){
						_camera_y_lerp_factor *= follow_jump_dampening_factor;
					}
					
					// Lerp the dampening factor back to 1.0
					follow_jump_dampening_factor = lerp(follow_jump_dampening_factor, 1, follow_jump_dampening_lerp_speed);
				}
				
				_y = lerp_with_gap_close(_y,follow_target.y,_camera_y_lerp_factor,0.1,true);
				
				transform_set(_transform,TransformValue.x,_x,false);
				transform_set(_transform,TransformValue.y,_y,false);
			break;
		
			case CameraFollowMethod.curve_to_targ:
				with(_transform){
					_x = value[TransformValue.x].current;
					_y = value[TransformValue.y].current;
				}
				
				var _x_target,_y_target;
				_x_target = follow_target.x;
				_y_target = follow_target.y;
				
				if(_transform.value[TransformValue.x].target != _x_target)
					transform_animate(_transform,TransformValue.x,_x,_x_target,0,CAMERA_FOLLOW_TARG_CURVE_TIME_MAX_X,CAMERA_FOLLOW_TARG_CURVE_X);
					
				if(_transform.value[TransformValue.y].target != _y_target)
					transform_animate(_transform,TransformValue.y,_y,_y_target,0,CAMERA_FOLLOW_TARG_CURVE_TIME_MAX_Y,CAMERA_FOLLOW_TARG_CURVE_Y);
			break;
			
			case CameraFollowMethod.new_room_snap:
				if(_follow_targ_count > 0){
					var _x,_y;
					_x = follow_target.x - follow_target_difference.x;
					_y = follow_target.y - follow_target_difference.y;
				
					x = _x;
					y = _y;
					transform_set(_transform,TransformValue.x,_x,false);
					transform_set(_transform,TransformValue.y,_y,false);
				
					//Reset the Follow Method to Pre Room Change
					follow_method = follow_method_previous;
				}
			break;
		}
	#endregion
}