event_inherited();

var _wall_sprite = (shifting_wall_variant == 1) ? spr_shifting_wall_stone : spr_shifting_wall;
sprite_current = _wall_sprite;
sprite_solo = _wall_sprite;
sprite_ns = _wall_sprite;
sprite_index = _wall_sprite;
image_xscale = shifting_wall_scale;
image_yscale = shifting_wall_scale;
use_ns = false;
shifting_wall_track_draw = true;
shifting_wall_track_bound = noone;
shifting_wall_horizontal = false;

shifting_wall_path_configure = function(){
	shifting_wall_track_bound = noone;
	var _nearest_distance = 1000000000;
	var _track_count = instance_number(o_shifting_wall_track);

	for(var _i = 0; _i < _track_count; _i++){
		var _candidate = instance_find(o_shifting_wall_track,_i);
		if(_candidate.shifting_wall_track_group == shifting_wall_track_group){
			var _candidate_distance = point_distance(x,y,_candidate.x + (_candidate.shifting_wall_track_width * 0.5),_candidate.y + (_candidate.shifting_wall_track_height * 0.5));
			if(_candidate_distance < _nearest_distance){
				_nearest_distance = _candidate_distance;
				shifting_wall_track_bound = _candidate;
			}
		}
	}

	shifting_wall_track_draw = (shifting_wall_track_bound == noone);
	shifting_wall_horizontal = false;
	image_angle = 0;
	var _path_seconds = shifting_wall_path_seconds;

	with(path_point[0]){
		x = 0;
		y = 0;
		forward.time = _path_seconds;
		backward.time = _path_seconds;
	}

	with(path_point[1]){
		x = 0;
		y = -320;
		forward.time = _path_seconds;
		backward.time = _path_seconds;
	}

	if(shifting_wall_track_bound == noone){
		start_x = x;
		start_y = y;
	}
	else{
		var _track_width = shifting_wall_track_bound.shifting_wall_track_width;
		var _track_height = shifting_wall_track_bound.shifting_wall_track_height;
		var _track_angle = abs(round(shifting_wall_track_bound.image_angle)) mod 180;
		var _wall_width = sprite_get_width(sprite_current) * abs(image_xscale);
		var _wall_height = sprite_get_height(sprite_current) * abs(image_yscale);

		shifting_wall_horizontal = (_track_angle == 90) || (_track_width > (_track_height * 1.5));

		if(shifting_wall_horizontal){
			var _track_length_h = (_track_angle == 90) ? _track_height : _track_width;
			var _track_thickness_h = (_track_angle == 90) ? _track_width : _track_height;
			var _track_travel_h = max(0,_track_length_h - _wall_height);

			image_angle = 90;
			start_x = shifting_wall_track_bound.x + _track_travel_h;

			if(_track_angle == 90){
				start_y = shifting_wall_track_bound.y + ((_wall_width - _track_thickness_h) * 0.5);
			}
			else{
				start_y = shifting_wall_track_bound.y + ((_wall_width + _track_thickness_h) * 0.5);
			}

			path_point[1].x = -_track_travel_h;
			path_point[1].y = 0;
		}
		else{
			var _track_travel_v = max(0,_track_height - _wall_height);

			start_x = shifting_wall_track_bound.x + ((_track_width - _wall_width) * 0.5);
			start_y = shifting_wall_track_bound.y + _track_travel_v;
			path_point[1].x = 0;
			path_point[1].y = -_track_travel_v;
		}

		x = start_x;
		y = start_y;
	}

	path_point_total = array_length(path_point);
	path_loop = true;
	path_loop_swap_direction = true;
	path_direction = 1;
	path_point_current = (path_point_total > 1) ? 1 : 0;
	path_time = 0;
	path_point_start_x = 0;
	path_point_start_y = 0;
	path_x = 0;
	path_y = 0;
	x = start_x;
	y = start_y;
};

var _path_seconds_default = shifting_wall_path_seconds;

with(path_point[0]){
	x = 0;
	y = 0;
	forward.time = _path_seconds_default;
	backward.time = _path_seconds_default;
}

with(path_point[1]){
	x = 0;
	y = -320;
	forward.time = _path_seconds_default;
	backward.time = _path_seconds_default;
}

path_point_total = array_length(path_point);
path_loop = true;
path_loop_swap_direction = true;
path_direction = 1;
path_point_current = (path_point_total > 1) ? 1 : 0;
path_time = 0;
path_point_start_x = 0;
path_point_start_y = 0;
path_x = 0;
path_y = 0;
start_x = x;
start_y = y;
