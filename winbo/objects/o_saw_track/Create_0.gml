sprite_current = spr_saw_track;
sprite_index = spr_saw_track;
image_speed = 0;
saw_track_group = 0;
saw_track_slice_size = 64;
saw_track_width = sprite_get_width(sprite_current) * abs(image_xscale);
saw_track_height = sprite_get_height(sprite_current) * abs(image_yscale);
