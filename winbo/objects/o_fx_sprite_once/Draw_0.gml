// Prevent crashes if spawned without a sprite initialised yet.
if (sprite_current < 0) {
	exit;
}

if(fx_follow_enabled){
	x = fx_follow_target.x + fx_follow_offset_x;
	y = fx_follow_target.y + fx_follow_offset_y;
}

// Give bump smoke a white, opaque core while retaining soft transparent edges.
if(fx_sprite == spr_smoke_bump_impact){
	shader_set(sh_smoke_white);
	event_inherited();
	shader_reset();
}
else{
	event_inherited();
}
