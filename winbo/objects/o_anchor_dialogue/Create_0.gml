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
		demon,
		decode_wait,
		english,
		complete
	}

	presence_dialogue_pages = presence_dialogue_pages_create(presence_dialogue_stage_get());
	presence_dialogue_page_index = 0;
	presence_dialogue_phase = PresenceDialoguePhase.demon;
	presence_dialogue_reveal_count = 0;
	presence_dialogue_decode_countdown = 0;
	presence_dialogue_fast_countdown = 0;
	presence_dialogue_frame = 0;
	presence_dialogue_frame_speed = 15 / SECOND;
	presence_dialogue_reveal_speed = 40 / SECOND;
	presence_dialogue_reveal_speed_fast = 150 / SECOND;
	presence_dialogue_decode_wait_time = 0.35 * SECOND;
	presence_dialogue_box_scale = 1;
	presence_dialogue_text_scale = 1;
	presence_dialogue_text_offset_x = -220;
	presence_dialogue_text_offset_y_small = -22;
	presence_dialogue_text_offset_y_medium = -50;
	presence_dialogue_text_offset_y_large = -88;
	presence_dialogue_text_width = 370;
	presence_dialogue_text_sep = 40;
	presence_dialogue_anchor_offset_y = -610;
	presence_dialogue_character_reveal_offset_y = 8;
	presence_dialogue_character_reveal_fade_time = 0.12 * SECOND;
	presence_dialogue_character_reveal_slide_time = 0.16 * SECOND;
	presence_dialogue_page_text = presence_dialogue_pages[0].text;
	presence_dialogue_page_line_count = presence_dialogue_pages[0].lines;
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
	}

	presence_dialogue_text_start = function() {
		var _font;
		_font = fnt_presence_dialogue_43;
		if((presence_dialogue_phase == PresenceDialoguePhase.demon) || (presence_dialogue_phase == PresenceDialoguePhase.decode_wait)) {
			_font = fnt_presence_sans_43;
		}

		var _character_offset_y;
		_character_offset_y = presence_dialogue_character_reveal_offset_y;

		with(presence_dialogue_text_instance) {
			text_string = other.presence_dialogue_page_text;
			prefix_string = "";
			suffix_string = "";
			font = _font;
			width_max = other.presence_dialogue_text_width;
			alignment_h = fa_left;
			alignment_v = fa_top;
			text_ui_text_strings_update();
			text_ui_set_width_height_pre_scale();
			sep = other.presence_dialogue_text_sep;
			text_poster_dimensions();
			rich_character_rebuild_required = true;
			rich_word_rebuild_required = true;
			text_rich_rebuild_characters();
			text_rich_stop_animations();
			text_rich_reset_transforms();

			for(var _i=0;_i<rich_character_count;_i++) {
				var _character;
				_character = rich_character[_i];
				with(_character) {
					var _rest_y;
					_rest_y = transform[TransformType.anchor].value[TransformValue.y].rest;
					transform_set(transform[TransformType.anchor],TransformValue.alpha,0,false);
					transform_set(transform[TransformType.anchor],TransformValue.y,_rest_y + _character_offset_y,false);
					transform_force_update_all = true;
					transform_system_update();
				}
			}

			rich_text_is_animating = false;
			rich_text_is_visible = false;
			text_ui_text_strings_prev_update();
		}

		presence_dialogue_text_revealed_count_prev = 0;
	};

	presence_dialogue_text_apply_reveal = function() {
		var _visible_count;
		_visible_count = clamp(
			floor(presence_dialogue_reveal_count),
			0,
			string_length(presence_dialogue_page_text)
		);

		if(_visible_count > presence_dialogue_text_revealed_count_prev) {
			var _start_index;
			var _end_index;
			_start_index = presence_dialogue_text_revealed_count_prev;
			_end_index = _visible_count - 1;

			with(presence_dialogue_text_instance) {
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
				text_rich_animate_characters(
					TransformValue.y,
					other.presence_dialogue_character_reveal_offset_y,
					0,
					other.presence_dialogue_character_reveal_slide_time,
					ease_quad_out,
					0,
					0,
					_start_index,
					_end_index,
					true
				);
			}

			presence_dialogue_text_revealed_count_prev = _visible_count;
		}
	};

	presence_dialogue_page_start = function() {
		presence_dialogue_phase = PresenceDialoguePhase.demon;
		presence_dialogue_reveal_count = 0;
		presence_dialogue_decode_countdown = 0;
		presence_dialogue_fast_countdown = 0;
		presence_dialogue_page_text = presence_dialogue_pages[presence_dialogue_page_index].text;
		presence_dialogue_page_line_count = presence_dialogue_pages[presence_dialogue_page_index].lines;
		presence_dialogue_ready_for_advance = false;
		presence_dialogue_text_start();
	};

	presence_dialogue_page_start();
#endregion

#region State Scripts
	state_script[UIState.destroy][UIStateStage.main] = anchor_dialogue_destroy_main;
#endregion
