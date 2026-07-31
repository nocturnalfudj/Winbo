event_inherited();

sprite_current = spr_bonus_door_ornate;
sprite_index = spr_bonus_door_ornate;
image_xscale = 1;
image_yscale = 1;
bonus_door_open_last_image_index = sprite_get_number(spr_bonus_door_ornate_open) - 1;
bonus_door_creak_armed = true;
image_system_setup(sprite_current, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
