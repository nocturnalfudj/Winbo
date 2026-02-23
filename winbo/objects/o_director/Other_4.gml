if(room != r_intro && room != r_loading_app){
	depth = 100000;
	layer_set_visible(layer_get_id("lyr_background"),false);
	
	var _environment;
	_environment = director_environment_resolve_room(room);
	environment_set(_environment);
}

bg_anim_time_seconds = 0;
