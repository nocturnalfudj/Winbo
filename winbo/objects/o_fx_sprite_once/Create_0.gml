event_inherited();

// No UI/actor extras for VFX
info_bar_enable = false;

// Parent sets these to 0; restore visibility defaults
image_xscale = 1;
image_yscale = 1;
image_alpha  = 1;
image_blend  = c_white;

fx_sprite = noone;
fx_fps = ANIMATION_FPS_DEFAULT;
fx_follow_enabled = false;
fx_follow_target = noone;
fx_follow_offset_x = 0;
fx_follow_offset_y = 0;

_fx_started = false;
