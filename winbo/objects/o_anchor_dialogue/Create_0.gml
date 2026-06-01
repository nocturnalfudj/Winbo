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
	presence_dialogue_text_offset_x = -245;
	presence_dialogue_text_offset_y_small = -22;
	presence_dialogue_text_offset_y_medium = -46;
	presence_dialogue_text_offset_y_large = -80;
	presence_dialogue_text_width = 430;
	presence_dialogue_text_sep = 48;
	presence_dialogue_anchor_offset_y = -610;
	presence_dialogue_page_text = presence_dialogue_pages[0].text;
	presence_dialogue_page_line_count = presence_dialogue_pages[0].lines;
	presence_dialogue_ready_for_advance = false;

	presence_dialogue_page_start = function() {
		presence_dialogue_phase = PresenceDialoguePhase.demon;
		presence_dialogue_reveal_count = 0;
		presence_dialogue_decode_countdown = 0;
		presence_dialogue_fast_countdown = 0;
		presence_dialogue_page_text = presence_dialogue_pages[presence_dialogue_page_index].text;
		presence_dialogue_page_line_count = presence_dialogue_pages[presence_dialogue_page_index].lines;
		presence_dialogue_ready_for_advance = false;
	};
#endregion

#region State Scripts
	state_script[UIState.destroy][UIStateStage.main] = anchor_dialogue_destroy_main;
#endregion
