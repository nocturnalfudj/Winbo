// Inherit the parent event
event_inherited();

//Image
sprite_current = sprite_index;//director_get_custom_sprite(spr_life);
image_system_setup(sprite_index,ANIMATION_FPS_DEFAULT,true,true,0,IMAGE_LOOP_FULL);

//Collection
collect_script = pickup_collect_life;

//Value
life_value = 1;

//Hover
hover_enable = false;