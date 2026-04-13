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

	presence_visual_enable = room == r_game_level_presence;
	presence_visual_state = PresenceVisualState.hidden;
	presence_visual_enter_distance = 1000;
	presence_visual_exit_distance = 1250;
	presence_visual_frame_speed = ANIMATION_FPS_DEFAULT / SECOND;
	presence_visual_intro_frame = 0;
	presence_visual_body_idle_frame = 30;
	presence_visual_head_idle_frame = 0;
	presence_visual_eyes_idle_frame = 30;
	presence_visual_body_intro_end = 29;
	presence_visual_body_idle_start = 30;
	presence_visual_body_idle_end = 74;
	presence_visual_front_eyes_intro_end = 20;
	presence_visual_front_eyes_idle_start = 30;
	presence_visual_front_eyes_idle_end = 39;
	presence_visual_head_direction = PresenceHeadDirection.front;
	presence_visual_eye_sprite = spr_npc_presence_eyes_front;
#endregion
