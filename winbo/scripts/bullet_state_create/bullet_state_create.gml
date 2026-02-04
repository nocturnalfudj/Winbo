function bullet_state_create(){
	//Image Random Frame
	if(sprite_get_number(sprite_current) > 1){
		sprite_current_frame = irandom(sprite_get_number(sprite_current));
	}
	
	//Update Mask
	mask_index = sprite_current;
	
	//Grow & Appear
	transform_animate_grow_and_appear(0.1*SECOND);
	var _transform,_target,_time_max,_ease;
	_transform = transform[TransformType.anchor];
	_time_max = create_appear_animation_time_max;
	_ease = create_appear_animation_ease_script_scale;
	
	_target = _transform.value[TransformValue.xscale].rest;
	transform_animate(_transform,TransformValue.xscale,0,_target,0,_time_max,_ease,false);
	
	_target = _transform.value[TransformValue.yscale].rest;
	transform_animate(_transform,TransformValue.yscale,0,_target,0,_time_max,_ease,false);
	
	_target = 1;
	transform_animate(_transform,TransformValue.alpha,0,_target,0,_time_max,create_appear_animation_ease_script_alpha,false);
	
	//State to Idle
	state = BulletState.move;
}