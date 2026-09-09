// Draw End keeps the lock indicator above Winbo regardless of instance depth.
with(target_instance){
    if(target_can_be_targeted[TargetType.attack]){
        var _px = (bbox_left + bbox_right) * 0.5;
        var _py = (bbox_top + bbox_bottom) * 0.5;
        draw_sprite_ext(spr_turret_reticle, other.reticle_frame, _px, _py, 1, 1, 0, c_white, 1);
    }
}
