/// @function bar_menu_create_main
/// @summary Sets up the main menu bar anchor and animates it into view.
/// @returns {void} No return value.
function bar_menu_create_main(){
	//Main Menu UI
	ui_menu_create_main();
	
	//Get Camera Dimensions
	var _camera_width,_camera_height;
	with(o_camera){
		_camera_width = width_ini;
		_camera_height = height_ini;
	}
	
	//Recoil Into Position
	var _transform,_time_max,_curve;
	_transform = transform[TransformType.anchor];
	_time_max = 0.3*SECOND;
	_curve = ease_quad_out;	
	
	switch(bar_direction){
		case BarDirection.up:
			transform_set(_transform,TransformValue.y,0,false);
			transform_recoil(_transform,TransformValue.y,0,_time_max,_curve);
		break;
		
		case BarDirection.down:
			transform_set(_transform,TransformValue.y,_camera_height,false);
			transform_recoil(_transform,TransformValue.y,0,_time_max,_curve);
		break;
		
		case BarDirection.left:
			transform_set(_transform,TransformValue.x,0,false);
			transform_recoil(_transform,TransformValue.x,0,_time_max,_curve);
		break;
		
		case BarDirection.right:
			transform_set(_transform,TransformValue.x,_camera_width,false);
			transform_recoil(_transform,TransformValue.x,0,_time_max,_curve);
		break;
	}
}