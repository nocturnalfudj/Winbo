/// @function TransValue
/// @summary Animated numeric value supporting easing and recoil.
/// @param {real} _x Initial value for all parameters.
/// @returns {struct} TransValue struct.
/// @description
///   Useful for smoothly animating numbers such as position or scale.
function TransValue(_x) constructor{
		rest = _x;
		current = _x;
		start = _x;
		target = _x;
		time_current = 0;
		time_max = 0;
		recoil = false;
		
		curve = noone;
		
		curve_is_ease_function = false;
		
		target_start_difference = target - start;
		
		animating = false;
		
		animating_pause = false;
		
		//Recoil
		recoil_time = 0.2*SECOND;
		recoil_curve = ease_back_out;
		recoil_curve_is_ease_function = true;
}