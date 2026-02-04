function text_ui_text_strings_update(){
	var _string;
		
	//Text
	_string = text_string;
	with(text){
		_string = value;
	}
	text_string = _string;
		
	//Prefix
	_string = prefix_string;
	with(prefix){
		_string = value;
	}
	prefix_string = _string;
		
	//Suffix
	_string = suffix_string;
	with(suffix){
		_string = value;
	}
	suffix_string = _string;
	
	//Final
	text_final_string = prefix_string + text_string + suffix_string;
	
	#region Reveal System
		//If Reveal System Enabled
		if(reveal_enable){
			//Get String Length
			reveal_character_count_total = string_length(text_final_string);
			
			//If Reveal Character Count is Less than String Length
			if(reveal_character_count < reveal_character_count_total){
				//Increase Reveal Character Count
				reveal_character_count += reveal_speed * global.delta_time_factor;
			
				//Round Reveal Character Count
				var _reveal_character_value;
				_reveal_character_value = round(reveal_character_count);
			
				//Update Text Final String to Only Included Revealed Characters
				text_final_string = string_copy(text_final_string,1,_reveal_character_value);
				
				//Reveal Sound
				if(_reveal_character_value mod reveal_sound_character_count_trigger == 0){
					if(reveal_sound != noone)
						audio_sound_play(reveal_sound,AudioChannel.sfx,false,0,0,true);
				}
			
				//Set Reveal Character Count to String Lenght if All Revealed
				if(reveal_character_count >= reveal_character_count_total){
					reveal_character_count = reveal_character_count_total;
				}
			}
		}
	#endregion
}