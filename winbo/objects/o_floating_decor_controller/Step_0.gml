spawn_countdown -= global.delta_time_factor_scaled;
if(spawn_countdown <= 0 && instance_number(o_floating_decor_item) < spawn_count_max) {
	var _camera, _view_x, _view_y, _view_w, _view_h;
	_camera = view_camera[0];
	_view_x = camera_get_view_x(_camera);
	_view_y = camera_get_view_y(_camera);
	_view_w = camera_get_view_width(_camera);
	_view_h = camera_get_view_height(_camera);

	var _from_left, _background, _spawn_x, _spawn_y, _layer;
	_from_left = choose(false,true);
	_background = random(1) < background_chance;
	_spawn_x = _from_left ? _view_x - 96 : _view_x + _view_w + 96;
	_spawn_y = random_range(_view_y + 96,_view_y + _view_h - 96);
	_layer = _background ? "lyr_pfx_background" : "lyr_pfx_gui";

	var _item;
	_item = instance_create_layer(_spawn_x,_spawn_y,_layer,o_floating_decor_item);
	_item.decor_sprite = foreground_sprites[irandom(array_length(foreground_sprites) - 1)];
	_item.image_index = irandom(max(0,sprite_get_number(_item.decor_sprite) - 1));
	_item.image_speed = (sprite_get_number(_item.decor_sprite) > 1) ? 15 / SECOND : 0;
	_item.drift_x = (_from_left ? 1 : -1) * random_range(18,42) / SECOND;
	_item.drift_y = random_range(-8,8) / SECOND;
	_item.sway_phase = random(2 * pi);
	_item.sway_speed = random_range(0.8,1.5) / SECOND;
	_item.sway_amount = random_range(10,22);
	_item.image_xscale = _background ? 0.65 : 1;
	_item.image_yscale = _item.image_xscale;
	_item.image_alpha = _background ? 0.72 : 1;
	_item.draw_in_gui = !_background;

	spawn_countdown = random_range(spawn_interval_min,spawn_interval_max);
}
