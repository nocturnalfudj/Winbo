// Safety check - ensure sprite_current is valid before any drawing
if(sprite_current == noone || sprite_current < 0){
	// Try to set it to idle sprite
	if(sprite_idle != noone && sprite_idle >= 0){
		sprite_current = sprite_idle;
		sprite_current_frame = 0;
	}
	else{
		// Can't draw anything, just exit
		exit;
	}
}

// Custom drawing for aim, attack, and recover states
var _custom_draw = false;

#region Aim State — Hybrid two-layer / whole-sprite rotation
	if(aim_two_layer_enable && (state == EnemyState.attack_telegraph)){
		_custom_draw = true;

		// Ignore if Not Visible
		if(!camera_visible)
			exit;

		// Determine xscale and draw angle based on face_horizontal
		var _aim_xscale = image_xscale * face_horizontal * sprite_face_direction;
		var _draw_angle;
		if(face_horizontal == 1){
			_draw_angle = aim_angle;
		}
		else{
			_draw_angle = aim_angle + 180;
		}

		if(sprite_current == spr_space_ranger_attack){
			// Aim-in uses the first frames of the full attack sequence.
			// Draw the current frame rotated toward aim_angle (with face flip applied).
			draw_sprite_ext(
				sprite_current, sprite_current_frame,
				x, y,
				_aim_xscale, image_yscale,
				_draw_angle,
				image_blend, image_alpha
			);
		}
		else{
			// Calculate how far the aim deviates from horizontal
			var _horizontal_angle = (face_horizontal == 1) ? 0 : 180;
			var _deviation = abs(angle_difference(aim_angle, _horizontal_angle));

			if(_deviation <= aim_split_threshold){
				// Within threshold: two-layer draw (body rotates, legs static)
				if(sprite_aim_legs != noone){
					draw_sprite_ext(
						sprite_aim_legs, 0,
						x + aim_legs_sprite_offset_x, y + aim_legs_sprite_offset_y,
						_aim_xscale, image_yscale,
						0,
						image_blend, image_alpha
					);
				}
				if(sprite_aim_body != noone){
					draw_sprite_ext(
						sprite_aim_body, sprite_current_frame,
						x + aim_body_sprite_offset_x, y + aim_body_sprite_offset_y,
						_aim_xscale, image_yscale,
						_draw_angle,
						image_blend, image_alpha
					);
				}
			}
			else{
				// Beyond threshold: rotate entire sprite (both layers) to hide the split
				if(sprite_aim_legs != noone){
					draw_sprite_ext(
						sprite_aim_legs, 0,
						x + aim_legs_sprite_offset_x, y + aim_legs_sprite_offset_y,
						_aim_xscale, image_yscale,
						_draw_angle,
						image_blend, image_alpha
					);
				}
				if(sprite_aim_body != noone){
					draw_sprite_ext(
						sprite_aim_body, sprite_current_frame,
						x + aim_body_sprite_offset_x, y + aim_body_sprite_offset_y,
						_aim_xscale, image_yscale,
						_draw_angle,
						image_blend, image_alpha
					);
				}
			}
		}

		// Flash effect
		if(flash_alpha > 0 && sprite_current != noone && sprite_current >= 0){
			shader_set(sh_monochrome);
			draw_sprite_ext(sprite_current, sprite_current_frame, x, y, _aim_xscale, image_yscale, _draw_angle, flash_colour, flash_alpha);
			shader_reset();
		}

		// Info Bar
		info_bar_system_draw();

		// Dev Mode debug
		if(o_master.dev_mode){
			draw_bounding_box();

			// Draw aim line
			draw_set_color(c_red);
			draw_line(x, y, x + lengthdir_x(100, aim_angle), y + lengthdir_y(100, aim_angle));
			draw_set_color(c_white);
		}
	}
#endregion

#region Attack — Rotated draw at locked aim angle, easing back during recovery frames
	if(!_custom_draw && attack_rotation_active && state == EnemyState.attack_active){
		_custom_draw = true;

		// Ignore if Not Visible
		if(!camera_visible)
			exit;

		var _atk_xscale = image_xscale * face_horizontal * sprite_face_direction;

		// Draw current sprite rotated to the locked attack angle, easing back to 0 over the configured recovery frames.
		var _draw_angle = attack_locked_draw_angle;
		var _start = attack_recovery_rotate_start_frame;
		var _end = attack_recovery_rotate_end_frame;
		if(image != noone){
			_end = min(_end, image.sprite_number - 1);
		}
		if(sprite_current_frame >= _start){
			var _range = max(1, _end - _start);
			var t = clamp((sprite_current_frame - _start) / _range, 0, 1);
			t = ease_quad_out(0, 1, false, t, 1);
			var _diff = angle_difference(0, attack_locked_draw_angle);
			_draw_angle = attack_locked_draw_angle + _diff * t;
		}

		// Draw sprite at computed angle
		if(sprite_current != noone && sprite_current >= 0){
			draw_sprite_ext(
				sprite_current, sprite_current_frame,
				x, y,
				_atk_xscale, image_yscale,
				_draw_angle,
				image_blend, image_alpha
			);
		}

		// Flash effect
		if(flash_alpha > 0 && sprite_current != noone && sprite_current >= 0){
			shader_set(sh_monochrome);
			draw_sprite_ext(sprite_current, sprite_current_frame, x, y, _atk_xscale, image_yscale, _draw_angle, flash_colour, flash_alpha);
			shader_reset();
		}

		// Info Bar
		info_bar_system_draw();

		// Dev Mode debug
		if(o_master.dev_mode){
			draw_bounding_box();
		}
	}
#endregion

if(!_custom_draw){
	// Normal drawing - use parent
	event_inherited();
}

// Space Ranger specific debug info (always draw in dev mode)
if(o_master.dev_mode){
	var _debug_x = x + 60;
	var _debug_y = y - 80;
	
	draw_set_font(fnt_default_16);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_yellow);
	
	// State info
	var _state_name = "unknown";
	switch(state){
		case EnemyState.create: _state_name = "create"; break;
		case EnemyState.idle: _state_name = "idle"; break;
		case EnemyState.move: _state_name = "move"; break;
		case EnemyState.startled: _state_name = "startled"; break;
		case EnemyState.attack_telegraph: _state_name = "telegraph"; break;
		case EnemyState.attack_active: _state_name = "attack"; break;
		case EnemyState.attack_recover: _state_name = "recover"; break;
		case EnemyState.death: _state_name = "death"; break;
		case EnemyState.destroy: _state_name = "destroy"; break;
	}
	
	draw_text(_debug_x, _debug_y, "STATE: " + _state_name);
	_debug_y += 16;
	
	draw_text(_debug_x, _debug_y, "hostile: " + string(is_hostile));
	_debug_y += 16;
	
	draw_text(_debug_x, _debug_y, "atk_cd: " + string(round(attack_countdown)));
	_debug_y += 16;
	
	draw_text(_debug_x, _debug_y, "spr_cur: " + string(sprite_current));
	_debug_y += 16;
	
	// Target distance
	if(variable_instance_exists(id, "target") && target[TargetType.attack] != noone && instance_exists(target[TargetType.attack].object)){
		var _dist = point_distance(x, y, target[TargetType.attack].x, target[TargetType.attack].y);
		draw_text(_debug_x, _debug_y, "tgt_dist: " + string(round(_dist)));
		_debug_y += 16;
		
		var _trigger = target[TargetType.attack].distance_trigger;
		draw_text(_debug_x, _debug_y, "trigger: " + string(_trigger));
		_debug_y += 16;
		
		var _in_range = target[TargetType.attack].is_within_trigger_distance();
		draw_set_color(_in_range ? c_lime : c_red);
		draw_text(_debug_x, _debug_y, "in_range: " + string(_in_range));
	}
	else{
		draw_set_color(c_red);
		draw_text(_debug_x, _debug_y, "NO TARGET");
	}
	
	draw_set_color(c_white);
}
