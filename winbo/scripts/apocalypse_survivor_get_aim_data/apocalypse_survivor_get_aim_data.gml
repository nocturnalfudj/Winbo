function apocalypse_survivor_get_aim_sector(_aim_angle){
	_aim_angle = ((_aim_angle mod 360) + 360) mod 360;

	if(_aim_angle >= 315 || _aim_angle < 45) return "side";
	if(_aim_angle >= 45 && _aim_angle < 85) return "diag";
	if(_aim_angle >= 85 && _aim_angle < 95) return "up";
	if(_aim_angle >= 95 && _aim_angle < 135) return "diag_flip";
	if(_aim_angle >= 135 && _aim_angle < 225) return "side_flip";

	return "out";
}

function apocalypse_survivor_get_standing_body_pivot(_sector){
	switch(_sector){
		case "diag":
		case "diag_flip":
			return {
				x: standing_body_pivot_x_diag,
				y: standing_body_pivot_y_diag
			};

		case "up":
			return {
				x: standing_body_pivot_x_up,
				y: standing_body_pivot_y_up
			};

		case "side":
		case "side_flip":
		case "out":
		default:
			return {
				x: standing_body_pivot_x_side,
				y: standing_body_pivot_y_side
			};
	}
}

function apocalypse_survivor_rotate_local_offset(_local_x, _local_y, _draw_angle, _face_horizontal){
	var _base_x = _local_x * _face_horizontal;
	var _base_y = _local_y;
	var _off_dist = point_distance(0, 0, _base_x, _base_y);
	var _off_dir = point_direction(0, 0, _base_x, _base_y);

	return {
		base_x: _base_x,
		base_y: _base_y,
		x: lengthdir_x(_off_dist, _off_dir + _draw_angle),
		y: lengthdir_y(_off_dist, _off_dir + _draw_angle)
	};
}

function apocalypse_survivor_transform_local_point(_origin_x, _origin_y, _local_x, _local_y, _draw_angle, _face_horizontal){
	var _offset = apocalypse_survivor_rotate_local_offset(_local_x, _local_y, _draw_angle, _face_horizontal);

	return {
		x: _origin_x + _offset.x,
		y: _origin_y + _offset.y
	};
}

function apocalypse_survivor_build_aim_data(_sector, _aim_angle, _face_horizontal){
	var _standing = variable_instance_exists(id, "survivor_posture")
		&& (survivor_posture == SurvivorPosture.standing);
	var _draw_angle = 0;
	var _barrel_x = barrel_offset_x_side;
	var _barrel_y = barrel_offset_y_side;
	var _body_draw_x = x + aim_body_sprite_offset_x;
	var _body_draw_y = y + aim_body_sprite_offset_y;
	var _body_pivot_x = 0;
	var _body_pivot_y = 0;

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

	if(_standing){
		var _pivot = apocalypse_survivor_get_standing_body_pivot(_sector);
		_body_pivot_x = _pivot.x;
		_body_pivot_y = _pivot.y;

		var _pivot_offset = apocalypse_survivor_rotate_local_offset(_body_pivot_x, _body_pivot_y, _draw_angle, _face_horizontal);
		_body_draw_x += _pivot_offset.base_x - _pivot_offset.x;
		_body_draw_y += _pivot_offset.base_y - _pivot_offset.y;
	}

	var _muzzle = apocalypse_survivor_transform_local_point(
		_body_draw_x,
		_body_draw_y,
		_barrel_x,
		_barrel_y,
		_draw_angle,
		_face_horizontal
	);
	var _muzzle_x = _muzzle.x;
	var _muzzle_y = _muzzle.y;

	return {
		sector: _sector,
		aim_angle: _aim_angle,
		face_horizontal: _face_horizontal,
		draw_angle: _draw_angle,
		body_draw_x: _body_draw_x,
		body_draw_y: _body_draw_y,
		body_pivot_x: _body_pivot_x,
		body_pivot_y: _body_pivot_y,
		barrel_x: _barrel_x,
		barrel_y: _barrel_y,
		muzzle_x: _muzzle_x,
		muzzle_y: _muzzle_y,
		fire_x: _muzzle_x,
		fire_y: _muzzle_y,
		close_range_fallback: false
	};
}

/// @function apocalypse_survivor_get_aim_data
/// @summary Returns current aim sector, draw angle, barrel offset, and muzzle position.
/// @returns {struct}
function apocalypse_survivor_get_aim_data(_aim_angle_override = undefined, _face_horizontal_override = undefined, _sector_override = undefined){
	var _aim_angle = is_undefined(_aim_angle_override) ? aim_angle : _aim_angle_override;
	var _face_horizontal = is_undefined(_face_horizontal_override) ? face_horizontal : _face_horizontal_override;

	if(is_undefined(_aim_angle_override)
	&& is_undefined(_face_horizontal_override)
	&& is_undefined(_sector_override)
	&& variable_instance_exists(id, "survivor_resolved_aim_data")
	&& !is_undefined(survivor_resolved_aim_data)){
		var _cached = survivor_resolved_aim_data;
		if(_cached.aim_angle == _aim_angle && _cached.face_horizontal == _face_horizontal){
			return _cached;
		}
	}

	var _sector = is_undefined(_sector_override)
		? apocalypse_survivor_get_aim_sector(_aim_angle)
		: _sector_override;

	return apocalypse_survivor_build_aim_data(_sector, _aim_angle, _face_horizontal);
}
