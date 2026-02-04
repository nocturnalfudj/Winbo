/// @function director_draw_parallax_layer
/// @description Draws a parallax background layer with seamless looping
/// @param {Asset.GMSprite} _sprite The sprite to draw
/// @param {Real} _camera_x Camera X position
/// @param {Real} _camera_y Camera Y position
/// @param {Real} _camera_width Camera viewport width
/// @param {Real} _camera_height Camera viewport height
/// @param {Real} _parallax_x Horizontal parallax factor (0.0 to 1.0+)
/// @param {Real} _parallax_y Vertical parallax factor (0.0 to 1.0+)
/// @param {Real} _offset_y Additional Y offset to apply
function director_draw_parallax_layer(_sprite, _camera_x, _camera_y, _camera_width, _camera_height, _parallax_x, _parallax_y, _offset_y) {
	var _sprite_width = sprite_get_width(_sprite);
	var _sprite_height = sprite_get_height(_sprite);
	
	var _base_x = _camera_x * _parallax_x;
	var _base_y = (_camera_y * _parallax_y) + _offset_y;
	
	// Clamp Y position to prevent showing sprite edges
	// Ensure sprite top doesn't go below camera top
	var _y_min = _camera_y;
	// Ensure sprite bottom doesn't go above camera bottom
	var _y_max = (_camera_y + _camera_height) - _sprite_height;
	
	// Apply clamping
	_base_y = clamp(_base_y, _y_max, _y_min);
	
	// Calculate the camera's right edge
	var _camera_right = _camera_x + _camera_width;
	
	// Find the starting tile position
	// Tiles repeat at: _base_x, _base_x + _sprite_width, _base_x + 2*_sprite_width, etc.
	// We need to find the leftmost tile that could be visible in the viewport
	
	// How many sprite widths do we need to go back from _base_x to get before camera left?
	var _tiles_back = ceil((_base_x - _camera_x) / _sprite_width);
	var _tile_x = _base_x - (_tiles_back * _sprite_width);
	
	// Draw tiles from left to right until we've covered the viewport
	while (_tile_x < _camera_right) {
		draw_sprite(_sprite, 0, _tile_x, _base_y);
		_tile_x += _sprite_width;
	}
}
