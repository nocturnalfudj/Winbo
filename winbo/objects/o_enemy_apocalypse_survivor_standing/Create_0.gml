// Inherit the parent event
event_inherited();

survivor_allow_crouch = false;
survivor_allow_movement = false;
survivor_hostile_posture = SurvivorPosture.standing;

// Use the dedicated idle loop whenever the standing variant is calm and stationary.
sprite_walk_relaxed_left = sprite_idle;
sprite_walk_relaxed_right = sprite_idle;
walk_relaxed_idle_start = 0;
walk_relaxed_idle_end = sprite_get_number(sprite_idle) - 1;
walk_relaxed_walk_start = walk_relaxed_idle_start;
walk_relaxed_walk_end = walk_relaxed_idle_end;
