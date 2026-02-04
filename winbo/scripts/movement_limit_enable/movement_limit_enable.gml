function movement_limit_enable(_x_min,_x_max,_y_min,_y_max){
	//Enable
	move_limit_enable_x = true;
	move_limit_enable_y = true;
	
	//Limit Vectors
	move_limit_x = new Vector2(_x_min,_x_max);
	move_limit_y = new Vector2(_y_min,_y_max);
}