/// @function director_draw_parallax_layer_anchored_animated
/// @description Draw anchored overlay sprites (animated underlay + static overlay) across repeating parallax loops.
/// @param {Asset.GMSprite} _base_sprite Foreground static sprite (drawn on top).
/// @param {Asset.GMSprite} _animated_sprite Animated sprite (drawn first).
/// @param {Real} _frame Animation frame to draw from _animated_sprite.
/// @param {Real} _camera_x Camera X position.
/// @param {Real} _camera_y Camera Y position.
/// @param {Real} _camera_width Camera viewport width.
/// @param {Real} _camera_height Camera viewport height.
/// @param {Real} _parallax_x Horizontal parallax factor.
/// @param {Real} _parallax_y Vertical parallax factor.
/// @param {Real} _offset_y Additional Y offset.
/// @param {Real} _loop_width Width of one repeat cycle in world space.
/// @param {array} _anchor_x Anchor X positions inside each loop cycle.
function director_draw_parallax_layer_anchored_animated(
	_base_sprite,
	_animated_sprite,
	_frame,
	_camera_x,
	_camera_y,
	_camera_width,
	_camera_height,
	_parallax_x,
	_parallax_y,
	_offset_y,
	_loop_width,
	_anchor_x
) {
	if(_loop_width <= 0){
		return;
	}
	
	var _anchor_count = array_length(_anchor_x);
	if(_anchor_count <= 0){
		return;
	}
	
	var _sprite_width = max(sprite_get_width(_base_sprite), sprite_get_width(_animated_sprite));
	var _sprite_height = max(sprite_get_height(_base_sprite), sprite_get_height(_animated_sprite));
	
	var _base_x = _camera_x * _parallax_x;
	var _base_y = (_camera_y * _parallax_y) + _offset_y;
	
	// Match the same camera-relative clamping used by existing parallax helpers.
	var _y_min = _camera_y;
	var _y_max = (_camera_y + _camera_height) - _sprite_height;
	_base_y = clamp(_base_y, _y_max, _y_min);
	
	var _camera_right = _camera_x + _camera_width;
	var _loop_start = floor((_camera_x - _base_x) / _loop_width) - 1;
	var _loop_end = ceil((_camera_right - _base_x) / _loop_width) + 1;
	
	for(var _loop_index = _loop_start; _loop_index <= _loop_end; _loop_index++){
		var _loop_offset_x = _base_x + (_loop_index * _loop_width);
		
		for(var _anchor_i = 0; _anchor_i < _anchor_count; _anchor_i++){
			var _draw_x = _loop_offset_x + _anchor_x[_anchor_i];
			if(_draw_x + _sprite_width < _camera_x || _draw_x > _camera_right){
				continue;
			}
			
			draw_sprite(_animated_sprite, _frame, _draw_x, _base_y);
			draw_sprite(_base_sprite, 0, _draw_x, _base_y);
		}
	}
}
