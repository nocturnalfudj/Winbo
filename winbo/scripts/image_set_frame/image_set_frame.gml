function image_set_frame(_image,_frame){
	with(_image){
		position = _frame;
		frame = _frame;
	}
	
	sprite_current_frame = _frame;
}