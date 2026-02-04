function fade_intro_idle_main() {
	var _transform;
	_transform = transform[TransformType.anchor];

	if(_transform.animating == false){
		var _intro_stage = o_master.intro_stage;
		switch(_intro_stage){
			case IntroStage.wait_start:
			break;
		
			case IntroStage.fade_in:
				var _time_current,_time_max,_curve;
				_time_current = 0;
				_time_max = o_master.intro_stage_time[IntroStage.fade_in];
				_curve = ease_quad_out;
				transform_animate(_transform,TransformValue.alpha,1,0,_time_current,_time_max,_curve);
			break;
		
			case IntroStage.wait_middle:
			break;
		
			case IntroStage.fade_out:
				var _time_current,_time_max,_curve;
				_time_current = 0;
				_time_max = o_master.intro_stage_time[IntroStage.fade_out];
				_curve = ease_quad_in;
				transform_animate(_transform,TransformValue.alpha,0,1,_time_current,_time_max,_curve);
			break;
		
			case IntroStage.wait_end:
			break;
		}
	}
}