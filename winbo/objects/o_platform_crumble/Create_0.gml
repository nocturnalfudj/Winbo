// Inherit the parent event
event_inherited();

//Image
sprite_current = spr_platform_crumble;
sprite_idle = sprite_current;  // Store the idle sprite explicitly
sprite_break = spr_platform_crumble_break;  // Store the break sprite explicitly

//State
enum CrumblePlatformState{
	idle,
	crumble_countdown,
	crumble_active,
	crumble_idle,
	respawn_countdown,
	respawn_active,
	
	SIZE
}

crumble_platform_state = CrumblePlatformState.idle;

// Crumble timing
crumble_countdown_max = SECOND * 0.75;
crumble_countdown = crumble_countdown_max;

// Idle duration after crumbling
crumble_idle_time_max = SECOND * 0.3;
crumble_idle_time = crumble_idle_time_max;

// Respawn timing
respawn_countdown_max = SECOND * 3;
respawn_countdown = respawn_countdown_max;

#region Trigger system
	enum PlatformCrumbleTrigger{
		touch,
		dash,
	}
	// These platforms are authored as Air-Dash breakables. Ordinary standing
	// must retain their collision; only the explicit Dash collision path starts
	// the break sequence.
	crumble_trigger_type = PlatformCrumbleTrigger.dash;
	crumble_trigger_active = false;
	crumble_trigger_active_instant = true;
#endregion

// Respawn control
respawn_enable = true;

// Optional break FX. Child objects opt into this after inherited setup.
break_fx_enable = false;
break_fx_sprite = noone;
break_fx_smoke_sprite = noone;
break_fx_columns = 4;
break_fx_rows = 3;
break_fx_blast_direction = noone;

// Collision mask storage for restoration
original_mask = mask_index;

// Phantom platform system (move platform out of room when crumbled)
origin_x = x;
origin_y = y;
phantom = false;

// Visual offset for shake effect (visual only, doesn't affect collision)
visual_offset_x = 0;
visual_offset_y = 0;

// Image System (animation)
image_system_create();
image_system_setup(sprite_current, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
