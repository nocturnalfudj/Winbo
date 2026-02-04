/// @function character_face
/// @summary Update facing direction and sprite frames.
/// @param _image_update Update sprite images when true.
/// @returns {void} No return value.
function character_face(_image_update){
	//Default to Update Image
	_image_update ??= true;
	
	//Vertical
	if(face_vertical_update_enable){
		if((input_aim_direction > 45) && (input_aim_direction < 135)){
			face_vertical = -1;
			
			if(_image_update)
				image_set_sprite(image,sprite_back,false);
		}
		else{
			face_vertical = 1;
			
			if(_image_update)
				image_set_sprite(image,sprite_front,false);
		}
	}

	//Horizontal
	if((face_horizontal_update_enable) && (input_move_magnitude > 0)){
		if((input_aim_direction > 90) && (input_aim_direction < 270)){
			face_horizontal = -1;
			//face_horizontal = lerp_with_gap_close(face_horizontal,-1,0.25,0.1);
		}
		else{
			face_horizontal = 1;
			//face_horizontal = lerp_with_gap_close(face_horizontal,1,0.25,0.1);
		}
	}
}