// Inherit the parent event
event_inherited();

//UI Group
ui_group_set(UIGroup.dialogue,id);

#region Transform
	var _transform;
	_transform = transform[TransformType.anchor];
	
	//Set Coords to 0,0
	transform_set(_transform,TransformValue.x,0,false);
	transform_set(_transform,TransformValue.y,0,false);
	transform_set_rest(_transform,TransformValue.x,0,false);
	transform_set_rest(_transform,TransformValue.y,0,false);
	
	//Appear
	var _time_current,_time_max,_curve,_target;
	_time_current = -0.2*SECOND;
	_time_max = 0.6*SECOND;
	_curve = ease_back_out;
	_target = 1;
	transform_animate(_transform,TransformValue.alpha,0,_target,_time_current,_time_max,_curve);
	transform_animate(_transform,TransformValue.xscale,0,_target,_time_current,_time_max,_curve);
	transform_animate(_transform,TransformValue.yscale,0,_target,_time_current,_time_max,_curve);
	
	//Transform Update
	transform_system_update();
#endregion

#region Presence Dialogue
	enum PresenceDialoguePhase {
		demon_type,
		decode_glitch,
		direct_english_type,
		complete
	}

	presence_dialogue_pages = presence_dialogue_pages_create(presence_dialogue_stage_get());
	presence_dialogue_page_index = 0;
	presence_dialogue_phase = PresenceDialoguePhase.demon_type;
	presence_dialogue_reveal_count = 0;
	presence_dialogue_reveal_finish_countdown = 0;
	presence_dialogue_decode_time = 0;
	presence_dialogue_fast_countdown = 0;
	presence_dialogue_frame = 0;
	presence_dialogue_frame_speed = 15 / SECOND;
	presence_dialogue_reveal_speed = 40 / SECOND;
	presence_dialogue_reveal_speed_fast = 150 / SECOND;
	presence_dialogue_character_reveal_fade_time = 0.08 * SECOND;
	presence_dialogue_decode_duration = 0.5 * SECOND;
	presence_dialogue_decode_smear_px = 18;
	presence_dialogue_decode_jitter_px = 6;
	presence_dialogue_box_scale = 1;
	presence_dialogue_text_scale = 1;
	presence_dialogue_text_offset_x = -220;
	presence_dialogue_text_offset_y_small = -22;
	presence_dialogue_text_offset_y_medium = -50;
	presence_dialogue_text_offset_y_large = -88;
	presence_dialogue_text_width = 370;
	presence_dialogue_text_sep = 40;
	presence_dialogue_anchor_offset_y = -610;
	presence_dialogue_page_text = presence_dialogue_pages[0].text;
	presence_dialogue_page_line_count = presence_dialogue_pages[0].lines;
	presence_dialogue_page_mode = presence_dialogue_pages[0].mode;
	presence_dialogue_page_character_count = 0;
	presence_dialogue_ready_for_advance = false;
	presence_dialogue_text_revealed_count_prev = 0;
	presence_dialogue_text_instance = instance_create_layer(0,0,"lyr_hud",o_text_rich);

	with(presence_dialogue_text_instance) {
		visible = false;
		gui = false;
		state = UIState.idle;
		ui_group_set(UIGroup.dialogue,id);
		width_max = other.presence_dialogue_text_width;
		width_buff = 0;
		height_buff = 0;
		alignment_h = fa_left;
		alignment_v = fa_top;
		image_blend = c_white;
		image_alpha = 1;
		reveal_enable = false;
		shadow_enable = false;
		rich_text_force_character_draw = true;
	}

	presence_dialogue_text_set_character_alpha = function(_character, _alpha) {
		with(_character) {
			image_alpha = _alpha;
			transform_set(transform[TransformType.anchor],TransformValue.alpha,_alpha,false);
			transform_force_update_all = true;
			transform_system_update();
		}
	};

	presence_dialogue_text_configure = function(_font, _hidden) {
		with(presence_dialogue_text_instance) {
			text_string = other.presence_dialogue_page_text;
			prefix_string = "";
			suffix_string = "";
			font = _font;
			width_max = other.presence_dialogue_text_width;
			alignment_h = fa_left;
			alignment_v = fa_top;
			sep = other.presence_dialogue_text_sep;
			text_ui_text_strings_update();
			text_ui_set_width_height_pre_scale();
			text_poster_dimensions();
			rich_character_rebuild_required = true;
			rich_word_rebuild_required = true;
			text_rich_rebuild_characters();
			text_rich_stop_animations();
			text_rich_reset_transforms();
			rich_text_force_character_draw = true;

			for(var _i=0;_i<rich_character_count;_i++) {
				other.presence_dialogue_text_set_character_alpha(rich_character[_i],_hidden ? 0 : 1);
			}

			rich_text_is_animating = _hidden;
			rich_text_is_visible = !_hidden && rich_character_count > 0;
			text_ui_text_strings_prev_update();
		}

		presence_dialogue_page_character_count = presence_dialogue_text_instance.rich_character_count;
		presence_dialogue_text_revealed_count_prev = 0;
	};

	presence_dialogue_text_apply_reveal = function() {
		var _visible_count;
		_visible_count = clamp(
			floor(presence_dialogue_reveal_count),
			0,
			presence_dialogue_page_character_count
		);

		if(_visible_count != presence_dialogue_text_revealed_count_prev) {
			with(presence_dialogue_text_instance) {
				if(_visible_count > other.presence_dialogue_text_revealed_count_prev) {
					var _start_index;
					var _end_index;
					_start_index = other.presence_dialogue_text_revealed_count_prev;
					_end_index = _visible_count - 1;
					text_rich_animate_characters(
						TransformValue.alpha,
						0,
						1,
						other.presence_dialogue_character_reveal_fade_time,
						ease_linear,
						0,
						0,
						_start_index,
						_end_index
					);
				}
				else {
					for(var _i=0;_i<rich_character_count;_i++) {
						other.presence_dialogue_text_set_character_alpha(rich_character[_i],(_i < _visible_count) ? 1 : 0);
					}
				}
				rich_text_force_character_draw = true;
				rich_text_is_animating = _visible_count < rich_character_count;
				rich_text_is_visible = _visible_count > 0;
			}

			presence_dialogue_text_revealed_count_prev = _visible_count;
		}
	};

	presence_dialogue_text_complete = function() {
		presence_dialogue_reveal_count = presence_dialogue_page_character_count;
		presence_dialogue_text_apply_reveal();
		presence_dialogue_phase = PresenceDialoguePhase.complete;
		presence_dialogue_ready_for_advance = true;
	};

	presence_dialogue_reveal_finish = function() {
		if(presence_dialogue_phase == PresenceDialoguePhase.demon_type) {
			presence_dialogue_decode_start();
		}
		else {
			presence_dialogue_text_complete();
		}
	};

	presence_dialogue_decode_start = function() {
		presence_dialogue_phase = PresenceDialoguePhase.decode_glitch;
		presence_dialogue_decode_time = 0;
		presence_dialogue_text_configure(fnt_presence_dialogue_43,true);
	};

	presence_dialogue_decode_draw = function(_text_x, _text_y, _alpha) {
		var _progress;
		var _noise;
		var _phase_frame;
		_progress = clamp(presence_dialogue_decode_time / presence_dialogue_decode_duration,0,1);
		_noise = 1 - _progress;
		_phase_frame = floor(presence_dialogue_decode_time * 0.45);

		with(presence_dialogue_text_instance) {
			var _font_height;
			draw_set_font(fnt_presence_dialogue_43);
			_font_height = string_height("M");
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);

			for(var _i=0;_i<rich_character_count;_i++) {
				var _character;
				var _character_text;
				_character = rich_character[_i];
				_character_text = _character.char;
				if(_character_text != chr(10)) {
					var _character_x;
					var _character_y;
					var _character_width;
					var _center_x;
					var _center_y;
					var _character_scale_x;
					var _character_scale_y;
					var _character_angle;
					var _random_value;
					var _jitter_x;
					var _smear_x;
					var _demon_alpha;
					var _english_alpha;
					_character_x = _character.x + _text_x;
					_character_y = _character.y + _text_y;
					_character_width = _character.char_width;
					_center_x = _character_x + _character_width / 2;
					_center_y = _character_y + _font_height / 2;
					_character_scale_x = _character.image_xscale;
					_character_scale_y = _character.image_yscale;
					_character_angle = _character.image_angle;
					_random_value = sin((_phase_frame + 1) * 12.9898 + (_i + 1) * 78.233) * 43758.5453;
					_random_value -= floor(_random_value);
					_jitter_x = (_random_value - 0.5) * other.presence_dialogue_decode_jitter_px * _noise;
					_smear_x = other.presence_dialogue_decode_smear_px * _noise;
					_demon_alpha = clamp((0.85 - _progress) / 0.85,0,1);
					_english_alpha = clamp((_progress - 0.15) / 0.85,0,1);

					if(_demon_alpha > 0) {
						draw_set_font(fnt_presence_sans_43);
						draw_set_color(_character.image_blend);
						for(var _pass=0;_pass<3;_pass++) {
							var _pass_offset;
							_pass_offset = (_pass - 1) * _smear_x + _jitter_x;
							draw_set_alpha(_alpha * _demon_alpha * (0.16 + 0.12 * _random_value));
							draw_text_transformed(
								_center_x + _pass_offset,
								_center_y,
								_character_text,
								_character_scale_x,
								_character_scale_y,
								_character_angle
							);
						}
					}

					if(_english_alpha > 0) {
						draw_set_font(fnt_presence_dialogue_43);
						draw_set_color(_character.image_blend);
						for(var _pass=0;_pass<2;_pass++) {
							var _pass_offset;
							_pass_offset = (_pass - 0.5) * _smear_x * 0.4 - _jitter_x * 0.5;
							draw_set_alpha(_alpha * _english_alpha * (0.35 + 0.2 * _progress));
							draw_text_transformed(
								_center_x + _pass_offset,
								_center_y,
								_character_text,
								_character_scale_x,
								_character_scale_y,
								_character_angle
							);
						}
					}
				}
			}
		}

		draw_set_alpha(1);
		draw_set_color(c_white);
	};

	presence_dialogue_page_start = function() {
		presence_dialogue_reveal_count = 0;
		presence_dialogue_reveal_finish_countdown = 0;
		presence_dialogue_decode_time = 0;
		presence_dialogue_fast_countdown = 0;
		presence_dialogue_page_text = presence_dialogue_pages[presence_dialogue_page_index].text;
		presence_dialogue_page_line_count = presence_dialogue_pages[presence_dialogue_page_index].lines;
		presence_dialogue_page_mode = presence_dialogue_pages[presence_dialogue_page_index].mode;
		presence_dialogue_ready_for_advance = false;
		if(presence_dialogue_page_mode == PresenceDialoguePageMode.demon_decode) {
			presence_dialogue_phase = PresenceDialoguePhase.demon_type;
			presence_dialogue_text_configure(fnt_presence_sans_43,true);
		}
		else {
			presence_dialogue_phase = PresenceDialoguePhase.direct_english_type;
			presence_dialogue_text_configure(fnt_presence_dialogue_43,true);
		}
	};

	presence_dialogue_page_start();
#endregion

#region State Scripts
	state_script[UIState.destroy][UIStateStage.main] = anchor_dialogue_destroy_main;
#endregion
