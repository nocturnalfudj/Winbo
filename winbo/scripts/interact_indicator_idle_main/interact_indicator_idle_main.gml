function interact_indicator_idle_main(){
	#region Update Position
		var _position_relative_instance_exists;
		_position_relative_instance_exists = false;
	
		var _x,_y;
		_x = x;
		_y = y;
		with(position_relative_instance){
			_position_relative_instance_exists = true;
		
			_x = x;
			_y = y;
		}
	
		if(_position_relative_instance_exists){
			_x += position_relative_x;
			_y += position_relative_y;
			
			
			_x = lerp(_x,transform_parent.value[TransformValue.x],0.33);
			_y = lerp(_y,transform_parent.value[TransformValue.y],0.33);
	
			var _transform;
			_transform = transform[TransformType.anchor];
			transform_set(_transform,TransformValue.x,_x,false);
			transform_set(_transform,TransformValue.y,_y,false);
		}
	#endregion
	
	#region NOT Contributing to Down Time
		with(interaction){
			indicator_object_contributing_to_down_time = false;
		}
	#endregion
	
	#region Update Down Percent
		if(down_time_indicator_enable){
			var _percent;
			_percent = 0;
			
			with(interaction){
				_percent = down_time_current / down_time_required;
			}
			
			if(_percent > 1)
				_percent = 1;
				
			down_time_indicator_percent = _percent;
		}
	#endregion
	
	#region Update Title & Key Draw
		var _title_string,_title_colour,_subtitle_string,_subtitle_colour;
		_title_string = title_string;
		_title_colour = title_colour;
		_subtitle_string = subtitle_string;
		_subtitle_colour = subtitle_colour;
		
		var _key_draw_enable;
		_key_draw_enable = key_draw_enable;
		
		with(interaction){
			_title_string = title_string;
			_title_colour = title_colour;
			_subtitle_string = subtitle_string;
			_subtitle_colour = subtitle_colour;
			
			_key_draw_enable = indicator_control_key_draw_enable;
		}
		
		title_string = _title_string;
		title_colour = _title_colour;
		
		subtitle_string = _subtitle_string;
		subtitle_colour = _subtitle_colour;
		
		key_draw_enable = _key_draw_enable;
	#endregion
}