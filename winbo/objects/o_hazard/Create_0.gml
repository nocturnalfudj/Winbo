// Inherit the parent event
event_inherited();

//Damage
damage_amount = 1;

//Instant Kill
instant_kill = false;

// Spikes override this to match their visible extension.
hazard_is_active = function(_active_scale_min = 0.15){
	return true;
};
