//Check if Object is Visible to the Camera
if(gui){
	camera_visible_check_gui(camera_visible_buff_width,camera_visible_buff_height);
}
else{
	camera_visible_check(camera_visible_buff_width,camera_visible_buff_height);
}
//Interaction
mouse_collision = false;