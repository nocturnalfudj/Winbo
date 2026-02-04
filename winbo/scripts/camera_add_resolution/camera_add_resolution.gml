/// Register a new resolution option and optionally activate it immediately.
/// @param _width    Width in pixels
/// @param _height   Height in pixels
/// @param _force_use Optional flag to make this the active resolution
function camera_add_resolution(_width,_height,_force_use){
	//Add to Resolution Array
	resolution[resolution_slot_count][RES_W] = _width;
	resolution[resolution_slot_count][RES_H] = _height;
	
	//Check if Resolution Matches Display
	if((_width == display_width) && (_height == display_height)){
		//Set Slot as Display Resolution Slot
		resolution_slot_display = resolution_slot_count;
	}
	
	//Force Use
	_force_use ??= false;
	if(_force_use){
		resolution_slot_display = resolution_slot_count;
	}
	
	//Increase Slot Count
	resolution_slot_count++;
}