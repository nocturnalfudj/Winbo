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
	presence_dialogue_reveal_speed = 25 / SECOND;
	presence_dialogue_reveal_speed_fast = 150 / SECOND;
	presence_dialogue_character_reveal_fade_time = 0.08 * SECOND;
	presence_dialogue_decode_duration = 0.9 * SECOND;
	presence_dialogue_decode_smear_px = 22;
	presence_dialogue_decode_jitter_px = 9;
	presence_dialogue_decode_jitter_y_px = 5;
	presence_dialogue_decode_stagger = 0.45;
	presence_dialogue_decode_scramble_chars = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghkmnopqrstuvwxyz";
	presence_dialogue_box_scale = 1.35;
	presence_dialogue_text_scale_requested = presence_dialogue_pages[0].text_scale;
	presence_dialogue_text_scale = presence_dialogue_text_scale_requested;
	presence_dialogue_text_width_requested = presence_dialogue_pages[0].text_width;
	presence_dialogue_text_width = presence_dialogue_text_width_requested;
	presence_dialogue_text_sep_base = 50;
	presence_dialogue_text_sep_visual_extra = 10;
	presence_dialogue_text_sep = presence_dialogue_text_sep_base
		+ presence_dialogue_text_sep_visual_extra / presence_dialogue_text_scale;
	presence_dialogue_anchor_offset_y = -610;
	presence_dialogue_page_text = presence_dialogue_pages[0].text;
	presence_dialogue_page_expected_lines = presence_dialogue_pages[0].expected_lines;
	presence_dialogue_page_actual_lines = presence_dialogue_page_expected_lines;
	presence_dialogue_page_mode = presence_dialogue_pages[0].mode;
	presence_dialogue_box_sprite = spr_presence_speech_box_large;
	presence_dialogue_text_center_y = 7;
	presence_dialogue_safe_left = -200;
	presence_dialogue_safe_right = 200;
	presence_dialogue_safe_top = -78;
	presence_dialogue_safe_bottom = 92;
	presence_dialogue_layout_bounds_left = 0;
	presence_dialogue_layout_bounds_right = 0;
	presence_dialogue_layout_bounds_top = 0;
	presence_dialogue_layout_bounds_bottom = 0;
	presence_dialogue_layout_valid = true;
	presence_dialogue_page_character_count = 0;
	presence_dialogue_ready_for_advance = false;
	presence_dialogue_text_revealed_count_prev = 0;
	presence_dialogue_sfx_sounds = [
		snd_presence_speech_1,
		snd_presence_speech_2,
		snd_presence_speech_3,
		snd_presence_speech_4,
	];
	presence_dialogue_sfx_chance = 0.5;
	presence_dialogue_sfx_last_sound = noone;
	presence_dialogue_sfx_instance = noone;
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

	presence_dialogue_safe_rect_for_lines = function(_line_count) {
		if(_line_count <= 1) {
			return {
				sprite: spr_presence_speech_box_small,
				left: -200,
				right: 200,
				top: -24,
				bottom: 70,
			};
		}

		if(_line_count == 2) {
			return {
				sprite: spr_presence_speech_box_medium,
				left: -200,
				right: 200,
				top: -42,
				bottom: 76,
			};
		}

		return {
			sprite: spr_presence_speech_box_large,
			left: -200,
			right: 200,
			top: -78,
			bottom: 92,
		};
	};

	presence_dialogue_text_configure = function(_font, _hidden) {
		draw_set_font(_font);
		var _explicit_lines = string_split(presence_dialogue_page_text,chr(10));
		var _explicit_line_count = max(1,array_length(_explicit_lines));
		var _explicit_max_width = 0;
		for(var _line_index=0;_line_index<_explicit_line_count;_line_index++) {
			_explicit_max_width = max(_explicit_max_width,string_width(_explicit_lines[_line_index]));
		}

		var _font_height = string_height("M");
		var _layout_lines = max(1,presence_dialogue_page_expected_lines);
		var _safe;

		repeat(3) {
			_safe = presence_dialogue_safe_rect_for_lines(_layout_lines);
			var _safe_width_rendered = (_safe.right - _safe.left) * presence_dialogue_box_scale * 0.98;
			var _safe_height_rendered = (_safe.bottom - _safe.top) * presence_dialogue_box_scale * 0.98;
			var _height_without_visual_spacing = _font_height
				+ max(0,_layout_lines - 1) * presence_dialogue_text_sep_base;
			var _visual_spacing_height = max(0,_layout_lines - 1) * presence_dialogue_text_sep_visual_extra;
			var _scale_width = (_explicit_max_width > 0)
				? _safe_width_rendered / _explicit_max_width
				: presence_dialogue_text_scale_requested;
			var _scale_height = (_height_without_visual_spacing > 0)
				? max(0.01,_safe_height_rendered - _visual_spacing_height) / _height_without_visual_spacing
				: presence_dialogue_text_scale_requested;

			presence_dialogue_text_scale = min(
				presence_dialogue_text_scale_requested,
				_scale_width,
				_scale_height
			);
			presence_dialogue_text_sep = presence_dialogue_text_sep_base
				+ presence_dialogue_text_sep_visual_extra / presence_dialogue_text_scale;
			presence_dialogue_text_width = min(
				max(presence_dialogue_text_width_requested,_explicit_max_width + 1),
				_safe_width_rendered / presence_dialogue_text_scale
			);

			with(presence_dialogue_text_instance) {
				text_string = other.presence_dialogue_page_text;
				prefix_string = "";
				suffix_string = "";
				font = _font;
				width_max = other.presence_dialogue_text_width;
				alignment_h = fa_center;
				alignment_v = fa_middle;
				sep = other.presence_dialogue_text_sep;
				text_ui_text_strings_update();

				var _positions = text_rich_calculate_character_positions();
				var _positions_count = array_length(_positions);
				var _actual_lines = 1;
				var _has_visible_character = false;
				var _bounds_left = 0;
				var _bounds_right = 0;
				var _bounds_top = 0;
				var _bounds_bottom = 0;
				draw_set_font(_font);
				var _measured_font_height = string_height("M");

				for(var _position_index=0;_position_index<_positions_count;_position_index++) {
					var _position = _positions[_position_index];
					_actual_lines = max(_actual_lines,_position.line + 1);
					if(_position.char == chr(10)) continue;

					var _position_right = _position.x + _position.width;
					var _position_bottom = _position.y + _measured_font_height;
					if(!_has_visible_character) {
						_bounds_left = _position.x;
						_bounds_right = _position_right;
						_bounds_top = _position.y;
						_bounds_bottom = _position_bottom;
						_has_visible_character = true;
					}
					else {
						_bounds_left = min(_bounds_left,_position.x);
						_bounds_right = max(_bounds_right,_position_right);
						_bounds_top = min(_bounds_top,_position.y);
						_bounds_bottom = max(_bounds_bottom,_position_bottom);
					}
				}

				other.presence_dialogue_page_actual_lines = _actual_lines;
				other.presence_dialogue_layout_bounds_left = _bounds_left;
				other.presence_dialogue_layout_bounds_right = _bounds_right;
				other.presence_dialogue_layout_bounds_top = _bounds_top;
				other.presence_dialogue_layout_bounds_bottom = _bounds_bottom;
			}

			_layout_lines = presence_dialogue_page_actual_lines;
		}

		_safe = presence_dialogue_safe_rect_for_lines(presence_dialogue_page_actual_lines);
		presence_dialogue_box_sprite = _safe.sprite;
		presence_dialogue_safe_left = _safe.left;
		presence_dialogue_safe_right = _safe.right;
		presence_dialogue_safe_top = _safe.top;
		presence_dialogue_safe_bottom = _safe.bottom;
		presence_dialogue_text_center_y = (_safe.top + _safe.bottom) * 0.5;

		var _bounds_width_rendered = (presence_dialogue_layout_bounds_right - presence_dialogue_layout_bounds_left)
			* presence_dialogue_text_scale;
		var _bounds_height_rendered = (presence_dialogue_layout_bounds_bottom - presence_dialogue_layout_bounds_top)
			* presence_dialogue_text_scale;
		var _final_safe_width_rendered = (_safe.right - _safe.left) * presence_dialogue_box_scale;
		var _final_safe_height_rendered = (_safe.bottom - _safe.top) * presence_dialogue_box_scale;
		presence_dialogue_layout_valid = _bounds_width_rendered <= _final_safe_width_rendered
			&& _bounds_height_rendered <= _final_safe_height_rendered;

		if(presence_dialogue_page_actual_lines != presence_dialogue_page_expected_lines) {
			sdm(
				"Presence dialogue line mismatch: expected "
				+ string(presence_dialogue_page_expected_lines)
				+ ", measured "
				+ string(presence_dialogue_page_actual_lines)
			);
		}
		if(!presence_dialogue_layout_valid) {
			sdm("Presence dialogue exceeded its measured safe area.");
		}

		with(presence_dialogue_text_instance) {
			text_string = other.presence_dialogue_page_text;
			prefix_string = "";
			suffix_string = "";
			font = _font;
			width_max = other.presence_dialogue_text_width;
			alignment_h = fa_center;
			alignment_v = fa_middle;
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

	presence_dialogue_decode_complete = function() {
		presence_dialogue_phase = PresenceDialoguePhase.direct_english_type;
		presence_dialogue_reveal_count = 0;
		presence_dialogue_reveal_finish_countdown = 0;
		presence_dialogue_fast_countdown = 0;
		presence_dialogue_ready_for_advance = false;
		presence_dialogue_text_configure(fnt_presence_dialogue_43,true);
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
		//Keep the demon layout intact for the glitch; English is configured hidden in decode_complete
		presence_dialogue_phase = PresenceDialoguePhase.decode_glitch;
		presence_dialogue_decode_time = 0;
	};

	presence_dialogue_decode_random = function(_frame, _salt) {
		var _value;
		_value = sin((_frame + 1) * 12.9898 + (_salt + 1) * 78.233) * 43758.5453;
		return _value - floor(_value);
	};

	presence_dialogue_sfx_try_play = function() {
		if(presence_dialogue_sfx_instance != noone) {
			if(audio_is_playing(presence_dialogue_sfx_instance) || audio_is_paused(presence_dialogue_sfx_instance)) {
				return;
			}
			presence_dialogue_sfx_instance = noone;
		}

		if(random(1) >= presence_dialogue_sfx_chance) {
			return;
		}

		var _eligible_sounds;
		_eligible_sounds = [];
		for(var _i=0;_i<array_length(presence_dialogue_sfx_sounds);_i++) {
			var _sound;
			_sound = presence_dialogue_sfx_sounds[_i];
			if(_sound != presence_dialogue_sfx_last_sound) {
				array_push(_eligible_sounds,_sound);
			}
		}

		if(array_length(_eligible_sounds) <= 0) {
			return;
		}

		var _selected_sound;
		_selected_sound = _eligible_sounds[irandom(array_length(_eligible_sounds) - 1)];
		presence_dialogue_sfx_instance = audio_sound_play(_selected_sound,AudioChannel.sfx,false,0,0,true,1,1);
		if(presence_dialogue_sfx_instance != noone) {
			presence_dialogue_sfx_last_sound = _selected_sound;
		}
	};

	presence_dialogue_decode_draw = function(_text_x, _text_y, _alpha) {
		var _progress;
		var _phase_frame;
		var _stagger;
		var _scramble_chars;
		var _scramble_char_count;
		var _text_draw_scale;
		_progress = clamp(presence_dialogue_decode_time / presence_dialogue_decode_duration,0,1);
		_phase_frame = floor(presence_dialogue_decode_time * 0.45);
		_stagger = presence_dialogue_decode_stagger;
		_scramble_chars = presence_dialogue_decode_scramble_chars;
		_scramble_char_count = string_length(_scramble_chars);
		_text_draw_scale = presence_dialogue_text_scale;

		with(presence_dialogue_text_instance) {
			var _font_height;
			draw_set_font(fnt_presence_sans_43);
			_font_height = string_height("M");
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);

			for(var _i=0;_i<rich_character_count;_i++) {
				var _character;
				var _character_text;
				_character = rich_character[_i];
				_character_text = _character.char;
				if(_character_text == chr(10) || _character_text == " ") {
					continue;
				}

				//Stable per-character random staggers each letter onto its own decay schedule
				var _character_random;
				var _character_progress;
				var _demon_alpha;
				_character_random = other.presence_dialogue_decode_random(0,_i * 17);
				_character_progress = clamp(_progress * (1 + _stagger) - _character_random * _stagger,0,1);
				_demon_alpha = 1 - _character_progress;
				if(_demon_alpha <= 0) {
					continue;
				}

				//Frame-varying randoms drive the flicker, scramble, jitter and distortion
				var _flicker_random;
				var _scramble_random;
				var _glyph_random;
				var _jitter_random_x;
				var _jitter_random_y;
				var _spike_random;
				var _angle_random;
				var _scale_random_x;
				var _scale_random_y;
				_flicker_random = other.presence_dialogue_decode_random(_phase_frame,_i * 17 + 1);
				_scramble_random = other.presence_dialogue_decode_random(_phase_frame,_i * 17 + 2);
				_glyph_random = other.presence_dialogue_decode_random(_phase_frame,_i * 17 + 3);
				_jitter_random_x = other.presence_dialogue_decode_random(_phase_frame,_i * 17 + 4);
				_jitter_random_y = other.presence_dialogue_decode_random(_phase_frame,_i * 17 + 5);
				_spike_random = other.presence_dialogue_decode_random(_phase_frame,_i * 17 + 6);
				_angle_random = other.presence_dialogue_decode_random(_phase_frame,_i * 17 + 7);
				_scale_random_x = other.presence_dialogue_decode_random(_phase_frame,_i * 17 + 8);
				_scale_random_y = other.presence_dialogue_decode_random(_phase_frame,_i * 17 + 9);

				//Hard dropout frames read as electrical flicker
				if(_flicker_random < 0.22 * _character_progress) {
					continue;
				}
				_demon_alpha *= 1 - 0.5 * _character_progress * (1 - _flicker_random);

				//Scramble the glyph more aggressively the further the letter has decayed
				if(_scramble_random < _character_progress * 2.2) {
					_character_text = string_char_at(_scramble_chars,1 + floor(_glyph_random * _scramble_char_count));
				}

				var _center_x;
				var _center_y;
				_center_x = _character.x * _text_draw_scale + _text_x + _character.char_width * _text_draw_scale / 2;
				_center_y = _character.y * _text_draw_scale + _text_y + _font_height * _text_draw_scale / 2;

				//Jitter with occasional larger displacement spikes
				var _jitter_x;
				var _jitter_y;
				_jitter_x = (_jitter_random_x - 0.5) * 2 * other.presence_dialogue_decode_jitter_px * _text_draw_scale * _character_progress;
				_jitter_y = (_jitter_random_y - 0.5) * 2 * other.presence_dialogue_decode_jitter_y_px * _text_draw_scale * _character_progress;
				if(_spike_random < 0.12 * _character_progress) {
					_jitter_x *= 3.5;
					_jitter_y *= 2.5;
				}

				var _character_scale_x;
				var _character_scale_y;
				var _character_angle;
				_character_scale_x = _character.image_xscale * _text_draw_scale * (1 + (_scale_random_x - 0.5) * 0.6 * _character_progress);
				_character_scale_y = _character.image_yscale * _text_draw_scale * (1 + (_scale_random_y - 0.5) * 0.8 * _character_progress);
				_character_angle = _character.image_angle + (_angle_random - 0.5) * 24 * _character_progress;

				var _draw_x;
				var _draw_y;
				var _smear_x;
				_draw_x = _center_x + _jitter_x;
				_draw_y = _center_y + _jitter_y;
				_smear_x = other.presence_dialogue_decode_smear_px * _text_draw_scale * _character_progress;

				draw_set_color(_character.image_blend);

				//Smear ghosts either side of the core glyph
				if(_smear_x > 0.5) {
					draw_set_alpha(_alpha * _demon_alpha * 0.3);
					draw_text_transformed(_draw_x - _smear_x,_draw_y,_character_text,_character_scale_x,_character_scale_y,_character_angle);
					draw_text_transformed(_draw_x + _smear_x,_draw_y,_character_text,_character_scale_x,_character_scale_y,_character_angle);
				}

				//Core glyph fades out as the letter decays
				draw_set_alpha(_alpha * _demon_alpha);
				draw_text_transformed(_draw_x,_draw_y,_character_text,_character_scale_x,_character_scale_y,_character_angle);
			}
		}

		draw_set_alpha(1);
		draw_set_color(c_white);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	};

	presence_dialogue_page_start = function() {
		var _page;
		_page = presence_dialogue_pages[presence_dialogue_page_index];
		presence_dialogue_reveal_count = 0;
		presence_dialogue_reveal_finish_countdown = 0;
		presence_dialogue_decode_time = 0;
		presence_dialogue_fast_countdown = 0;
		presence_dialogue_page_text = _page.text;
		presence_dialogue_page_expected_lines = _page.expected_lines;
		presence_dialogue_page_mode = _page.mode;
		presence_dialogue_text_scale_requested = _page.text_scale;
		presence_dialogue_text_width_requested = _page.text_width;
		presence_dialogue_ready_for_advance = false;
		if(presence_dialogue_page_mode == PresenceDialoguePageMode.demon_decode) {
			presence_dialogue_phase = PresenceDialoguePhase.demon_type;
			presence_dialogue_text_configure(fnt_presence_sans_43,true);
		}
		else {
			presence_dialogue_phase = PresenceDialoguePhase.direct_english_type;
			presence_dialogue_text_configure(fnt_presence_dialogue_43,true);
		}
		presence_dialogue_sfx_try_play();
	};

	presence_dialogue_page_start();
#endregion

#region State Scripts
	state_script[UIState.destroy][UIStateStage.main] = anchor_dialogue_destroy_main;
#endregion
