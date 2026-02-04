// Inherit the parent event
event_inherited();

enum PickupState{
	create,
	idle,
	collect,
	death,
	destroy
}

state = PickupState.create;

//Position/Scale Adjustment for Hover Animation
adjustment_x = 0;
adjustment_y = 0;
adjustment_scale_x = 0;
adjustment_scale_y = 0;

//Hover
hover_enable = true;

//Collection
collect_script = noone;