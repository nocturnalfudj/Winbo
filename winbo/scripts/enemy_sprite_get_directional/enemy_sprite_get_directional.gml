/// @function enemy_sprite_get_directional
/// @summary Return directional sprite based on face_horizontal when enabled.
/// @param _sprite_left  Sprite facing left
/// @param _sprite_right Sprite facing right
/// @returns {asset.GMSprite} Selected sprite
function enemy_sprite_get_directional(_sprite_left,_sprite_right){
	if(!sprite_direction_enable){
		return _sprite_left; // symmetric sprites rely on xscale flip
	}
	
	if(face_horizontal == -1){
		return _sprite_left;
	}
	else{
		return _sprite_right;
	}
}
