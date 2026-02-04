function sldr_resolution_active_main() {
	if(value_current != value_previous){
		var _value_current;
		_value_current = round(value_current);
	
		var _res_w,_res_h,_new_res;
		_new_res = false;
		with(o_camera){
			_res_w = resolution[_value_current][RES_W];
			_res_h = resolution[_value_current][RES_H];
		
			if(_value_current != resolution_slot_current){
				_new_res = true;
			
				resolution_slot_next = _value_current;
			}
		}
	
		subtitle_string = string(_res_w) + "  *  " + string(_res_h);
	
		with(o_btn_resolution_apply){
			if(_new_res){
				if(!apply_ready){
					var _transform,_transform_value,_target,_time_current,_time_max,_curve;
					_transform = transform[TransformType.relative];
					_time_current = 0;
					_time_max = 0.2*SECOND;
					_curve = ease_quad_in_out;
				
					transform_recoil(_transform,TransformValue.xscale,_time_current,_time_max,_curve);
					transform_recoil(_transform,TransformValue.yscale,_time_current,_time_max,_curve);
					transform_recoil(_transform, TransformValue.alpha,_time_current,_time_max,_curve);
				}
				
				apply_ready = true;
			}
			else{
				apply_ready = false;
				var _transform,_transform_value,_target,_time_current,_time_max,_curve;
				_transform = transform[TransformType.relative];
				_target = 0;
				_time_current = 0;
				_time_max = 0.2*SECOND;
				_curve = ease_quad_in_out;
				
				transform_animate_from_current(_transform,TransformValue.xscale,_target,_time_current,_time_max,_curve);
				transform_animate_from_current(_transform,TransformValue.yscale,_target,_time_current,_time_max,_curve);
				transform_animate_from_current(_transform,TransformValue.alpha,_target,_time_current,_time_max,_curve);
			}
		}
	}
}