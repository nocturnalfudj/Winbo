//Ignore if Not Visible
if(!camera_visible)
	exit;
	
var _character_x,_character_y;
_character_x = x + draw_adjustment_x;
_character_y = y + draw_adjustment_y;
	
//Move Effect Values
var _move_effect_x,_move_effect_y;
_move_effect_x = move_effects_scale.x;
_move_effect_y = move_effects_scale.y;
	
//Scale Variables
var _scale_x,_scale_y;
_scale_x = image_xscale * _move_effect_x;
_scale_y = image_yscale * _move_effect_y;

#region Dash
	if((dash_icon_enable) && (dash_icon_scale > 0)){
		var _dash_scale_x,_dash_scale_y,_dash_alpha;
		_dash_scale_x = _scale_x * dash_icon_scale;
		_dash_scale_y = _scale_y * dash_icon_scale;
		_dash_alpha = min(1,image_alpha * dash_icon_scale);
		
		var _x,_y;
		_x = _character_x + dash_icon_x*_dash_scale_x;
		_y = _character_y + dash_icon_y*_dash_scale_y;
		
	
		var _dash_fill_percent,_dash_sprite_width,_dash_sprite_height,_dash_sprite_draw_top,_dash_sprite_draw_height;
		_dash_fill_percent = dash_stamina / dash_stamina_max;
		_dash_sprite_width = dash_icon_width;
		_dash_sprite_height = dash_icon_height;
		_dash_sprite_draw_top = _dash_sprite_height * (1 - _dash_fill_percent);
		_dash_sprite_draw_height = _dash_sprite_height -_dash_sprite_draw_top;
		
		
		draw_sprite_ext(spr_character_dash_background,0,_x,_y,_dash_scale_x,_dash_scale_y,image_angle + acceleration_sway,image_blend,_dash_alpha);
		draw_sprite_general(spr_character_dash_fill,0,0,_dash_sprite_draw_top,_dash_sprite_width,_dash_sprite_draw_height,_x,_y + _dash_sprite_draw_top*_dash_scale_y,_dash_scale_x,_dash_scale_y,image_angle + acceleration_sway,image_blend,image_blend,image_blend,image_blend,_dash_alpha);
		draw_sprite_ext(spr_character_dash_frame,0,_x,_y,_dash_scale_x,_dash_scale_y,image_angle + acceleration_sway,image_blend,_dash_alpha);
		
		if(dash_icon_flash_alpha > 0){
			shader_set(sh_monochrome);
			draw_sprite_ext(spr_character_dash_background,0,_x,_y,_dash_scale_x,_dash_scale_y,image_angle + acceleration_sway,dash_icon_flash_colour,_dash_alpha*dash_icon_flash_alpha);
			draw_sprite_general(spr_character_dash_fill,0,0,_dash_sprite_draw_top,_dash_sprite_width,_dash_sprite_draw_height,_x,_y + _dash_sprite_draw_top*_dash_scale_y,_dash_scale_x,_dash_scale_y,image_angle + acceleration_sway,dash_icon_flash_colour,dash_icon_flash_colour,dash_icon_flash_colour,dash_icon_flash_colour,_dash_alpha*dash_icon_flash_alpha);
			draw_sprite_ext(spr_character_dash_frame,0,_x,_y,_dash_scale_x,_dash_scale_y,image_angle + acceleration_sway,dash_icon_flash_colour,_dash_alpha*dash_icon_flash_alpha);
			shader_reset();
		}
	}
#endregion

#region Body
	var _scale_x_face_adjusted,_scale_y_face_adjusted;
	if(face_horizontal_draw_enable)
		_scale_x_face_adjusted = _scale_x * face_horizontal * sprite_face_direction;
	else
		_scale_x_face_adjusted = _scale_x;
		
	if(face_vertical_draw_enable)
		_scale_y_face_adjusted = _scale_y * face_vertical;
	else
		_scale_y_face_adjusted = _scale_y;
		
	var _alpha;
	_alpha = image_alpha;
	//Invincible
	if(status_effect_active_count[StatusEffect.invincible] > 0){
		_alpha = image_alpha * lerp(0.5,1,global.wave_sine_0_scaled);
	}
	
	//Draw Body
	draw_sprite_ext(sprite_current,sprite_current_frame,_character_x,_character_y,_scale_x_face_adjusted,_scale_y_face_adjusted,image_angle + acceleration_sway,image_blend,_alpha);
	
	#region Flash
		if(flash_alpha > 0){
			shader_set(sh_monochrome);
			draw_sprite_ext(sprite_current,sprite_current_frame,_character_x,_character_y,_scale_x_face_adjusted,_scale_y_face_adjusted,image_angle + acceleration_sway,flash_colour,flash_alpha);
			shader_reset();
		}
	#endregion
#endregion

//Info Bar
info_bar_system_draw();

#region Dev Path Draw
	//if(o_master.dev_mode){
	//	draw_set_colour(c_red);
	//	draw_path(path_finding_path,x,y,false);
			
	//	var _x1,_x2,_y1,_y2;
	//	_x1 = x + lengthdir_x(300,input_move_direction);
	//	_y1 = y + lengthdir_y(300,input_move_direction);
	//	draw_line(x,y,_x1,_y1);
	//}
#endregion
	
#region Dev Mode
	#region Movement Stats
		//var _x,_y,_string;
		//_x = x + 100;
		//_y = y - 100;
			
		//_string = "velocity: " + string(velocity);
		//draw_text(_x,_y,_string);
			
		//_y += 50;
		//_string = "acceleration: " + string(acceleration);
		//draw_text(_x,_y,_string);
			
		//_y += 50;
		//_string = "velocity_retention: " + string(velocity_retention);
		//draw_text(_x,_y,_string);
			
		//_y += 50;
		//_string = "velocity_mag: " + string(velocity_mag);
		//draw_text(_x,_y,_string);
			
		//_y += 50;
		//_string = "velocity_dir: " + string(velocity_dir);
		//draw_text(_x,_y,_string);
			
		//_y += 50;
		//_string = "velocity_terminal: " + string(velocity_terminal);
		//draw_text(_x,_y,_string);
	#endregion
	
	if(o_master.dev_mode){
		draw_bounding_box(true);
		
		var _x,_y,_string;
		_x = x + 100;
		_y = y - 100;
		
		_y += 50;
		_string = "state: " + string(state);
		draw_text(_x,_y,_string);
		
		var _radius,_colour;
		//if(collision_attack_enable){
		//	draw_set_alpha(0.1);
		//	_radius = collision_attack_range;
		//	_colour = c_ags_red;
		//	draw_circle_color(x,y,_radius,_colour,_colour,false);
			
		//	_radius = collision_attack_range * (1 - (collision_attack_cooldown / collision_attack_cooldown_max));
		//	_colour = c_ags_red;
		//	draw_circle_color(x,y,_radius,_colour,_colour,false);
			
		//	draw_set_alpha(1);
		//}
		
		_radius = target[TargetType.move].distance_trigger;
		_colour = c_blue;
		draw_circle_color(x,y,_radius,_colour,_colour,true);
		
		_radius = target[TargetType.attack].distance_trigger;
		_colour = c_red;
		draw_circle_color(x,y,_radius,_colour,_colour,true);
	}
#endregion