// Inherit the parent event
event_inherited();

//Image
sprite_current = sprite_index;//director_get_custom_sprite(spr_talisman);

image_flame = new Image(spr_talisman_flame,ANIMATION_FPS_DEFAULT,true,true,0,IMAGE_LOOP_FULL);

//Collection
collect_script = pickup_collect_talisman;

//Talisman
talisman_id = noone;