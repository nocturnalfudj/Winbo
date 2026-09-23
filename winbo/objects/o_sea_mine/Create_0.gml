// The sprite origin is the mine body centre. The manual ellipse excludes
// the chain and leaves four pixels of forgiveness inside the visible body.
image_speed = 0;
anchor_x = x;
anchor_y = y;
motion_time = 0;
sway_distance = 4;
bob_distance = 3;
sway_period = 4 * SECOND;
bob_period = 3 * SECOND;
damage_amount = 1;
armed = true;

// A mine owns its contact damage; it deliberately does not inherit o_hazard.
// Consume the contact before player_hit, including invincible-player contacts.
detonate = function(_player){
	if(!armed || (global.game_state != GameState.play)){
		return;
	}
	armed = false;

	with(_player){
		player_hit(other.damage_amount, other.id, false);
	}

	// Match the existing missile explosion, scaled to the 204px mine body.
	fx_spawn_sprite_once(x, y, "lyr_pfx_foreground", spr_missile_explosion,
		0.16 * abs(image_xscale), 0.16 * abs(image_yscale), 0);
	instance_destroy();
};
