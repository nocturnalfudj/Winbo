/// @function pfx_type_create_example
/// @summary Example particle type settings for demonstration.
function pfx_type_create_example() {
	var _part_type = part_type_create();

	part_type_shape(_part_type,pt_shape_sphere);

	#region Size
		var _size_min,_size_max,_size_increase,_size_wiggle;
		_size_min = 0;
		_size_max = 0.5;
		_size_increase = 0.05;
		_size_wiggle = 0;
		part_type_size(_part_type,_size_min,_size_max,_size_increase,_size_wiggle);
	#endregion

	#region Scale
		var _x_scale,_y_scale;
		_x_scale = 1;
		_y_scale = 1;
		part_type_scale(_part_type, _x_scale, _y_scale);
	#endregion

	#region Speed
		var _speed_min,_speed_max,_speed_increase,_speed_wiggle;
		_speed_min = 0;
		_speed_max = 0;
		_speed_increase = 0;
		_speed_wiggle = 0;
		part_type_speed(_part_type,_speed_min,_speed_max,_speed_increase,_speed_wiggle);
	#endregion

	#region Direction
		var _direction_min,_direction_max,_direction_increase,_direction_wiggle;
		_direction_min = 0;
		_direction_max = 0;
		_direction_increase = 0;
		_direction_wiggle = 0;
		part_type_direction(_part_type,_direction_min,_direction_max,_direction_increase,_direction_wiggle);
	#endregion

	#region Gravity
		var _grav,_grav_direction;
		_grav = 0;
		_grav_direction = 270;
		part_type_gravity(_part_type,_grav,_grav_direction);
	#endregion

	#region Orientation
		var _angle_min,_angle_max,_angle_increase,_angle_wiggle,_angle_relative;
		_angle_min = 0;
		_angle_max = 360;
		_angle_increase = 1;
		_angle_wiggle = 0;
		_angle_relative = 0;
		part_type_orientation(_part_type,_angle_min,_angle_max,_angle_increase,_angle_wiggle,_angle_relative);
	#endregion

	#region Colour
		var _colour,_colour_1,_colour_3;
		_colour = c_flat_blue_dodger_blue;
		_colour_1 = c_fuchsia;
		_colour_3 = c_flat_purple_electric_purple;
		part_type_colour3(_part_type,_colour,_colour_1,_colour_3);
	#endregion

	#region Blend
		part_type_blend(_part_type,false);
	#endregion

	#region Alpha
		var _a_1,_a_2;
		_a_1 = 1;
		_a_2 = 0;
		part_type_alpha3(_part_type,_a_1,_a_1,_a_2);
	#endregion

	#region Life
		var _life_min,_life_max;
		_life_min = 60;
		_life_max = 120;
		part_type_life(_part_type,_life_min,_life_max);
	#endregion

	#region Step Spawn
		var _step_num,_step_type;
		_step_num = 0;
		_step_type = noone;
		part_type_step(_part_type,_step_num,_step_type);
	#endregion

	#region Death Spawn
		var _death_num,_death_type;
		_death_num = 0;
		_death_type = noone;
		part_type_death(_part_type,_death_num,_death_type);
	#endregion

	return _part_type;
}