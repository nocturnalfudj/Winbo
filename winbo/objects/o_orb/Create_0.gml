// Inherit the parent event
event_inherited();

//Image
sprite_current = sprite_index;
image_system_setup(sprite_current, sprite_get_speed(sprite_current), true, true, 0, IMAGE_LOOP_FULL);
image.image_animation_time_scale_enable = true;

//Collection
collect_script = pickup_collect_orb;

//Value
orb_value = 1;

//Heal
heal_value = 0;
