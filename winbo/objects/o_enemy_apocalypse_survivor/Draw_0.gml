// Custom drawing for Apocalypse Survivor aiming (layered rotation + laser)
// Falls back to inherited draw for non-aim states.

// Only custom-draw when hostile AND kneeling (aiming states), NOT during startled/death
var _do_custom;
_do_custom = aim_two_layer_enable
	&& is_hostile
	&& is_kneeling
	&& (state == EnemyState.move || state == EnemyState.attack_telegraph || state == EnemyState.attack_active || state == EnemyState.attack_recover);

if(!_do_custom){
	event_inherited();
	exit;
}

// Ignore if not visible
if(!camera_visible){
	exit;
}

// Ensure we have a target
if(!variable_instance_exists(id, "target") || target[TargetType.attack] == noone || !target[TargetType.attack].has_valid_target()){
	event_inherited();
	exit;
}

// Determine aim angle and set facing
var _tx = target[TargetType.attack].x;
var _ty = target[TargetType.attack].y;
var _target_aim_x = _tx;
var _target_aim_y = _ty;
var _target_instance = target[TargetType.attack].instance;
if(_target_instance != noone && instance_exists(_target_instance)){
	_target_aim_x = (_target_instance.bbox_left + _target_instance.bbox_right) * 0.5;
	_target_aim_y = _target_instance.bbox_top + (_target_instance.bbox_bottom - _target_instance.bbox_top) * 0.35;
}

aim_angle = point_direction(x, y, _target_aim_x, _target_aim_y);
face_horizontal = (_tx >= x) ? 1 : -1;

var _aim_data = apocalypse_survivor_get_aim_data();
var _sector = _aim_data.sector;
var _draw_angle = _aim_data.draw_angle;
var _barrel_x = _aim_data.barrel_x;
var _barrel_y = _aim_data.barrel_y;
var _muzzle_x = _aim_data.muzzle_x;
var _muzzle_y = _aim_data.muzzle_y;

// Select sprite set based on sector AND state (aim vs shoot)
// During attack_active, use animated shoot sprites; otherwise use static aim sprites
var _spr_legs = sprite_aim_side_legs;
var _spr_body = sprite_aim_side_body;
var _is_shooting = (state == EnemyState.attack_active);

switch(_sector){
	case "side":
	case "side_flip":
		if(_is_shooting){
			_spr_legs = sprite_shoot_side_legs;
			_spr_body = sprite_shoot_side_body;
		}else{
			_spr_legs = sprite_aim_side_legs;
			_spr_body = sprite_aim_side_body;
		}
	break;

	case "diag":
	case "diag_flip":
		if(_is_shooting){
			_spr_legs = sprite_shoot_diag_legs;
			_spr_body = sprite_shoot_diag_body;
		}else{
			_spr_legs = sprite_aim_diag_legs;
			_spr_body = sprite_aim_diag_body;
		}
	break;

	case "up":
		if(_is_shooting){
			_spr_legs = sprite_shoot_up_legs;
			_spr_body = sprite_shoot_up_body;
		}else{
			_spr_legs = sprite_aim_up_legs;
			_spr_body = sprite_aim_up_body;
		}
	break;

	case "out":
		// Behind the character - don't draw aim, fall back to side
		if(_is_shooting){
			_spr_legs = sprite_shoot_side_legs;
			_spr_body = sprite_shoot_side_body;
		}else{
			_spr_legs = sprite_aim_side_legs;
			_spr_body = sprite_aim_side_body;
		}
	break;
}

// Compute draw xscale based on facing
// Account for sprite_face_direction (sprites face left by default)
var _aim_xscale = image_xscale * face_horizontal * sprite_face_direction;

// Get the body frame for animation
var _body_frame = 0;
if(_is_shooting){
	_body_frame = sprite_current_frame;
}

// UPWARD sector uses 3 layers (legs/bottom, mid/rotating, body/top)
if(_sector == "up"){
	// Get upward sprite sets
	var _spr_up_legs = _is_shooting ? sprite_shoot_up_legs : sprite_aim_up_legs;
	var _spr_up_mid = _is_shooting ? sprite_shoot_up_mid : sprite_aim_up_mid;
	var _spr_up_body = _is_shooting ? sprite_shoot_up_body : sprite_aim_up_body;

	// Frame handling for shooting
	var _legs_frame = 0;
	var _mid_frame = 0;
	if(_is_shooting){
		if(_spr_up_legs != noone) _legs_frame = min(sprite_current_frame, sprite_get_number(_spr_up_legs) - 1);
		if(_spr_up_mid != noone) _mid_frame = min(sprite_current_frame, sprite_get_number(_spr_up_mid) - 1);
		_body_frame = min(sprite_current_frame, sprite_get_number(_spr_up_body) - 1);
	}

	// Draw layer 1: Bottom (legs/body part) - STATIC
	if(_spr_up_legs != noone){
		draw_sprite_ext(
			_spr_up_legs,
			_legs_frame,
			x + aim_legs_sprite_offset_x,
			y + aim_legs_sprite_offset_y,
			_aim_xscale,
			image_yscale,
			0,
			image_blend,
			image_alpha
		);
	}

	// Draw layer 2: Middle (rotating torso/arm) - ROTATES
	if(_spr_up_mid != noone){
		draw_sprite_ext(
			_spr_up_mid,
			_mid_frame,
			x + aim_body_sprite_offset_x,
			y + aim_body_sprite_offset_y,
			_aim_xscale,
			image_yscale,
			_draw_angle,
			image_blend,
			image_alpha
		);
	}

	// Draw layer 3: Top (front knee) - STATIC
	if(_spr_up_body != noone){
		draw_sprite_ext(
			_spr_up_body,
			_body_frame,
			x + aim_body_sprite_offset_x,
			y + aim_body_sprite_offset_y,
			_aim_xscale,
			image_yscale,
			0,
			image_blend,
			image_alpha
		);
	}
}
else{
	// SIDE and DIAGONAL sectors use 2 layers (legs/static, body/rotating)

	// Draw base enemy (legs) first (static, no rotation)
	if(_spr_legs != noone){
		var _legs_frame = 0;
		if(_is_shooting){
			var _legs_num_frames = sprite_get_number(_spr_legs);
			_legs_frame = min(sprite_current_frame, _legs_num_frames - 1);
		}
		draw_sprite_ext(
			_spr_legs,
			_legs_frame,
			x + aim_legs_sprite_offset_x,
			y + aim_legs_sprite_offset_y,
			_aim_xscale,
			image_yscale,
			0,
			image_blend,
			image_alpha
		);
	}

	// Draw body (rotated to aim)
	if(_spr_body != noone){
		draw_sprite_ext(
			_spr_body,
			_body_frame,
			x + aim_body_sprite_offset_x,
			y + aim_body_sprite_offset_y,
			_aim_xscale,
			image_yscale,
			_draw_angle,
			image_blend,
			image_alpha
		);
	}
}

// Laser sight (skip if out-of-sight sector)
if(_sector != "out"){
	var _lx0 = _muzzle_x;
	var _ly0 = _muzzle_y;
	var _lx1 = _lx0;
	var _ly1 = _ly0;

	var _clip_step = max(1, laser_clip_step_px);
	var _clip_object = laser_clip_collision_object;
	if(_clip_object == noone){
		_clip_object = attack_los_collision_object;
	}
	var _steps = ceil(laser_length / _clip_step);

	var _prev_x = _lx0;
	var _prev_y = _ly0;
	for(var _i = 1; _i <= _steps; _i++){
		var _distance = min(laser_length, _i * _clip_step);
		var _next_x = _lx0 + lengthdir_x(_distance, aim_angle);
		var _next_y = _ly0 + lengthdir_y(_distance, aim_angle);

		var _hit = false;
		if(_clip_object != noone){
			_hit = collision_line(_prev_x, _prev_y, _next_x, _next_y, _clip_object, true, true) != noone;
		}

		if(_hit){
			break;
		}

		_lx1 = _next_x;
		_ly1 = _next_y;
		_prev_x = _next_x;
		_prev_y = _next_y;
	}

	draw_set_alpha(laser_alpha);
	draw_set_color(laser_color);
	draw_line_width(_lx0, _ly0, _lx1, _ly1, laser_width);
	draw_set_alpha(1);
	draw_set_color(c_white);
}

// Muzzle flash + shell (optional; uses string asset lookup so it won't crash if missing)
// Shared rotation for FX offsets
var _fx_base_x = _barrel_x * face_horizontal;
var _fx_base_y = _barrel_y;
var _fx_dist = point_distance(0, 0, _fx_base_x, _fx_base_y);
var _fx_dir = point_direction(0, 0, _fx_base_x, _fx_base_y);
var _fx_x = x + lengthdir_x(_fx_dist, _fx_dir + _draw_angle);
var _fx_y = y + lengthdir_y(_fx_dist, _fx_dir + _draw_angle);

if(muzzle_flash_timer > 0){
	var _spr_flash = asset_get_index("spr_muzzle_flash_rifle");
	if(_spr_flash >= 0){
		var _frame = floor((1 - (muzzle_flash_timer / muzzle_flash_timer_max)) * (sprite_get_number(_spr_flash) - 1));
		draw_sprite_ext(_spr_flash, _frame, _fx_x, _fx_y, face_horizontal, 1, aim_angle, c_white, 1);
	}
}

if(shell_timer > 0){
	var _spr_shell = asset_get_index("spr_bullet_shell_empty");
	if(_spr_shell >= 0){
		// Shell ejects slightly behind the barrel
		var _shell_base_x = (_barrel_x - 20) * face_horizontal;
		var _shell_base_y = _barrel_y + 10;
		var _s_dist = point_distance(0, 0, _shell_base_x, _shell_base_y);
		var _s_dir = point_direction(0, 0, _shell_base_x, _shell_base_y);
		var _sx = x + lengthdir_x(_s_dist, _s_dir + _draw_angle);
		var _sy = y + lengthdir_y(_s_dist, _s_dir + _draw_angle);
		draw_sprite_ext(_spr_shell, 0, _sx, _sy, 1, 1, 0, c_white, shell_timer / shell_timer_max);
	}
}

// Flash effect
if(flash_alpha > 0 && sprite_current != noone && sprite_current >= 0){
	shader_set(sh_monochrome);
	draw_sprite_ext(sprite_current, sprite_current_frame, x, y, image_xscale, image_yscale, image_angle, flash_colour, flash_alpha);
	shader_reset();
}

// Info bar
info_bar_system_draw();

// Dev debug
if(o_master.dev_mode){
	draw_bounding_box();
	draw_set_color(c_yellow);
	draw_text(x + 40, y - 80, "aim=" + string(round(aim_angle)) + " sector=" + _sector + " rot=" + string(round(_draw_angle)));
	draw_set_color(c_white);
}
