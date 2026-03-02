// Inherit the parent event
event_inherited();

//Attack Type
attack_type = AttackType.ranged;

// Ranged enemies park at spike edges and keep attacking while aggro conditions hold.
hostile_spike_response = HostileSpikeResponse.stop;
