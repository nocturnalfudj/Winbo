function breakable_wall_spawn_break_fx(_x, _y, _sprite, _xscale, _yscale, _smoke_sprite, _columns, _rows){
	var _sprite_width = sprite_get_width(_sprite);
	var _sprite_height = sprite_get_height(_sprite);
	var _draw_width = _sprite_width * abs(_xscale);
	var _draw_height = _sprite_height * abs(_yscale);
	var _center_x = _x + (_draw_width * 0.5);
	var _center_y = _y + (_draw_height * 0.5);

	if(_smoke_sprite != noone){
		var _smoke_size = sprite_get_width(_smoke_sprite);
		var _smoke_scale = (max(_draw_width, _draw_height) / _smoke_size) * 1.45;
		fx_spawn_sprite_once(_center_x, _center_y, "lyr_pfx_midground", _smoke_sprite, _smoke_scale, _smoke_scale, 0, ANIMATION_FPS_DEFAULT);
	}

	for(var _row = 0; _row < _rows; _row++){
		var _src_top = floor((_row / _rows) * _sprite_height);
		var _src_bottom = floor(((_row + 1) / _rows) * _sprite_height);
		var _src_height = max(1, _src_bottom - _src_top);

		for(var _col = 0; _col < _columns; _col++){
			var _src_left = floor((_col / _columns) * _sprite_width);
			var _src_right = floor(((_col + 1) / _columns) * _sprite_width);
			var _src_width = max(1, _src_right - _src_left);
			var _piece_x = _x + (_src_left * abs(_xscale));
			var _piece_y = _y + (_src_top * abs(_yscale));
			var _rel_x = ((_src_left + (_src_width * 0.5)) / _sprite_width) - 0.5;
			var _rel_y = ((_src_top + (_src_height * 0.5)) / _sprite_height) - 0.5;

			with(instance_create_layer(_piece_x, _piece_y, "lyr_pfx_foreground", o_fx_breakable_wall_shard)){
				source_sprite = _sprite;
				source_frame = 0;
				source_left = _src_left;
				source_top = _src_top;
				source_width = _src_width;
				source_height = _src_height;
				image_xscale = abs(_xscale);
				image_yscale = abs(_yscale);
				velocity_x = (_rel_x * random_range(7, 11)) + random_range(-1.5, 1.5);
				velocity_y = (_rel_y * random_range(7, 11)) - random_range(3, 6);
				gravity = 0.25;
				lifetime = SECOND * random_range(0.45, 0.7);
				lifetime_max = lifetime;
			}
		}
	}
}
