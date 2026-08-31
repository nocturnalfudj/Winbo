// Inherit the parent event
event_inherited();

#region Movement
	movement_velocity_retention_and_acceleration_max_set(0.7,1000);
	movement_input_move_acceleration_default_set(0);
#endregion

#region Interact System Setup
	//Interaction Scripts
	interact_active_script[NPCInteraction.dialogue] = npc_presence_interact_state_active_main;
#endregion

#region Lighting
	tracking_light = lighting_light_create_track(spr_light_circular,c_white,"lyr_lighting",3,3,0,0,0,1);
#endregion

#region Presence Visuals
	enum PresenceVisualState{
		hidden,
		intro,
		idle,
		outro
	}

	enum PresenceEyeDirection{
		extreme_left,
		inbetween_left,
		front,
		inbetween_right,
		extreme_right
	}

	presence_visual_enable = room == r_game_level_presence;
	presence_visual_state = PresenceVisualState.hidden;
	presence_visual_enter_distance = 1000;
	presence_visual_exit_distance = 1250;
	presence_visual_frame_speed = ANIMATION_FPS_DEFAULT / SECOND;
	presence_visual_eye_frame_speed = 30 / SECOND;
	presence_visual_eye_update_accumulator = 0;
	presence_visual_intro_frame = 0;
	presence_visual_body_idle_frame = 44;
	presence_visual_head_idle_frame = 0;
	presence_visual_eyes_idle_frame = 30;
	presence_visual_body_intro_end = 43;
	presence_visual_body_idle_start = 44;
	presence_visual_body_idle_end = 73;
	presence_visual_head_intro_end = 29;
	presence_visual_head_right_idle_end = 8;
	presence_visual_front_eyes_intro_first = 0;
	presence_visual_front_eyes_intro_end = 20;
	presence_visual_front_eyes_idle_start = 30;
	presence_visual_front_eyes_idle_end = 39;
	// Andy's diagram defines the allowed eye travel window directly as 142x76.
	// The Step event subtracts each directional sprite's baked displacement so
	// the visible eyes, not the full sprite canvas, remain inside that boundary.
	presence_visual_eye_tracking_range_x = 142;
	presence_visual_eye_tracking_range_y = 76;
	presence_visual_eye_tracking_world_range_x = 600;
	presence_visual_eye_tracking_world_range_y = 420;
	presence_visual_eye_tracking_inbetween_threshold = 0.33;
	presence_visual_eye_tracking_extreme_threshold = 0.75;
	presence_visual_eye_offset_x = 0;
	presence_visual_eye_offset_y = 0;
	presence_visual_eye_art_offset_x = 0;
	presence_visual_eye_art_offset_y = 0;
	presence_visual_eye_outro_start_total_x = 0;
	presence_visual_eye_outro_start_total_y = 0;
	presence_visual_eye_direction = PresenceEyeDirection.front;
	presence_visual_eye_direction_target = PresenceEyeDirection.front;
	presence_visual_eye_sprite = spr_npc_presence_eyes_front;
#endregion
