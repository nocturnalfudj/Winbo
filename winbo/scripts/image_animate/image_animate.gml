/// @function image_animate
/// @summary Progress an Image struct's animation.
/// @param _image Image struct to update.
function image_animate(_image,_update_sprite_current_frame){
	var _sprite_current_frame;
	_sprite_current_frame = -1;
	with(_image){
		if((animate) && (sprite_current != noone) && (frames_per_second > 0)){
			//Update Image Frame
			frame = floor(position);
		
			//Increase Position Value
			var _delta_time;
			if(image_animation_time_scale_enable)
				_delta_time = global.delta_time_factor_scaled;
			else
				_delta_time = global.delta_time_factor;
			position += frames_per_second*_delta_time;
			
			//Loop
			if(_image.loop){
				var _loop_end;
				_loop_end = loop_end;
				if(_loop_end == IMAGE_LOOP_FULL)
					_loop_end = sprite_number;			
					
				if(position >= _loop_end){
					position = loop_start;
				}
			}
			//End of Animation If Not Looping
			else if(position > sprite_number){
				if (is_playing_queued) {
					// Check if there are more items in the queue
					if (array_length(queue) > 0) {
						// Move to next queued item
						var next_item = queue[0];
						array_delete(queue, 0, 1);
						
						// Set up next queued animation
						sprite_previous = sprite_current;
						sprite_current = next_item.sprite;
						sprite_number = sprite_get_number(sprite_current);
						frames_per_second = next_item.frames_per_second/SECOND;
						position = 0;
						frame = 0;
						animate = true;
						loop = false;
						// Keep is_playing_queued = true
					} else {
						// Queue is empty, switch to target
						sprite_previous = sprite_current;
						sprite_current = target_sprite;
						sprite_number = sprite_get_number(sprite_current);
						frames_per_second = target_frames_per_second/SECOND;
						animate = target_animate;
						loop = target_loop;
						loop_start = target_loop_start;
						loop_end = target_loop_end;
						position = target_loop_start;
						frame = target_loop_start;
						is_playing_queued = false;
					}
				} else {
					// Original logic for non-queued animations
					animate = false;
					position = sprite_number-1;
					frame = position;
				}
			}
			
			_sprite_current_frame = frame;
		}	
	}
	
	_update_sprite_current_frame ??= true;
	
	if(_update_sprite_current_frame){
		if(_sprite_current_frame != -1)
			sprite_current_frame = _sprite_current_frame;
	}
}