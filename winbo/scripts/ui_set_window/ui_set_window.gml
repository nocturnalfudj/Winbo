/// @function ui_set_window
/// @summary Assign a window object to a UI element and track it for drawing.
/// @param _id      UI element instance ID
/// @param _window  Window instance that will render the element
function ui_set_window(_id,_window){
	with(_id){
		window = _window;
		visible = false;
	}
	with(_window){
		ds_list_add(surface_draw,_id);
		surface_draw_size = ds_list_size(surface_draw);
	}
}