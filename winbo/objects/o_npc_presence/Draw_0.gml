if(!presence_visual_enable){
	event_inherited();
	exit;
}

if(!camera_visible){
	exit;
}

if(presence_visual_state == PresenceVisualState.hidden){
	exit;
}

var _character_x,_character_y;
_character_x = x + draw_adjustment_x;
_character_y = y + draw_adjustment_y;

var _scale_x,_scale_y;
_scale_x = image_xscale * move_effects_scale.x;
_scale_y = image_yscale * move_effects_scale.y;

var _alpha;
_alpha = image_alpha;
if(status_effect_active_count[StatusEffect.invincible] > 0){
	_alpha = image_alpha * lerp(0.5,1,global.wave_sine_0_scaled);
}

var _body_frame;
var _head_sprite,_head_frame;
var _eyes_sprite,_eyes_frame;
var _eyes_x,_eyes_y;
_body_frame = floor(presence_visual_body_idle_frame);
_head_sprite = spr_npc_presence_head_front;
_head_frame = floor(presence_visual_head_idle_frame);
_eyes_sprite = presence_visual_eye_sprite;
_eyes_frame = floor(presence_visual_eyes_idle_frame);
_eyes_x = _character_x + (presence_visual_eye_offset_x * _scale_x);
_eyes_y = _character_y + (presence_visual_eye_offset_y * _scale_y);

switch(presence_visual_state){
	case PresenceVisualState.intro:
		var _intro_frame;
		var _intro_eye_frame;
		_intro_frame = clamp(floor(presence_visual_intro_frame),0,presence_visual_body_intro_end);
		_intro_eye_frame = round((max(0,presence_visual_intro_frame) / max(1,presence_visual_body_intro_end)) * presence_visual_front_eyes_intro_end);
		_body_frame = _intro_frame;
		_head_sprite = spr_npc_presence_head_intro;
		_head_frame = round((max(0,presence_visual_intro_frame) / max(1,presence_visual_body_intro_end)) * presence_visual_head_intro_end);
		_eyes_sprite = spr_npc_presence_eyes_front;
		_head_frame = clamp(_head_frame,0,presence_visual_head_intro_end);
		_eyes_frame = clamp(_intro_eye_frame,0,presence_visual_front_eyes_intro_end);
	break;

	case PresenceVisualState.idle:
		_body_frame = clamp(floor(presence_visual_body_idle_frame),presence_visual_body_idle_start,presence_visual_body_idle_end);

		switch(presence_visual_head_direction){
			case PresenceHeadDirection.left:
				_head_sprite = spr_npc_presence_head_left;
			break;

			case PresenceHeadDirection.right:
				_head_sprite = spr_npc_presence_head_right;
			break;

			default:
				_head_sprite = spr_npc_presence_head_front;
			break;
		}

		var _head_idle_end;
		switch(presence_visual_head_direction){
			case PresenceHeadDirection.left:
				_head_idle_end = presence_visual_head_left_idle_end;
			break;

			case PresenceHeadDirection.right:
				_head_idle_end = presence_visual_head_right_idle_end;
			break;

			default:
				_head_idle_end = presence_visual_head_front_idle_end;
			break;
		}

		_head_frame = clamp(floor(presence_visual_head_idle_frame),0,_head_idle_end);

		if(_eyes_sprite == spr_npc_presence_eyes_front){
			_eyes_frame = clamp(floor(presence_visual_eyes_idle_frame),presence_visual_front_eyes_idle_start,presence_visual_front_eyes_idle_end);
		}
		else{
			_eyes_frame = clamp(floor(presence_visual_eyes_idle_frame),0,9);
		}
	break;

	case PresenceVisualState.outro:
		var _outro_frame;
		var _outro_eye_frame;
		_outro_frame = clamp(floor(presence_visual_intro_frame),0,presence_visual_body_intro_end);
		_outro_eye_frame = round((max(0,presence_visual_intro_frame) / max(1,presence_visual_body_intro_end)) * presence_visual_front_eyes_intro_end);
		_body_frame = _outro_frame;
		_head_sprite = spr_npc_presence_head_intro;
		_head_frame = round((max(0,presence_visual_intro_frame) / max(1,presence_visual_body_intro_end)) * presence_visual_head_intro_end);
		_eyes_sprite = spr_npc_presence_eyes_front;
		_head_frame = clamp(_head_frame,0,presence_visual_head_intro_end);
		_eyes_frame = clamp(_outro_eye_frame,0,presence_visual_front_eyes_intro_end);
	break;
}

if(spr_npc_presence_body != noone){
	draw_sprite_ext(spr_npc_presence_body,_body_frame,_character_x,_character_y,_scale_x,_scale_y,image_angle + acceleration_sway,image_blend,_alpha);
}

if(_head_sprite != noone){
	draw_sprite_ext(_head_sprite,_head_frame,_character_x,_character_y,_scale_x,_scale_y,image_angle + acceleration_sway,image_blend,_alpha);
}

if(_eyes_sprite != noone){
	draw_sprite_ext(_eyes_sprite,_eyes_frame,_eyes_x,_eyes_y,_scale_x,_scale_y,image_angle + acceleration_sway,image_blend,_alpha);
}

if(flash_alpha > 0){
	shader_set(sh_monochrome);
	if(spr_npc_presence_body != noone){
		draw_sprite_ext(spr_npc_presence_body,_body_frame,_character_x,_character_y,_scale_x,_scale_y,image_angle + acceleration_sway,flash_colour,flash_alpha);
	}

	if(_head_sprite != noone){
		draw_sprite_ext(_head_sprite,_head_frame,_character_x,_character_y,_scale_x,_scale_y,image_angle + acceleration_sway,flash_colour,flash_alpha);
	}

	if(_eyes_sprite != noone){
		draw_sprite_ext(_eyes_sprite,_eyes_frame,_eyes_x,_eyes_y,_scale_x,_scale_y,image_angle + acceleration_sway,flash_colour,flash_alpha);
	}
	shader_reset();
}

info_bar_system_draw();

if(o_master.dev_mode){
	draw_bounding_box(true);
}
