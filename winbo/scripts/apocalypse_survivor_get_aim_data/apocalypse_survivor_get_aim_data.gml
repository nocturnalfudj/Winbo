/// @function apocalypse_survivor_get_aim_data
/// @summary Returns current aim sector, draw angle, barrel offset, and muzzle position.
/// @returns {struct}
function apocalypse_survivor_get_aim_data(){
	var _sector = "out";
	if(aim_angle >= 315 || aim_angle < 45) _sector = "side";
	else if(aim_angle >= 45 && aim_angle < 85) _sector = "diag";
	else if(aim_angle >= 85 && aim_angle < 95) _sector = "up";
	else if(aim_angle >= 95 && aim_angle < 135) _sector = "diag_flip";
	else if(aim_angle >= 135 && aim_angle < 225) _sector = "side_flip";

	var _draw_angle = 0;
	var _barrel_x = barrel_offset_x_side;
	var _barrel_y = barrel_offset_y_side;

	switch(_sector){
		case "side":
			_draw_angle = aim_angle - 2;
		break;

		case "side_flip":
			_draw_angle = aim_angle - 178;
		break;

		case "diag":
			_draw_angle = aim_angle - 44.5;
			_barrel_x = barrel_offset_x_diag;
			_barrel_y = barrel_offset_y_diag;
		break;

		case "diag_flip":
			_draw_angle = aim_angle - 135.5;
			_barrel_x = barrel_offset_x_diag;
			_barrel_y = barrel_offset_y_diag;
		break;

		case "up":
			_draw_angle = aim_angle - 90;
			_barrel_x = barrel_offset_x_up;
			_barrel_y = barrel_offset_y_up;
		break;
	}

	var _base_x = _barrel_x * face_horizontal;
	var _base_y = _barrel_y;
	var _off_dist = point_distance(0, 0, _base_x, _base_y);
	var _off_dir = point_direction(0, 0, _base_x, _base_y);
	var _muzzle_x = x + lengthdir_x(_off_dist, _off_dir + _draw_angle);
	var _muzzle_y = y + lengthdir_y(_off_dist, _off_dir + _draw_angle);

	return {
		sector: _sector,
		draw_angle: _draw_angle,
		barrel_x: _barrel_x,
		barrel_y: _barrel_y,
		muzzle_x: _muzzle_x,
		muzzle_y: _muzzle_y
	};
}
