function movement_limit_enable_y(_min,_max){
	//Enable
	move_limit_enable_y = true;
	
	//Limit Vectors
	move_limit_y = new Vector2(_min,_max);
}