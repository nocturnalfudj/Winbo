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

	enum PresenceHeadDirection{
		front,
		left,
		right
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
	presence_visual_head_front_idle_end = 8;
	presence_visual_head_left_idle_end = 9;
	presence_visual_head_right_idle_end = 8;
	presence_visual_front_eyes_intro_first = 0;
	presence_visual_front_eyes_intro_end = 20;
	presence_visual_front_eyes_idle_start = 30;
	presence_visual_front_eyes_idle_end = 39;
	// Each supplied eye sprite is a full-canvas layer and must stay anchored to
	// the body/head draw origin; direction changes swap complete sprite sets.
	presence_visual_eye_tracking_world_range_x = 600;
	presence_visual_eye_tracking_inbetween_threshold = 0.33;
	presence_visual_eye_tracking_extreme_threshold = 0.75;
	presence_visual_eye_direction = PresenceEyeDirection.front;
	presence_visual_eye_direction_target = PresenceEyeDirection.front;
	presence_visual_head_direction = PresenceHeadDirection.front;
	presence_visual_eye_sprite = spr_npc_presence_eyes_front;
#endregion
