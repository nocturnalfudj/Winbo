// Mirrors the owner's live transform so room-editor scale and flips carry over.
with(owner){
	if(camera_visible){
		draw_sprite_ext(spr_presence_cave_arch, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
		draw_sprite_ext(spr_presence_cave_front, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
	}
}
