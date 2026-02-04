// Inherit the parent event
event_inherited();

text_string = "SCORE";
font = fnt_default_64;  // Bigger font
alignment_h = fa_left;  // LEFT aligned
alignment_v = fa_middle;
width_max = 2000;

// Shadow for depth
shadow_enable = true;
shadow_x = -3;
shadow_y = 3;
shadow_c = c_black;
shadow_alpha = 0.5;

// Staggered appear animation (bigger punch with scale 0.3 to 1.2)
var _time_current, _time_max, _curve, _target;
_time_current = -2.2*SECOND;
_time_max = 0.4*SECOND;
_curve = ease_back_out;
_target = 1.2;  // Bigger scale for emphasis
transform_animate(transform[TransformType.anchor], TransformValue.alpha, 0, 1, _time_current, _time_max, _curve, false, true);
transform_animate(transform[TransformType.anchor], TransformValue.xscale, 0.3, _target, _time_current, _time_max, _curve, false, true);
transform_animate(transform[TransformType.anchor], TransformValue.yscale, 0.3, _target, _time_current, _time_max, _curve, false, true);

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_results_create_main;
#endregion
