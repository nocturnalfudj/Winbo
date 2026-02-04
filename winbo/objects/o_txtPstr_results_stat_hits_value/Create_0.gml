// Inherit the parent event
event_inherited();

var _score = o_director.level_results_score_data;
var _points_str = (_score.points_damage > 0) ? ("+" + string(_score.points_damage)) : ((_score.points_damage == 0) ? "+0" : string(_score.points_damage));
text_string = string(_score.hits_taken) + " (" + _points_str + " Points)";
font = fnt_default_42;
alignment_h = fa_right;  // RIGHT aligned
alignment_v = fa_middle;
width_max = 2000;

// Shadow for depth
shadow_enable = true;
shadow_x = -3;
shadow_y = 3;
shadow_c = c_black;
shadow_alpha = 0.5;

// Staggered appear animation (SAME delay as matching label)
var _time_current, _time_max, _curve, _target;
_time_current = -1.2*SECOND;
_time_max = 0.4*SECOND;
_curve = ease_back_out;
_target = 1;
transform_animate(transform[TransformType.anchor], TransformValue.alpha, 0, _target, _time_current, _time_max, _curve, false, true);
transform_animate(transform[TransformType.anchor], TransformValue.xscale, 0.5, _target, _time_current, _time_max, _curve, false, true);
transform_animate(transform[TransformType.anchor], TransformValue.yscale, 0.5, _target, _time_current, _time_max, _curve, false, true);

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_results_create_main;
#endregion
