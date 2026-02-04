/// @function movement_gravity_enable
/// @summary Initialise gravity settings and enable gravity behaviour.
/// @returns {void} No return value.
function movement_gravity_enable(){
	//Enable
	move_gravity_enable = true;
	
	//Gravity Vector
	move_gravity = new Vector2(0,0);
	
	move_gravity_factor = 1;
	
	//Rise & Fall
	move_gravity_rise_fall_enable = false;
	move_gravity_rise_lerp = 0.2;
	move_gravity_fall_lerp = 0.2;
	move_gravity_dash_lerp = 0.2;
	move_gravity_rise = new Vector2(0,0);
	move_gravity_fall = new Vector2(0,0);
	move_gravity_dash = new Vector2(0,0);
	move_gravity_float = new Vector2(0,0);
}