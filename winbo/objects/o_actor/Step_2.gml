//Inherit Parent
event_inherited();

#region Set Previous Movement Input Direction & Magnitude
	input_move_direction_prev = input_move_direction;
	input_move_magnitude_prev = input_move_magnitude;
	
	//input_move_direction = 0;
	input_move_magnitude = 0;
#endregion

//Set Previous Grounded
move_grounded_previous = move_grounded;

//Check if Object is Visible to the Camera
camera_visible_check(camera_visible_buff_width,camera_visible_buff_height);

//Flash
flash_system_update();

//Info Bar
info_bar_system_update();