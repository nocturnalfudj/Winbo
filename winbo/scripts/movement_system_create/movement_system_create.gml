/// @function movement_system_create
/// @summary Setup movement variables and equations for an instance.
function movement_system_create() {
	/* MOVEMENT EQUATIONS
	~Key~
	TV	- Terminal Velocity
	A	- Acceleration
	D	- Drag
	
	~Equation for Terminal Velocity~
	TV = (D*A) / (1 - D)
	
	~Equation for Acceleration~
	A = (V/D) - V
	
	~Equation for Drag~
	D = V / (V+A)
	*/
	
	acceleration = new Vector2(0,0);
	acceleration_max = 10;

	velocity = new Vector2(0,0);
	
	velocity_retention = 0.75;
	velocity_retention_default = velocity_retention;
	velocity_retention_aerial = 0.8;
	velocity_retention_enable = new Vector2(true,true);
	velocity_mag = velocity.Magnitude();
	velocity_dir = velocity.Direction();
	velocity_terminal = (velocity_retention*acceleration_max)/(1-velocity_retention);
	velocity_percent = velocity_mag/velocity_terminal;
	
	
	collision = new Vector2(0,0);
	move_collision_object = o_solid;
	move_collision_object_instance = noone;
	
	move_collision_slip_enable = false;
	
	move_use_transform = true;
	
	#region Input Direction & Magnitude
		input_move_acceleration_factor = 1;
		movement_input_move_acceleration_default_set(acceleration_max);
		
		input_move_direction = 0;
		input_move_magnitude = 0;
	
		input_move_direction_prev = 0;
		input_move_magnitude_prev = 0;
		
		//Jump
		input_move_acceleration_jump = acceleration_max;
	#endregion
	
	velocity_input_terminal = (velocity_retention*INPUT_MOVE_ACCELERATION)/(1-velocity_retention);
	velocity_input_percent = velocity_mag/velocity_terminal;
	
	#region Trapped
		move_trapped = false;
		move_trapped_check = true;
		move_trapped_free_self = true;
		move_trapped_acceleration_direction = 0;
	#endregion
	
	//Limits
	move_limit_enable_x = false;
	move_limit_enable_y = false;
	
	//Grounded
	move_grounded = false;
	move_grounded_previous = move_grounded;
	move_grounded_check = false;
	move_grounded_instance = noone;
	move_grounded_close = false;
	move_grounded_close_prev = move_grounded_close;
	move_grounded_close_check = false;
	move_grounded_close_check_distance = 100;
	move_grounded_close_instance = noone;

	//Gravity
	move_gravity_enable = false;

	//Effects
	move_effects_enable = false;
	
	//Delta Time Scale
	time_scale_enable = true;
	
	// Drop-through system
	move_drop_through_instance = noone;
}