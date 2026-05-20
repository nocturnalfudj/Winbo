// Inherit parent
event_inherited();

// Override bonus door flag
bonus_door_enable = true;

// Room to transition to (set this in room editor per-instance)
// room_target is inherited from o_door - set it in room instance properties

// Interaction state tracking
bonus_door_player_overlapping = false;
bonus_door_input_pressed = false;
bonus_door_open_image_index = 0;
bonus_door_portal_image_index = 0;
bonus_door_open_last_image_index = 0;
bonus_door_open_animation_fps = 18;
bonus_door_portal_animation_fps = 30;
