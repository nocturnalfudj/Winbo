function hp_text_poster_heal(_heal){
	//Ignore if Not Enabled
	if(!hp_text_poster_enable_heal)
		exit;
		
	var _x,_y;
	_x = x;
	_y = y;
	_x += irandom_range(-50,50);
	_y += irandom_range(-50,50);
					
	var _heal_text_poster;
	_heal_text_poster = instance_create_layer(_x,_y,"lyr_pfx_midground",o_txtPstr_heal);
	with(_heal_text_poster){
		text_string = string(_heal);
		if(_heal < 1){
			font = fnt_default_16;
		}
		else if(_heal < 5){
			font = fnt_default_30;
		}
		else if(_heal < 25){
			font = fnt_default_42;
		}
		else if(_heal < 50){
			font = fnt_default_52;
		}
		else{
			font = fnt_default_64;
		}
	}
}