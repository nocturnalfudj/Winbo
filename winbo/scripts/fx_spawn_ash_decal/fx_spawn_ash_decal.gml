/// @function fx_spawn_ash_decal(_x, _y, _blast_direction, _surface)
/// @description Spawn a fading ash decal on the nearest tile in a cardinal blast direction.
function fx_spawn_ash_decal(_x, _y, _blast_direction, _surface = noone) {
	var _tile_size = 320;
	var _half_tile = _tile_size * 0.5;
	var _cardinal_direction = (round(_blast_direction / 90) * 90 + 360) mod 360;

	if((_surface == noone) || !(_surface.object_index == o_solid || object_is_ancestor(_surface.object_index, o_solid))){
		_surface = collision_line(
			_x,
			_y,
			_x + lengthdir_x(_tile_size, _cardinal_direction),
			_y + lengthdir_y(_tile_size, _cardinal_direction),
			o_solid,
			false,
			true
		);
	}

	if(_surface == noone){
		return noone;
	}

	var _tile_center_x = floor(_x / _tile_size) * _tile_size + _half_tile;
	var _tile_center_y = floor(_y / _tile_size) * _tile_size + _half_tile;
	var _decal_x = clamp(_tile_center_x, _surface.bbox_left, _surface.bbox_right);
	var _decal_y = clamp(_tile_center_y, _surface.bbox_top, _surface.bbox_bottom);
	var _decal_angle = 0;

	switch(_cardinal_direction){
		case 0:
			_decal_x = _surface.bbox_left;
			_decal_angle = 90;
		break;

		case 90:
			_decal_y = _surface.bbox_bottom;
			_decal_angle = 180;
		break;

		case 180:
			_decal_x = _surface.bbox_right;
			_decal_angle = 270;
		break;

		default:
			_decal_y = _surface.bbox_top;
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
	var _tile_layer = layer_get_id("lyr_tileset");
	if((_player_layer != -1) && (_tile_layer != -1)){
		_decal_depth = (layer_get_depth(_player_layer) + layer_get_depth(_tile_layer)) * 0.5;
	}

	var _decal = instance_create_depth(_decal_x, _decal_y, _decal_depth, o_fx_ash_decal);
	_decal.image_angle = _decal_angle;
	return _decal;
}
