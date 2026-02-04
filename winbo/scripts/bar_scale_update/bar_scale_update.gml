/// @function bar_scale_update
/// @summary Scale a UI bar sprite based on camera dimensions and orientation.
function bar_scale_update(){
	//Get Camera Dimensions
	var _camera_width,_camera_height;
	with(o_camera){
		_camera_width = width_ini;
		_camera_height = height_ini;
	}
	
	switch(bar_direction){
		case BarDirection.up:
			image_xscale = _camera_width;
			image_yscale = y;
		break;
		
		case BarDirection.down:
			image_xscale = _camera_width;
			image_yscale = _camera_height - y;
		break;
		
		case BarDirection.left:
			image_xscale = x;
			image_yscale = _camera_height;
		break;
		
		case BarDirection.right:
			image_xscale = _camera_width - x;
			image_yscale = _camera_height;
		break;
	}
}