event_inherited();

enum FlowerFanState { bud, blooming, active }
fan_state = wind_start_active ? FlowerFanState.active : FlowerFanState.bud;
wind_sprite = wind_large ? spr_flower_wind_large : spr_flower_wind_small;
wind_image = new Image(wind_sprite, ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
wind_image.image_animation_time_scale_enable = true;
image_speed = 0;
image_system_setup(wind_start_active ? spr_flower_fan_spin : spr_flower_fan_bud,
    ANIMATION_FPS_DEFAULT, true, true, 0, IMAGE_LOOP_FULL);
image.image_animation_time_scale_enable = true;

// Only the closed bud is a solid bump target. Active wind is never a platform.
if(fan_state == FlowerFanState.active){
    sprite_index = -1;
    mask_index = -1;
}
