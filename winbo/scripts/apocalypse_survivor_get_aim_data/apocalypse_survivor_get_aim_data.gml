/// @function apocalypse_survivor_get_aim_data
/// @summary Returns current aim sector, draw angle, barrel offset, and muzzle position.
/// @returns {struct}
function apocalypse_survivor_get_aim_data(_aim_angle_override = undefined, _face_horizontal_override = undefined){
	var _aim_angle = is_undefined(_aim_angle_override) ? aim_angle : _aim_angle_override;
	var _face_horizontal = is_undefined(_face_horizontal_override) ? face_horizontal : _face_horizontal_override;
	var _sector = "out";
	if(_aim_angle >= 315 || _aim_angle < 45) _sector = "side";
	else if(_aim_angle >= 45 && _aim_angle < 85) _sector = "diag";
	else if(_aim_angle >= 85 && _aim_angle < 95) _sector = "up";
	else if(_aim_angle >= 95 && _aim_angle < 135) _sector = "diag_flip";
	else if(_aim_angle >= 135 && _aim_angle < 225) _sector = "side_flip";

	var _standing = variable_instance_exists(id, "survivor_posture")
		&& (survivor_posture == SurvivorPosture.standing);
	var _draw_angle = 0;
	var _barrel_x = barrel_offset_x_side;
	var _barrel_y = barrel_offset_y_side;

	if(_standing){
		_barrel_x = barrel_offset_standing_x_side;
		_barrel_y = barrel_offset_standing_y_side;
	}

	switch(_sector){
		case "side":
			_draw_angle = _aim_angle - (_standing ? standing_draw_angle_offset_side : 2);
		break;

		case "side_flip":
			_draw_angle = _aim_angle - (_standing ? standing_draw_angle_offset_side_flip : 178);
		break;

		case "diag":
			_draw_angle = _aim_angle - (_standing ? standing_draw_angle_offset_diag : 44.5);
			_barrel_x = _standing ? barrel_offset_standing_x_diag : barrel_offset_x_diag;
			_barrel_y = _standing ? barrel_offset_standing_y_diag : barrel_offset_y_diag;
		break;

		case "diag_flip":
			_draw_angle = _aim_angle - (_standing ? standing_draw_angle_offset_diag_flip : 135.5);
			_barrel_x = _standing ? barrel_offset_standing_x_diag : barrel_offset_x_diag;
			_barrel_y = _standing ? barrel_offset_standing_y_diag : barrel_offset_y_diag;
		break;

		case "up":
			_draw_angle = _aim_angle - (_standing ? standing_draw_angle_offset_up : 90);
			_barrel_x = _standing ? barrel_offset_standing_x_up : barrel_offset_x_up;
			_barrel_y = _standing ? barrel_offset_standing_y_up : barrel_offset_y_up;
		break;
	}

	var _base_x = _barrel_x * _face_horizontal;
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
