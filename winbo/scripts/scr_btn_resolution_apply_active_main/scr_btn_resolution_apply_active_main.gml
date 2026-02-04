function btn_resolution_apply_active_main() {
	if(apply_ready){
		apply_ready = false;
	
		with(o_camera){
			resolution_slot_current = resolution_slot_next;
			alarm[CameraAlarm.apply_resolution_current] = 1;
			camera_save();
		}
	
		var _transform,_target,_time_current,_time_max,_curve;
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