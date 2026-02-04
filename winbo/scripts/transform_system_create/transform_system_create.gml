function transform_system_create(_use_relative_transform) {
	if(is_undefined(_use_relative_transform)){
		_use_relative_transform = false;
	}
	
	transform[TransformType.anchor] = new Transform(x,y,image_xscale,image_yscale,1,0,c_white);
	
	if(_use_relative_transform)
		transform[TransformType.relative] = new Transform(0,0,1,1,1,0,c_white);
	else
		transform[TransformType.relative] = noone;
	
	#region Update
		transform_system_value_updated[TransformValue.x]		= true;
		transform_system_value_updated[TransformValue.y]		= true;
		transform_system_value_updated[TransformValue.xscale]	= true;
		transform_system_value_updated[TransformValue.yscale]	= true;
		transform_system_value_updated[TransformValue.alpha]	= true;
		transform_system_value_updated[TransformValue.angle]	= true;
		transform_system_value_updated[TransformValue.colour]	= true;
	#endregion
	
	#region Parent
		transform_parent = noone;
		transform_parent_anchor_child_id = AnchorTransformChild.top_left;	//This is 0, which by default is the anchor child that has a no-difference relationship with the anchor transform
		
		transform_parent_inherit[TransformValue.x]		= true;
		transform_parent_inherit[TransformValue.y]		= true;
		transform_parent_inherit[TransformValue.xscale]	= true;
		transform_parent_inherit[TransformValue.yscale]	= true;
		transform_parent_inherit[TransformValue.alpha]	= true;
		transform_parent_inherit[TransformValue.angle]	= true;
		transform_parent_inherit[TransformValue.colour]	= false;
		
		transform_parent_distance_relative_to_scale_x = true;
		transform_parent_distance_relative_to_scale_y = true;
	#endregion
	
	#region Child
		transform_child[0] = noone;
		transform_child_count = 0;
	#endregion
	
	#region Scale
		var _xscale,_yscale;
		_xscale = 1;
		_yscale = 1;
		for(var _i=0;_i<TransformType.SIZE;_i++){
			with(transform[_i]){
				_xscale *= value[TransformValue.xscale].current;
				_yscale *= value[TransformValue.yscale].current;
			}
		}
		
		with(transform_parent){
			_xscale *= value[TransformValue.xscale];
			_yscale *= value[TransformValue.yscale];
		}
		
		image_xscale = _xscale;
		image_yscale = _yscale;
	#endregion
	
	transform_updated = false;
	
	transform_force_update_all = true;	//All transform systems need to force an update when they are created, so this is set to true initially
	
	//Whether or not the transform uses timescale for animation
	//default to false
	//true is for anything that should obey slow/fast motion
	transform_animation_time_scale_enable = false;
}