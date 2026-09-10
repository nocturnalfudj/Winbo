draw_sprite_ext(spr_turret_back, shot_frame, x, y, image_xscale, image_yscale, aim_angle - 90, image_blend, image_alpha);
draw_sprite_ext(spr_turret_front, target_instance != noone, x, y, image_xscale, image_yscale, mount_angle, image_blend, image_alpha);
