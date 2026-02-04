function gamepad_draw_crosshair(){
	var _gui_scale,_camera_x,_camera_y,_camera_zoom,_camera_width_ini_half,_camera_height_ini_half;
	_gui_scale = o_ui.gui_scale;
		
	with(o_camera){
		_camera_x = x;
		_camera_y = y;
		_camera_zoom = zoom_resultant;
		_camera_width_ini_half = width_ini_half;
		_camera_height_ini_half = height_ini_half;
	}
		
	var _user,_player_found,_x,_y,_crosshair_sprite;
	for(var _i=0;_i<USER_NUM_MAX;_i++){
		_user = user[_i];
		
		//sdm("_user.gamepad_using: " + string(_user.gamepad_using));
		
		if((_user.joined) && (_user.gamepad_using)){
			//Default to No Player Found
			_player_found = false;
				
			//Go Through Players
			with(o_player){
				//Find Player ID Match
				if(user_id == _i){
					//Mark Player as Found
					_player_found = true;
				}
			}
				
			//If Player Found
			if(_player_found){
				//Set Crosshair Position
				_x = ((_user.gamepad_aim_x - _camera_x) /_camera_zoom) + _camera_width_ini_half;
				_y = ((_user.gamepad_aim_y - _camera_y) /_camera_zoom) + _camera_height_ini_half;
				
				//Scale for GUI
				_x *= _gui_scale;
				_y *= _gui_scale;
		
				//Set Crosshair Sprite
				_crosshair_sprite = _user.gamepad_crosshair;
		
				//Draw Crosshair
				draw_sprite_ext_ags(_crosshair_sprite,0,_x,_y,_gui_scale,_gui_scale,0,c_white,1);
			}
		}
	}
}