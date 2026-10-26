/// @function director_parallax_layer_base_y
/// @description Resolves the world Y of a parallax layer's top edge. Shared by every parallax draw helper.
/// @param {Real} _camera_y Camera Y position
/// @param {Real} _camera_height Camera viewport height
/// @param {Real} _sprite_height Height of the authored layer canvas
/// @param {Real} _parallax_y Vertical parallax factor (0.0 to 1.0+)
/// @param {Real} _offset_y Additional Y offset to apply
/// @param {Real|Undefined} _anchor_bottom_y Camera bottom Y at which the canvas bottom meets the view bottom; undefined anchors to world Y 0.
/// @param {Bool} _clamp_top Prevent the sprite top moving below the camera top.
/// @param {Bool} _clamp_bottom Prevent the sprite bottom moving above the camera bottom.
function director_parallax_layer_base_y(_camera_y, _camera_height, _sprite_height, _parallax_y, _offset_y, _anchor_bottom_y, _clamp_top, _clamp_bottom) {
	var _base_y;

	if (is_undefined(_anchor_bottom_y)) {
		_base_y = (_camera_y * _parallax_y) + _offset_y;
	}
	else {
		// Every layer shows its authored composition at the anchor, then
		// trails the camera by its parallax factor as the view moves away.
		var _camera_bottom_y = _camera_y + _camera_height;
		_base_y = (_camera_bottom_y - _sprite_height)
			+ _offset_y
			+ ((_anchor_bottom_y - _camera_bottom_y) * (1 - _parallax_y));
	}

	// Apply the bottom constraint first so the top constraint remains
	// authoritative if an undersized sprite cannot cover both edges.
	if (_clamp_bottom) {
		_base_y = max(_base_y, (_camera_y + _camera_height) - _sprite_height);
	}
	if (_clamp_top) {
		_base_y = min(_base_y, _camera_y);
	}

	return _base_y;
}

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
/// @param {Bool} [_repeat_x=true] If false, draw a single non-looping tile.
/// @param {Bool} [_clamp_top=true] Prevent the sprite top moving below the camera top.
/// @param {Bool} [_clamp_bottom=true] Prevent the sprite bottom moving above the camera bottom.
/// @param {Real|Undefined} [_anchor_bottom_y=undefined] Camera bottom Y at which the canvas bottom meets the view bottom.
function director_draw_parallax_layer(_sprite, _camera_x, _camera_y, _camera_width, _camera_height, _parallax_x, _parallax_y, _offset_y, _repeat_x = true, _clamp_top = true, _clamp_bottom = true, _anchor_bottom_y = undefined) {
	var _sprite_width = sprite_get_width(_sprite);

	var _base_x = _camera_x * _parallax_x;
	var _base_y = director_parallax_layer_base_y(
		_camera_y,
		_camera_height,
		sprite_get_height(_sprite),
		_parallax_y,
		_offset_y,
		_anchor_bottom_y,
		_clamp_top,
		_clamp_bottom
	);

	if (!_repeat_x) {
		draw_sprite(_sprite, 0, _base_x, _base_y);
		return;
	}

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
