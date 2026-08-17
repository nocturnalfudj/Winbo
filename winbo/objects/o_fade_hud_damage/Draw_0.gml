if(fade_factor <= 0){
	exit;
}

var _camera_x, _camera_y, _camera_width, _camera_height;
with(o_camera){
	_camera_x = start_x;
	_camera_y = start_y;
	_camera_width = width;
	_camera_height = height;
}

var _vignette_depth = min(_camera_width, _camera_height) * 0.18;
var _vignette_steps = 8;
var _step_depth = _vignette_depth / _vignette_steps;
var _vignette_alpha = image_alpha * fade_factor;

draw_set_colour(c_black);
for(var _step = 0; _step < _vignette_steps; _step++){
	var _outer_inset = _step * _step_depth;
	var _inner_inset = (_step + 1) * _step_depth;
	var _step_factor = 1 - (_step / _vignette_steps);
	draw_set_alpha(_vignette_alpha * _step_factor * _step_factor);

	draw_rectangle(
		_camera_x + _outer_inset,
		_camera_y + _outer_inset,
		_camera_x + _camera_width - _outer_inset,
		_camera_y + _inner_inset,
		false
	);
	draw_rectangle(
		_camera_x + _outer_inset,
		_camera_y + _camera_height - _inner_inset,
		_camera_x + _camera_width - _outer_inset,
		_camera_y + _camera_height - _outer_inset,
		false
	);
	draw_rectangle(
		_camera_x + _outer_inset,
		_camera_y + _inner_inset,
		_camera_x + _inner_inset,
		_camera_y + _camera_height - _inner_inset,
		false
	);
	draw_rectangle(
		_camera_x + _camera_width - _inner_inset,
		_camera_y + _inner_inset,
		_camera_x + _camera_width - _outer_inset,
		_camera_y + _camera_height - _inner_inset,
		false
	);
}

draw_set_alpha(1);
draw_set_colour(c_white);
