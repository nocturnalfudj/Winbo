function transform_system_update() {
	//Check if Any Transform has been Updated
	transform_updated_check();
	
	//Default Children to no Update
	for(var _i=0;_i<transform_child_count;_i++){
		with(transform_child[_i]){
			update = false;
		}
	}
	
	//Forced Update
	var _forced_update;
	_forced_update = transform_force_update_all;
	if(_forced_update){
		transform_updated = true;
	}
	
	//If no Update then exit
	if(!transform_updated)
		exit;
	
	#region Handle Transform Updates
		var _delta_time;
		if(transform_animation_time_scale_enable)
			_delta_time = global.delta_time_factor_scaled;
		else
			_delta_time = global.delta_time_factor;
	
		var _transform_system_value_updated;
		_transform_system_value_updated = transform_system_value_updated;
		
		//Reset Operation Array
		var _transform_value_array;
		_transform_value_array = global.transform_system_update_operation_array;
		_transform_value_array[@ TransformValue.x] = 0;
		_transform_value_array[@ TransformValue.y] = 0;
		_transform_value_array[@ TransformValue.xscale] = 1;
		_transform_value_array[@ TransformValue.yscale] = 1;
		_transform_value_array[@ TransformValue.alpha] = 1;
		_transform_value_array[@ TransformValue.angle] = 0;
		_transform_value_array[@ TransformValue.colour] = transform[TransformType.anchor].value[TransformValue.colour].current;
		
		var _transform_parent_distance_relative_to_scale_x,_parent_distance_relative_scale_x;
		var _transform_parent_distance_relative_to_scale_y,_parent_distance_relative_scale_y;
		_transform_parent_distance_relative_to_scale_x = transform_parent_distance_relative_to_scale_x;
		_transform_parent_distance_relative_to_scale_y = transform_parent_distance_relative_to_scale_y;
		_parent_distance_relative_scale_x = 1;
		_parent_distance_relative_scale_y = 1;
		
		#region Parent
			var _parent_inherit_array;
			_parent_inherit_array = transform_parent_inherit;
			with(transform_parent){
				if(_transform_parent_distance_relative_to_scale_x){
					_parent_distance_relative_scale_x = value[TransformValue.xscale];
					
					//If Scale Updated
					//Then children X/Y needs to update 
					if(value_update[TransformValue.xscale] || _forced_update) _transform_system_value_updated[@ TransformValue.x] = true;
				}
				if(_transform_parent_distance_relative_to_scale_y){
					_parent_distance_relative_scale_y = value[TransformValue.yscale];
					
					//If Scale Updated
					//Then children X/Y needs to update 
					if(value_update[TransformValue.yscale] || _forced_update) _transform_system_value_updated[@ TransformValue.y] = true;
				}
				
				for(var _i=0;_i<TransformValue.SIZE;_i++){
					if(_parent_inherit_array[_i]){
						if(value_update[_i] || _forced_update)
							_transform_system_value_updated[@ _i] = true;
					
					
						switch(_i){
							case TransformValue.xscale:
							case TransformValue.yscale:
							case TransformValue.alpha:
								//In these cases multiply the values
								_transform_value_array[@ _i] *= value[_i];
							break;
								
							case TransformValue.colour:
								//In these cases set the values
								_transform_value_array[@ _i] = value[_i];
							break;
									
							default:
								//By default add the values
								_transform_value_array[@ _i] += value[_i];
						}
					}
				}
			}
		#endregion
		
		var _transform_animating;
		//Go Through Each TransformType
		for(var _i=0;_i<TransformType.SIZE;_i++){
			with(transform[_i]){
				//Default Animating to false
				_transform_animating = false;
				
				//Go Through Each Transform Value
				for(var _j=0;_j<TransformValue.SIZE;_j++){
					with(value[_j]){
						//If TransformValue is currently Animating
						if(animating){
							transform_value_update(_delta_time,_j);
									
							if(animating){
								_transform_animating = true;
							}
									
							//Set Transform Value for Object to Updated
							_transform_system_value_updated[@ _j] = true;
						}
							
						//Combine Values from Transforms	
						switch(_j){
							case TransformValue.x:
								//Add the values
								if(_transform_parent_distance_relative_to_scale_x){
									_transform_value_array[@ _j] += current * _parent_distance_relative_scale_x;
								}
								else{
									_transform_value_array[@ _j] += current;
								}
							break;
							case TransformValue.y:
								//Add the values
								if(_transform_parent_distance_relative_to_scale_y){
									_transform_value_array[@ _j] += current * _parent_distance_relative_scale_y;
								}
								else{
									_transform_value_array[@ _j] += current;
								}
							break;
							
							case TransformValue.xscale:
							case TransformValue.yscale:
							case TransformValue.alpha:
								//In these cases multiply the values
								if(_transform_value_array[@ _j] != 0)
									_transform_value_array[@ _j] *= current;
							break;
								
							case TransformValue.colour:
								//Merge Colour
								//if(_i != TransformType.anchor){
								//	_transform_value_array[@ _j] = merge_color(_transform_value_array[@ _j],current,0.5);
								//}
							break;
									
							default:
								//By default add the values
								_transform_value_array[@ _j] += current;
						}
					}
				}
				
				//Set whether or not the Transform is Animating
				animating = _transform_animating;
			}
			
			#region Update Child Values if Anchor
				if(_i == TransformType.anchor){
					var _child_scale_update,_child_scale,_child_scale_enable,_child_relationship_value;
					for(var _j=0;_j<transform_child_count;_j++){
						with(transform_child[_j]){
							//Animate Scale
							with(anchor_child_scale){
								if(animating){
									transform_value_update(_delta_time,-1);
								}
							}
							
							_child_scale = anchor_child_scale.current;
							if(anchor_child_scale.animating)
								_child_scale_update = true;
							else
								_child_scale_update = false;
							
							for(var _k=0;_k<TransformValue.SIZE;_k++){
								//Get Scale Enable for Transform Value
								_child_scale_enable = anchor_child_scale_enable[_k];
								
								//If Transform has been updated
								//OR
								//If Scale has been updated
								if(_transform_system_value_updated[_k] || (_child_scale_update && _child_scale_enable)){
									if(_child_scale_enable){
										_child_relationship_value = anchor_child_relationship[_k] * _child_scale;
									}
									else{
										_child_relationship_value = anchor_child_relationship[_k];
									}
									
									
									switch(_k){
										case TransformValue.xscale:
										case TransformValue.yscale:
										case TransformValue.alpha:
											//In these cases multiply the values
											value[_k] = _transform_value_array[@ _k] * _child_relationship_value;
										break;
								
										case TransformValue.colour:
											//Merge Colour
											//value[_k] = merge_color(_transform_value_array[_k],_child_relationship_value,0.5);
											
											//Too slow, so just ignore
											value[_k] = _transform_value_array[@ _k];
										break;
									
										default:
											//By default add the values
											value[_k] = _transform_value_array[@ _k] + _child_relationship_value;
									}
									
									value_update[_k] = true;
									update = true;
								}
								else{
									value_update[_k] = false;
								}
							}
						}
					}
				}
			#endregion
		}
		
		#region Update Object Values
			var _transform_value;
		
			_transform_value = TransformValue.x;
			if(transform_system_value_updated[_transform_value] || _forced_update){
				x = _transform_value_array[@ _transform_value];
				transform_system_value_updated[_transform_value] = false;
			}
		
			_transform_value = TransformValue.y;
			if(transform_system_value_updated[_transform_value] || _forced_update){
				y = _transform_value_array[@ _transform_value];
				transform_system_value_updated[_transform_value] = false;
			}
		
			_transform_value = TransformValue.xscale;
			if(transform_system_value_updated[_transform_value] || _forced_update){
				image_xscale = _transform_value_array[@ _transform_value];
				
				width = bounding_box_width * image_xscale;
				width_half = width/2;
				
				transform_system_value_updated[_transform_value] = false;
			}
		
			_transform_value = TransformValue.yscale;
			if(transform_system_value_updated[_transform_value] || _forced_update){
				image_yscale = _transform_value_array[@ _transform_value];
				
				height = bounding_box_height * image_yscale;
				height_half = height/2;
				
				transform_system_value_updated[_transform_value] = false;
			}
		
			_transform_value = TransformValue.alpha;
			if(transform_system_value_updated[_transform_value] || _forced_update){
				image_alpha = _transform_value_array[@ _transform_value];
				
				image_alpha = clamp(image_alpha,0,1);
				
				transform_system_value_updated[_transform_value] = false;
			}
		
			_transform_value = TransformValue.angle;
			if(transform_system_value_updated[_transform_value] || _forced_update){
				image_angle = _transform_value_array[@ _transform_value];
				transform_system_value_updated[_transform_value] = false;
			}
		
			_transform_value = TransformValue.colour;
			if(transform_system_value_updated[_transform_value] || _forced_update){
				image_blend = _transform_value_array[@ _transform_value];
				transform_system_value_updated[_transform_value] = false;
			}
		#endregion
	#endregion
	
	//Reset Forced Update
	transform_force_update_all = false;
}