/// @function director_draw_parallax_layer_frame
/// @description Draws a parallax layer using an explicit animation frame.
/// @param {Asset.GMSprite} _sprite Sprite to draw.
/// @param {Real} _frame Frame index to draw.
/// @param {Real} _camera_x Camera X position.
/// @param {Real} _camera_y Camera Y position.
/// @param {Real} _camera_width Camera viewport width.
/// @param {Real} _camera_height Camera viewport height.
/// @param {Real} _parallax_x Horizontal parallax factor.
/// @param {Real} _parallax_y Vertical parallax factor.
/// @param {Real} _offset_y Additional Y offset.
function director_draw_parallax_layer_frame(_sprite, _frame, _camera_x, _camera_y, _camera_width, _camera_height, _parallax_x, _parallax_y, _offset_y) {
	var _sprite_width = sprite_get_width(_sprite);
	var _sprite_height = sprite_get_height(_sprite);
	
	var _base_x = _camera_x * _parallax_x;
	var _base_y = (_camera_y * _parallax_y) + _offset_y;
	
	// Mirror existing clamping behavior used by static parallax layers.
	var _y_min = _camera_y;
	var _y_max = (_camera_y + _camera_height) - _sprite_height;
	_base_y = clamp(_base_y, _y_max, _y_min);
	
	var _camera_right = _camera_x + _camera_width;
	var _tiles_back = ceil((_base_x - _camera_x) / _sprite_width);
	var _tile_x = _base_x - (_tiles_back * _sprite_width);
	
	while (_tile_x < _camera_right) {
		draw_sprite(_sprite, _frame, _tile_x, _base_y);
		_tile_x += _sprite_width;
	}
}
