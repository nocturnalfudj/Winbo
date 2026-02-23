/// @function director_draw_parallax_layer_variant
/// @description Draws a parallax layer with one-time first-tile variant.
/// @param {Asset.GMSprite} _sprite_first Sprite to draw on first tile only.
/// @param {Asset.GMSprite} _sprite_loop Sprite to draw on all subsequent tiles.
/// @param {Real} _camera_x Camera X position.
/// @param {Real} _camera_y Camera Y position.
/// @param {Real} _camera_width Camera viewport width.
/// @param {Real} _camera_height Camera viewport height.
/// @param {Real} _parallax_x Horizontal parallax factor.
/// @param {Real} _parallax_y Vertical parallax factor.
/// @param {Real} _offset_y Additional Y offset.
function director_draw_parallax_layer_variant(_sprite_first, _sprite_loop, _camera_x, _camera_y, _camera_width, _camera_height, _parallax_x, _parallax_y, _offset_y) {
	var _sprite_width = sprite_get_width(_sprite_loop);
	var _sprite_height = sprite_get_height(_sprite_loop);
	
	var _base_x = _camera_x * _parallax_x;
	var _base_y = (_camera_y * _parallax_y) + _offset_y;
	
	// Mirror existing clamping behavior used by static parallax layers.
	var _y_min = _camera_y;
	var _y_max = (_camera_y + _camera_height) - _sprite_height;
	_base_y = clamp(_base_y, _y_max, _y_min);
	
	var _camera_right = _camera_x + _camera_width;
	var _tiles_back = ceil((_base_x - _camera_x) / _sprite_width);
	var _tile_x = _base_x - (_tiles_back * _sprite_width);
	var _tile_index = _tiles_back;
	
	while (_tile_x < _camera_right) {
		var _sprite_to_draw = (_tile_index == 0) ? _sprite_first : _sprite_loop;
		draw_sprite(_sprite_to_draw, 0, _tile_x, _base_y);
		_tile_x += _sprite_width;
		_tile_index++;
	}
}
