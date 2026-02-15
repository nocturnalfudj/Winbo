// Prevent crashes if spawned without a sprite initialised yet.
if (sprite_current < 0) {
	exit;
}

event_inherited();
