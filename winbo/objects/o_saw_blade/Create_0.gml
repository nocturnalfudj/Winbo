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

saw_path_reset = function(_x,_y,_time){
	saw_path_point = array_create(0);
	saw_path_point[0] = saw_path_make_point(0,0,_time);
	saw_track_draw_width_scale = max(1,(abs(_x) + sprite_get_width(spr_saw_blade)) / sprite_get_width(spr_saw_track));
	saw_track_draw_height_scale = max(1,(abs(_y) + sprite_get_height(spr_saw_blade)) / sprite_get_height(spr_saw_track));

	if((saw_move_enabled > 0) && ((_x != 0) || (_y != 0))){
		saw_path_point[1] = saw_path_make_point(_x,_y,_time);
		saw_path_loop = true;
		saw_path_loop_swap_direction = true;
	}
	else{
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
		saw_path_reset(320,0,saw_path_seconds);
		return;
	}

	var _track_width = saw_track_bound.saw_track_width;
	var _track_height = saw_track_bound.saw_track_height;
	var _blade_radius_x = sprite_get_width(spr_saw_blade) * 0.5 * abs(image_xscale);
	var _blade_radius_y = sprite_get_height(spr_saw_blade) * 0.5 * abs(image_yscale);
	var _track_center_x = saw_track_bound.x + (_track_width * 0.5);
	var _track_center_y = saw_track_bound.y + (_track_height * 0.5);
	var _track_travel_x = max(0,_track_width - (_blade_radius_x * 2));
	var _track_travel_y = max(0,_track_height - (_blade_radius_y * 2));
	var _track_mode = saw_track_bound.saw_track_mode;

	if(_track_mode == 0){
		if(_track_width >= (_track_height * 1.5)){
			_track_mode = 1;
		}
		else if(_track_height >= (_track_width * 1.5)){
			_track_mode = 2;
		}
		else{
			_track_mode = 3;
		}
	}

	switch(_track_mode){
		case 1:
			saw_start_x = (_track_travel_x > 0) ? saw_track_bound.x + _blade_radius_x : _track_center_x;
			saw_start_y = _track_center_y;
			saw_path_reset(_track_travel_x,0,saw_path_seconds);
		break;

		case 2:
			saw_start_x = _track_center_x;
			saw_start_y = (_track_travel_y > 0) ? saw_track_bound.y + _blade_radius_y : _track_center_y;
			saw_path_reset(0,_track_travel_y,saw_path_seconds);
		break;

		default:
			saw_start_x = (_track_travel_x > 0) ? saw_track_bound.x + _blade_radius_x : _track_center_x;
			saw_start_y = (_track_travel_y > 0) ? saw_track_bound.y + _blade_radius_y : _track_center_y;
			saw_path_reset(_track_travel_x,0,saw_path_seconds);

			if((saw_move_enabled > 0) && ((_track_travel_x != 0) || (_track_travel_y != 0))){
				saw_path_point[2] = saw_path_make_point(_track_travel_x,_track_travel_y,saw_path_seconds);
				saw_path_point[3] = saw_path_make_point(0,_track_travel_y,saw_path_seconds);
				saw_path_point_total = array_length(saw_path_point);
				saw_path_loop = true;
				saw_path_loop_swap_direction = false;
			}
		break;
	}

	x = saw_start_x;
	y = saw_start_y;
};

saw_path_reset(320,0,saw_path_seconds);
