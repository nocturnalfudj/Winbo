// Prevent crashes if spawned without a sprite initialised yet.
if (sprite_current < 0) {
	exit;
}

if(fx_follow_enabled){
	x = fx_follow_target.x + fx_follow_offset_x;
	y = fx_follow_target.y + fx_follow_offset_y;
}

// Match the white smoke palette while retaining the authored alpha animation.
if(fx_sprite == spr_smoke_bump_impact){
	shader_set(sh_monochrome);
	event_inherited();
	shader_reset();
}
else{
	event_inherited();
}
