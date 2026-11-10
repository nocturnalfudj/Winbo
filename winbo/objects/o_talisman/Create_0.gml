// Inherit the parent event
event_inherited();

//Image
// talisman_id (0-13) is a Variable Definition set per placement in the room editor.
sprite_index = o_director.talisman_sprite[talisman_id];
sprite_current = sprite_index;

image_flame = new Image(spr_talisman_flame,ANIMATION_FPS_DEFAULT,true,true,0,IMAGE_LOOP_FULL);

//Collection
collect_script = pickup_collect_talisman;