function breakable_wall_spawn_break_fx(_x, _y, _sprite, _xscale, _yscale, _smoke_sprite, _columns, _rows, _blast_direction){
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

	var _src_x = [];
	var _src_y = [];
	_src_x[0] = 0;
	_src_y[0] = 0;

	for(var _col_line = 1; _col_line < _columns; _col_line++){
		_src_x[_col_line] = floor(((_col_line + random_range(-0.3, 0.3)) / _columns) * _sprite_width);
	}

	for(var _row_line = 1; _row_line < _rows; _row_line++){
		_src_y[_row_line] = floor(((_row_line + random_range(-0.3, 0.3)) / _rows) * _sprite_height);
	}

	_src_x[_columns] = _sprite_width;
	_src_y[_rows] = _sprite_height;

	var _blast_enable = (_blast_direction != noone);
	var _blast_x = 0;
	var _blast_y = 0;

	if(_blast_enable){
		_blast_x = lengthdir_x(1, _blast_direction);
		_blast_y = lengthdir_y(1, _blast_direction);
	}

	for(var _row = 0; _row < _rows; _row++){
		var _src_top = _src_y[_row];
		var _src_bottom = _src_y[_row + 1];
		var _src_height = max(1, _src_bottom - _src_top);

		for(var _col = 0; _col < _columns; _col++){
			var _src_left = _src_x[_col];
			var _src_right = _src_x[_col + 1];
			var _src_width = max(1, _src_right - _src_left);
			var _piece_x = _x + (_src_left * abs(_xscale));
			var _piece_y = _y + (_src_top * abs(_yscale));
			var _rel_x = ((_src_left + (_src_width * 0.5)) / _sprite_width) - 0.5;
			var _rel_y = ((_src_top + (_src_height * 0.5)) / _sprite_height) - 0.5;
			var _scatter_x = (_rel_x * random_range(5, 8)) + random_range(-1.5, 1.5);
			var _scatter_y = (_rel_y * random_range(5, 8)) - random_range(3, 6);
			var _blast_speed = 0;

			if(_blast_enable){
				_blast_speed = random_range(6, 11);
			}

			with(instance_create_layer(_piece_x, _piece_y, "lyr_pfx_foreground", o_fx_breakable_wall_shard)){
				source_sprite = _sprite;
				source_frame = 0;
				source_left = _src_left;
				source_top = _src_top;
				source_width = _src_width;
				source_height = _src_height;
				image_xscale = abs(_xscale);
				image_yscale = abs(_yscale);
				velocity_x = _scatter_x + (_blast_x * _blast_speed);
				velocity_y = _scatter_y + (_blast_y * _blast_speed);
				gravity = 0.25;
				lifetime = SECOND * random_range(1.35, 1.7);
				lifetime_max = lifetime;
				fade_delay = SECOND;
			}
		}
	}
}
