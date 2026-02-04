/// @function ui_bars_hide
/// @summary Animate UI bars off screen.
/// @param _bar_object Instance of the bar container to hide.
/// @param _distance_off_screen Optional offset beyond the screen edge.
/// @returns {void}
function ui_bars_hide(_bar_object,_distance_off_screen){
	//Default Distance Off Screen
	if(_distance_off_screen == undefined)
		_distance_off_screen = 10;
		
	//Get Camera Dimensions
	var _camera_width,_camera_height;
	with(o_camera){
		_camera_width = width_ini;
		_camera_height = height_ini;
	}
	
	//Transform Animation Variables
	var _transform,_time_current,_time_max,_curve,_target;
	
	//Hide Each Bar Depending on their Direciton
	with(_bar_object){
		var _transform,_time_current,_time_max,_curve,_target;
		_transform = transform[TransformType.anchor];
		_time_current = 0;
		_time_max = 0.3*SECOND;
		_curve = ease_quad_out;
	
		switch(bar_direction){
			case BarDirection.up:
				_target = -1 * _distance_off_screen;
							
				transform_animate_from_current(_transform,TransformValue.y,_target,_time_current,_time_max,_curve);
			break;
		
			case BarDirection.down:
				_target = _camera_height + _distance_off_screen;
							
				transform_animate_from_current(_transform,TransformValue.y,_target,_time_current,_time_max,_curve);
			break;
		
			case BarDirection.left:
				_target = -1 * _distance_off_screen;
							
				transform_animate_from_current(_transform,TransformValue.x,_target,_time_current,_time_max,_curve);
			break;
		
			case BarDirection.right:
				_target = _camera_width + _distance_off_screen;
							
				transform_animate_from_current(_transform,TransformValue.x,_target,_time_current,_time_max,_curve);
			break;
		}
	}
}