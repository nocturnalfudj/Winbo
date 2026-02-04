///@param sprite
function dimensions_system_update(_sprite){
	if(_sprite != noone){
		bounding_box_width = sprite_get_bbox_right(_sprite) - sprite_get_bbox_left(_sprite);
		bounding_box_height = sprite_get_bbox_bottom(_sprite) - sprite_get_bbox_top(_sprite);
	}
	else{
		bounding_box_width = 0;
		bounding_box_height = 0;
	}
	
	width = bounding_box_width * image_xscale;
	height = bounding_box_height * image_yscale;
	
	width_half = width/2;
	height_half = height/2;
}