if(global.game_state != GameState.play){
    exit;
}

// Keep the plant and its translucent tunnel behind Winbo, including room-created players.
with(o_player){
    other.depth = depth + 10;
}
image_system_update();
if(fan_state == FlowerFanState.blooming && !image.animate){
    fan_state = FlowerFanState.active;
    sprite_index = -1;
    mask_index = -1;
    image_system_setup(spr_flower_fan_spin, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
    image.image_animation_time_scale_enable = true;
    sprite_current_frame = 0;
}
if(fan_state == FlowerFanState.active){
    image_animate(wind_image, false);
}
