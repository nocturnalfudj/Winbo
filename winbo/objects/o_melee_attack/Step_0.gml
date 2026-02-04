/// Step (Begin) event for o_melee_attack
// Inherit the parent event
event_inherited();

// Destroy if owner is gone
if(!instance_exists(owner)){
	instance_destroy();
	exit;
}

// Follow owner position
x = owner.x;
y = owner.y;

// Keep team in sync
team = owner.team;
