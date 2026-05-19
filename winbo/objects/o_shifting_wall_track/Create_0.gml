sprite_current = spr_shifting_wall_track;
sprite_index = spr_shifting_wall_track;
image_speed = 0;
shifting_wall_track_group = 0;
shifting_wall_track_slice_size = 12;
shifting_wall_track_width = sprite_get_width(sprite_current) * abs(image_xscale);
shifting_wall_track_height = sprite_get_height(sprite_current) * abs(image_yscale);
