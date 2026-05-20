// Draw_0.gml event
//Ignore if Not Visible
if(!camera_visible)
	exit;
	
//Only Operate In Normal Draw Event
if(o_director.depth_grid_draw_event_state != 1)
	exit;

draw_sprite_ext(spr_bonus_door_ornate_back,0,x,y,image_xscale,image_yscale,0,image_blend,image_alpha);

var _door_frame = min(sprite_get_number(spr_bonus_door_ornate_open) - 1,floor(bonus_door_open_image_index));

if(bonus_door_open_image_index > 0){
	var _portal_frame = floor(bonus_door_portal_image_index) mod sprite_get_number(spr_bonus_door_ornate_portal);
	draw_sprite_ext(spr_bonus_door_ornate_portal,_portal_frame,x,y,image_xscale,image_yscale,0,image_blend,image_alpha);
}

draw_sprite_ext(spr_bonus_door_ornate_open,_door_frame,x,y,image_xscale,image_yscale,0,image_blend,image_alpha);
draw_sprite_ext(sprite_current,0,x,y,image_xscale,image_yscale,0,image_blend,image_alpha);
	
if(o_master.dev_mode){
	draw_bounding_box();
}
