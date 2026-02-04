/// @function movement_drag_pan_update
/// @summary Update drag and pan camera movement.
/// @param _input_allow Whether input is permitted.
/// @param _zoom_scale Scale factor for zoom adjustments.
/// @returns {boolean} True if movement occurred.
function movement_drag_pan_update(_input_allow,_zoom_scale){
	var _move_update;
	_move_update = false;
	
	//Drag
	if(!pan_active){
		var _drag_move_update;
		_drag_move_update = drag_system_update(_input_allow,_zoom_scale);
		
		if((_move_update == false) && (_drag_move_update)){
			_move_update = true;
		}	
	}
		
	//Pan
	if(!drag_active){
		var _pan_move_update;
		_pan_move_update = pan_system_update(_input_allow,_zoom_scale);
		
		if((_move_update == false) && (_pan_move_update)){
			_move_update = true;
		}	
	}
	
	return _move_update;
}