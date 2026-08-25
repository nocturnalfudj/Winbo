// Prevent crashes if spawned without a sprite initialised yet.
if (sprite_current < 0) {
	exit;
}

if(fx_follow_enabled){
	x = fx_follow_target.x + fx_follow_offset_x;
	y = fx_follow_target.y + fx_follow_offset_y;
}

event_inherited();
