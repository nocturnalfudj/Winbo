/// @function fx_spawn_ash_decal(_x, _y, _blast_direction, _surface)
/// @description Spawn a fading ash decal on the exact solid face hit by a cardinal blast.
function fx_spawn_ash_decal(_x, _y, _blast_direction, _surface = noone) {
	var _cardinal_direction = (round(_blast_direction / 90) * 90 + 360) mod 360;
	var _impact_x = _x;
	var _impact_y = _y;
	var _impact_surface = noone;
	var _probe_distance_max = 320;

	// The projectile is stopped immediately outside the collision mask. Probe
	// forward one pixel at a time so the decal uses the first concrete surface
	// point instead of a global tile-grid snap or an arbitrary large bbox edge.
	for(var _probe_distance = 0; _probe_distance <= _probe_distance_max; _probe_distance++){
		var _probe_x = _x + lengthdir_x(_probe_distance, _cardinal_direction);
		var _probe_y = _y + lengthdir_y(_probe_distance, _cardinal_direction);
		var _probe_surface = collision_point(_probe_x, _probe_y, o_solid, true, true);

		if(_probe_surface != noone){
			_impact_x = _probe_x;
			_impact_y = _probe_y;
			_impact_surface = _probe_surface;
			break;
		}
	}

	// The movement solver normally supplies the exact solid. Retain it only as
	// a bounded fallback for unusual collision masks that reject point probes.
	if(_impact_surface == noone){
		if(_surface == noone){
			return noone;
		}

		_impact_surface = _surface;
		switch(_cardinal_direction){
			case 0:
				_impact_x = _surface.bbox_left;
				_impact_y = clamp(_y, _surface.bbox_top, _surface.bbox_bottom);
			break;

			case 90:
				_impact_x = clamp(_x, _surface.bbox_left, _surface.bbox_right);
				_impact_y = _surface.bbox_bottom;
			break;

			case 180:
				_impact_x = _surface.bbox_right;
				_impact_y = clamp(_y, _surface.bbox_top, _surface.bbox_bottom);
			break;

			default:
				_impact_x = clamp(_x, _surface.bbox_left, _surface.bbox_right);
				_impact_y = _surface.bbox_top;
			break;
		}
	}

	var _decal_x = _impact_x;
	var _decal_y = _impact_y;
	var _decal_angle = 0;

	switch(_cardinal_direction){
		case 0:
			_decal_angle = 90;
		break;

		case 90:
			_decal_angle = 180;
		break;

		case 180:
			_decal_angle = 270;
		break;

		default:
			_decal_angle = 0;
		break;
	}

	// The supplied scorch uses a centred origin. Move that origin one half of
	// the sprite's normal thickness into the impacted surface so the whole mark
	// sits on the tile instead of straddling its edge.
	var _surface_inset = sprite_get_height(spr_fx_black_ash) * 0.5;
	_decal_x += lengthdir_x(_surface_inset, _cardinal_direction);
	_decal_y += lengthdir_y(_surface_inset, _cardinal_direction);

	var _decal_depth = 4150;
	var _player_layer = layer_get_id("lyr_player");
	if(_player_layer != -1){
		// Draw behind Winbo but directly in front of terrain in every gameplay
		// room, including rooms whose tile layers are numbered differently.
		_decal_depth = layer_get_depth(_player_layer) + 1;
	}

	var _decal = instance_create_depth(_decal_x, _decal_y, _decal_depth, o_fx_ash_decal);
	_decal.image_angle = _decal_angle;
	return _decal;
}
