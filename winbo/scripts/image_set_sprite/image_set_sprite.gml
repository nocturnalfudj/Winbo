/// @function image_set_sprite
/// @summary Switch the sprite on an image instance and optionally reset position.
function image_set_sprite(_image,_sprite,_position_reset){
	var _new_sprite;
	_new_sprite = false;
	
	//Default Position Reet to True
	_position_reset ??= true;
		
	with(_image){
		if(_sprite != sprite_current){
			_new_sprite = true;
			
			sprite_previous = sprite_current;
			sprite_current = _sprite;
			if(sprite_current == noone)
				sprite_number = 0;
			else
				sprite_number = sprite_get_number(sprite_current);
			
			if(_position_reset){
				position = 0;
				frame = 0;
			}
		}
	}
	
	if(_new_sprite){
		dimensions_system_update(_sprite);
		
		sprite_current = _sprite;
	}
}