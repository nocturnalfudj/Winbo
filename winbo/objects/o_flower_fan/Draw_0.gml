// Wind starts at the flower centre; both art and force use the same rotation and scale.
if(fan_state == FlowerFanState.active){
    draw_sprite_ext(wind_sprite, wind_image.frame, x, y,
        image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}
draw_sprite_ext(sprite_current, sprite_current_frame, x, y,
    image_xscale, image_yscale, image_angle, image_blend, image_alpha);
