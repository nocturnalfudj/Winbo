// Custom drawing for Apocalypse Survivor aiming (layered rotation + laser)
// Falls back to inherited draw for non-aim states.

// Only custom-draw when hostile (kneeling/aiming) OR during attack telegraph
var _do_custom;
_do_custom = aim_two_layer_enable && (is_hostile || state == EnemyState.attack_telegraph);

if(!_do_custom){
	event_inherited();
	exit;
}

// Ignore if not visible
if(!camera_visible){
	exit;
}

// Ensure we have a target
if(!variable_instance_exists(id, "target") || !instance_exists(target[TargetType.attack].object)){
	event_inherited();
	exit;
}

// Determine aim angle and set facing
var _tx = target[TargetType.attack].x;
var _ty = target[TargetType.attack].y;
aim_angle = point_direction(x, y, _tx, _ty);
face_horizontal = (_tx >= x) ? 1 : -1;

// Sector selection (per Aiming Logic Diagram)
// Note: GMS angles are 0=right, 90=up, 180=left, 270=down.
var _sector;
_sector = "none";
if(aim_angle >= 315 || aim_angle < 45) _sector = "side";
else if(aim_angle >= 45 && aim_angle < 85) _sector = "diag";
else if(aim_angle >= 85 && aim_angle < 95) _sector = "up";
else if(aim_angle >= 95 && aim_angle < 135) _sector = "diag_flip";
else if(aim_angle >= 135 && aim_angle < 225) _sector = "side_flip";
else _sector = "out"; // 225-315

// Placeholder sprite set switching:
// When proper diagonal/upward sprites are imported, swap these per-sector.
var _spr_legs = sprite_aim_legs;
var _spr_body = sprite_aim_body;

// Compute draw xscale and rotation based on facing
// Account for sprite_face_direction (sprites face left by default)
var _aim_xscale = image_xscale * face_horizontal * sprite_face_direction;
var _draw_angle = (face_horizontal == 1) ? aim_angle : (aim_angle + 180);

// Draw base enemy (legs) first (static, no rotation)
if(_spr_legs != noone){
	draw_sprite_ext(
		_spr_legs,
		0,
		x + aim_legs_sprite_offset_x,
		y + aim_legs_sprite_offset_y,
		_aim_xscale,
		image_yscale,
		0,
		image_blend,
		image_alpha
	);
}

// Draw body (rotated)
if(_spr_body != noone){
	draw_sprite_ext(
		_spr_body,
		sprite_current_frame,
		x + aim_body_sprite_offset_x,
		y + aim_body_sprite_offset_y,
		_aim_xscale,
		image_yscale,
		_draw_angle,
		image_blend,
		image_alpha
	);
}

// Laser sight (skip if out-of-sight sector)
if(_sector != "out"){
	var _lx0 = x + (laser_origin_offset_x * face_horizontal);
	var _ly0 = y + laser_origin_offset_y;
	var _lx1 = _lx0 + lengthdir_x(laser_length, aim_angle);
	var _ly1 = _ly0 + lengthdir_y(laser_length, aim_angle);

	draw_set_alpha(laser_alpha);
	draw_set_color(laser_color);
	draw_line_width(_lx0, _ly0, _lx1, _ly1, laser_width);
	draw_set_alpha(1);
	draw_set_color(c_white);
}

// Muzzle flash + shell (optional; uses string asset lookup so it won't crash if missing)
if(muzzle_flash_timer > 0){
	var _spr_flash = asset_get_index("spr_muzzle_flash_rifle");
	if(_spr_flash >= 0){
		var _frame = floor((1 - (muzzle_flash_timer / muzzle_flash_timer_max)) * (sprite_get_number(_spr_flash) - 1));
		var _mx = x + (attack_projectile_spawn_offset_x * face_horizontal);
		var _my = y + attack_projectile_spawn_offset_y;
		draw_sprite_ext(_spr_flash, _frame, _mx, _my, face_horizontal, 1, aim_angle, c_white, 1);
	}
}

if(shell_timer > 0){
	var _spr_shell = asset_get_index("spr_bullet_shell_empty");
	if(_spr_shell >= 0){
		var _sx = x + (attack_projectile_spawn_offset_x * face_horizontal) - 20 * face_horizontal;
		var _sy = y + attack_projectile_spawn_offset_y + 10;
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
	draw_text(x + 40, y - 80, "aim=" + string(round(aim_angle)) + " sector=" + _sector);
	draw_set_color(c_white);
}
