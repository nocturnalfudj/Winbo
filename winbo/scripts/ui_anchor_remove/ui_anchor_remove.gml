/// @function ui_anchor_remove
/// @summary Fade out and destroy a UI object.
/// @param _ui_object Instance to hide.
/// @param {_time_current} [_time_current] Start time of the animation.
/// @param {_time_max} [_time_max] Duration of the animation.
/// @param _curve Easing function used.
function ui_anchor_remove(_ui_object,_time_current,_time_max,_curve){
	with(_ui_object){
		if(state != UIState.destroy){
			var _transform,_target;
			_transform = transform[TransformType.anchor];
			_target = 0;
			if(_time_current == undefined)	_time_current = 0;
			if(_time_max == undefined)		_time_max = 0.2*SECOND;
			if(_curve == undefined)			_curve = ease_quad_out;
			transform_animate_from_current(_transform,TransformValue.alpha,_target,_time_current,_time_max,_curve);
			transform_animate_from_current(_transform,TransformValue.xscale,_target,_time_current,_time_max,_curve);
			transform_animate_from_current(_transform,TransformValue.yscale,_target,_time_current,_time_max,_curve);
		
			//Destroy
			ui_object_state_set(UIState.destroy);
		}
	}
}