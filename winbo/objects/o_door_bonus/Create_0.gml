// Inherit parent
event_inherited();

// Override bonus door flag
bonus_door_enable = true;

// Room to transition to (set this in room editor per-instance)
// room_target is inherited from o_door - set it in room instance properties

// Interaction state tracking
bonus_door_player_overlapping = false;
bonus_door_input_pressed = false;
