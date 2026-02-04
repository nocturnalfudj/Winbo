/// @description Apply Current Resolution
var _width,_height,_aspect_ratio;
_width = resolution[resolution_slot_current][RES_W];
_height = resolution[resolution_slot_current][RES_H];
_aspect_ratio = _width/_height;

if(IS_MOBILE){
	if(orientation == Orientation.portrait){
		if(_aspect_ratio > 0.5)
			camera_apply_resolution_intended_height(_width,_height);
		else
			camera_apply_resolution_intended_width(_width,_height);
	}
	else{
		camera_apply_resolution_intended_width(_width,_height);
	}
}
else{
	//camera_apply_resolution_intended_height(_width,_height);
	
	if(_aspect_ratio < 0.5)
		camera_apply_resolution_intended_height(_width,_height);
	else
		camera_apply_resolution_intended_width(_width,_height);
}

if(global.game_state == GameState.boot)
	o_master.boot_finished_camera = true;