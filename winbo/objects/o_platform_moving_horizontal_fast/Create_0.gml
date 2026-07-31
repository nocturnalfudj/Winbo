// Inherit the parent event
event_inherited();

var _travel_time = SECOND * 0.75;

//Start Point
with(path_point[0]){
	//Time to Get Back to Start Point
	backward.time = _travel_time;
	backward.ease_x = ease_linear;
	backward.ease_y = ease_linear;
}

//End Point
with(path_point[1]){
	//Target Position
	x = 0;
	y = 1500;
	
	//Time to Get to End Point
	forward.time = _travel_time;
	forward.ease_x = ease_linear;
	forward.ease_y = ease_linear;
}
