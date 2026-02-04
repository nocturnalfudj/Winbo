// Inherit the parent event
event_inherited();

//Start Point
with(path_point[0]){
	//Time to Get Back to Start Point
	backward.time = SECOND * 10;
}

//End Point
with(path_point[1]){
	//Target Position
	x = 0;
	y = 1500;
	
	//Time to Get to End Point
	forward.time = SECOND * 10;
}