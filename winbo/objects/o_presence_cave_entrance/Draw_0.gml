if(!camera_visible) exit;

draw_sprite_ext(spr_presence_cave_back, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
draw_sprite_ext(spr_presence_cave_portal, floor(portal_position), x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
draw_sprite_ext(spr_presence_cave_arch, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
draw_sprite_ext(spr_presence_cave_front, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
