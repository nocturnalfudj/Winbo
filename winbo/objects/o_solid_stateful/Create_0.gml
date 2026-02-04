// Inherit the parent event
event_inherited();

//State
enum SolidState{
	idle,
	hit
}

uses_states = true;
state = SolidState.idle;

//Hit
hit_state = SolidState.hit;
hit_state_previous = SolidState.idle;
hit_attacker_last = noone;
hit_attacker_last_team = noone;

//Interact Disabled by Default for Solids
//Enabled in the solid_interact parent
interact_enable = false;