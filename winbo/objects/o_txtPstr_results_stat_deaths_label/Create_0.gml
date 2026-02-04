// Inherit the parent event
event_inherited();

text_string = "Deaths";
font = fnt_default_42;
alignment_h = fa_left;  // LEFT aligned
alignment_v = fa_middle;
width_max = 2000;

// Shadow for depth
shadow_enable = true;
shadow_x = -3;
shadow_y = 3;
shadow_c = c_black;
shadow_alpha = 0.5;

// Staggered appear animation
var _time_current, _time_max, _curve, _target;
_time_current = -1.5*SECOND;
_time_max = 0.4*SECOND;
_curve = ease_back_out;
_target = 1;
transform_animate(transform[TransformType.anchor], TransformValue.alpha, 0, _target, _time_current, _time_max, _curve, false, true);
transform_animate(transform[TransformType.anchor], TransformValue.xscale, 0.5, _target, _time_current, _time_max, _curve, false, true);
transform_animate(transform[TransformType.anchor], TransformValue.yscale, 0.5, _target, _time_current, _time_max, _curve, false, true);

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_results_create_main;
#endregion
