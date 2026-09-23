if(global.game_state != GameState.play){
    surface_speed_x = 0;
    exit;
}

surface_speed_x = conveyor_speed;
// The authored top tread travels left as the frame index increases.
var _frame_count = sprite_get_number(sprite_index);
conveyor_frame = (conveyor_frame - conveyor_speed * 2.5 * global.delta_time_factor_scaled / SECOND) mod _frame_count;
if(conveyor_frame < 0) conveyor_frame += _frame_count;
sprite_current_frame = conveyor_frame;
