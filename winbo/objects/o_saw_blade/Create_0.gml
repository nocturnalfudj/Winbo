event_inherited();

sprite_current = spr_saw_blade;
image_xscale = 1;
image_yscale = 1;
image_system_setup(sprite_current, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);

saw_track_group = 0;
saw_move_enabled = 1;
saw_path_seconds = SECOND * 3;
damage_amount = 1;
instant_kill = false;

saw_track_draw = true;
saw_track_bound = noone;
saw_path_loop = true;
saw_path_loop_swap_direction = true;
saw_path_direction = 1;
saw_path_point_current = 0;
saw_path_time = 0;
saw_path_point_start_x = 0;
saw_path_point_start_y = 0;
saw_path_x = 0;
saw_path_y = 0;
saw_start_x = x;
saw_start_y = y;
saw_track_draw_width_scale = 1;
saw_track_draw_height_scale = 1;

saw_path_make_point = function(_x,_y,_time){
	return {
		x: _x,
		y: _y,
		forward: {
			ease_x: ease_quad_in_out,
			ease_y: ease_quad_in_out,
			time: _time
		},
		backward: {
			ease_x: ease_quad_in_out,
			ease_y: ease_quad_in_out,
			time: _time
		},
	};
};

saw_path_configure_loop_points = function(_points){
	saw_path_point = array_create(0);
	
	for(var _i = 0; _i < array_length(_points); _i++){
		saw_path_point[_i] = saw_path_make_point(_points[_i].x,_points[_i].y,saw_path_seconds);
	}
	
	if(saw_move_enabled > 0){
		saw_path_loop = true;
		saw_path_loop_swap_direction = false;
	}
	else{
		saw_path_point = [saw_path_point[0]];
		saw_path_loop = false;
		saw_path_loop_swap_direction = false;
	}
	
	saw_path_point_total = array_length(saw_path_point);
	saw_path_direction = 1;
	saw_path_point_current = (saw_path_point_total > 1) ? 1 : 0;
	saw_path_time = 0;
	saw_path_point_start_x = 0;
	saw_path_point_start_y = 0;
	saw_path_x = 0;
	saw_path_y = 0;
	x = saw_start_x;
	y = saw_start_y;
};

saw_path_reset = function(){
	saw_path_point = array_create(0);
	saw_path_point[0] = saw_path_make_point(0,0,saw_path_seconds);
	saw_path_point_total = array_length(saw_path_point);
	saw_path_direction = 1;
	saw_path_point_current = 0;
	saw_path_time = 0;
	saw_path_point_start_x = 0;
	saw_path_point_start_y = 0;
	saw_path_x = 0;
	saw_path_y = 0;
	x = saw_start_x;
	y = saw_start_y;
};

saw_path_configure_loop = function(_track_width,_track_height,_placed_x,_placed_y){
	var _left = saw_track_bound.x;
	var _top = saw_track_bound.y;
	var _right = _left + _track_width;
	var _bottom = _top + _track_height;
	var _corner = 0;
	var _corner_distance = point_distance(_placed_x,_placed_y,_left,_top);
	var _distance = point_distance(_placed_x,_placed_y,_right,_top);
	
	if(_distance < _corner_distance){
		_corner = 1;
		_corner_distance = _distance;
	}
	
	_distance = point_distance(_placed_x,_placed_y,_right,_bottom);
	if(_distance < _corner_distance){
		_corner = 2;
		_corner_distance = _distance;
	}
	
	_distance = point_distance(_placed_x,_placed_y,_left,_bottom);
	if(_distance < _corner_distance){
		_corner = 3;
	}
	
	switch(_corner){
		case 0:
			saw_start_x = _left;
			saw_start_y = _top;
			saw_path_configure_loop_points([
				{x:0,y:0},
				{x:_track_width,y:0},
				{x:_track_width,y:_track_height},
				{x:0,y:_track_height},
			]);
		break;
		
		case 1:
			saw_start_x = _right;
			saw_start_y = _top;
			saw_path_configure_loop_points([
				{x:0,y:0},
				{x:0,y:_track_height},
				{x:-_track_width,y:_track_height},
				{x:-_track_width,y:0},
			]);
		break;
		
		case 2:
			saw_start_x = _right;
			saw_start_y = _bottom;
			saw_path_configure_loop_points([
				{x:0,y:0},
				{x:-_track_width,y:0},
				{x:-_track_width,y:-_track_height},
				{x:0,y:-_track_height},
			]);
		break;
		
		default:
			saw_start_x = _left;
			saw_start_y = _bottom;
			saw_path_configure_loop_points([
				{x:0,y:0},
				{x:0,y:-_track_height},
				{x:_track_width,y:-_track_height},
				{x:_track_width,y:0},
			]);
		break;
	}
};

saw_path_configure_from_track = function(){
	saw_track_bound = noone;
	var _nearest_distance = 1000000000;
	var _track_count = instance_number(o_saw_track);

	for(var _i = 0; _i < _track_count; _i++){
		var _candidate = instance_find(o_saw_track,_i);
		if(_candidate.saw_track_group == saw_track_group){
			var _candidate_distance = point_distance(x,y,_candidate.x + (_candidate.saw_track_width * 0.5),_candidate.y + (_candidate.saw_track_height * 0.5));
			if(_candidate_distance < _nearest_distance){
				_nearest_distance = _candidate_distance;
				saw_track_bound = _candidate;
			}
		}
	}

	saw_track_draw = (saw_track_bound == noone);

	if(saw_track_bound == noone){
		saw_start_x = x;
		saw_start_y = y;
		saw_path_reset();
		return;
	}

	var _track_width = saw_track_bound.saw_track_width;
	var _track_height = saw_track_bound.saw_track_height;
	saw_path_configure_loop(_track_width,_track_height,x,y);
	x = saw_start_x;
	y = saw_start_y;
};

saw_path_reset();
