// Inherit the parent event
event_inherited();

//Image
sprite_current = sprite_index;
sprite_idle = spr_platform_crumble_dash;  // Store the idle sprite explicitly
sprite_break = spr_platform_crumble_dash_break;  // Store the break sprite explicitly

//Trigger Type
crumble_trigger_type = PlatformCrumbleTrigger.dash;
crumble_trigger_active_instant = true;

// Respawn control
respawn_enable = true;