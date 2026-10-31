event_inherited();

// Room-editor mirroring must expand the culling bounds in both directions.
camera_visible_buff_width = abs(camera_visible_buff_width);
camera_visible_buff_height = abs(camera_visible_buff_height);

// One placeable background prop; all four layers share the same canvas and origin.
image_speed = 0;
portal_animation_fps = 30;
portal_frame_count = sprite_get_number(spr_presence_cave_portal);
portal_position = 0;
