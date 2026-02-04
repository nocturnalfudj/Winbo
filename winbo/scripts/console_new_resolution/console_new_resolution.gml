function console_new_resolution(){
	with(o_console){
		//Y
		var _transform,_y;
		_transform = transform[TransformType.anchor];
		_y = display_get_gui_height() * o_ui.gui_scale_inverse;
		transform_set(_transform,TransformValue.y,_y,false);
		transform_set_rest(_transform,TransformValue.y,_y,false);
	
		//Height
		bounding_box_height = _y;
		height = bounding_box_height * image_yscale;
	}
}