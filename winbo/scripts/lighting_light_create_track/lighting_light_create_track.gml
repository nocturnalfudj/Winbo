function lighting_light_create_track(_sprite, _colour, layer, _scale_x, _scale_y,  _offset_x, _offset_y, _angle, _alpha) {
	with(instance_create_layer(x,y,layer,o_light_tracking)) {
		//Set Follow Instance
		follow			= other.id;
		
		//Setup Image
		sprite_index	= _sprite;
		image_blend		= _colour;
		offset_xscale	= _scale_x;
		offset_yscale	= _scale_y;
		image_angle		= _angle;
		offset_alpha	= _alpha;
		offset_x		= _offset_x;
		offset_y		= _offset_y;
		
		//Targets
		offset_x_target = offset_x;
		offset_y_target = offset_y;
		offset_xscale_target = offset_xscale;
		offset_yscale_target = offset_yscale;
		offset_alpha_target = offset_alpha;
		
		//Return Light Instance
		return(id);
	}
}