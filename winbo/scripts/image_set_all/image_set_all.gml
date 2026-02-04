function image_set_all(_image,_sprite,_frames_per_second,_animate,_loop,_loop_start,_loop_end){
	var _new_sprite;
	_new_sprite = false;
	with(_image){
		if(_sprite != sprite_current){
			_new_sprite = true;
			
			sprite_previous = sprite_current;
			sprite_current = _sprite;
			sprite_number = sprite_get_number(sprite_current);
		}
		position = 0;
		frame = 0;
		frames_per_second = _frames_per_second/SECOND;
		animate = _animate;
		loop = _loop;
		loop_start = _loop_start;
		loop_end = _loop_end;
	}
	
	if(_new_sprite){
		dimensions_system_update(_sprite);
		
		sprite_current = _sprite;
	}
}