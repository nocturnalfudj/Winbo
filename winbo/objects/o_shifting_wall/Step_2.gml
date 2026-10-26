event_inherited();

// The stationary track can remain in view after the moving wall leaves it.
// Cull the full assembly using the same track placement as Draw.
var _left = bbox_left;
var _top = bbox_top;
var _right = bbox_right;
var _bottom = bbox_bottom;
if(shifting_wall_track_draw){
    var _track = (shifting_wall_variant == 1) ? spr_shifting_wall_track_stone : spr_shifting_wall_track;
    var _wall_width = sprite_get_width(sprite_current) * abs(image_xscale);
    var _track_x = start_x + (_wall_width - sprite_get_width(_track)) * 0.5 - sprite_get_xoffset(_track);
    var _track_y = start_y + path_point[1].y - sprite_get_yoffset(_track);
    _left = min(_left, _track_x);
    _top = min(_top, _track_y);
    _right = max(_right, _track_x + sprite_get_width(_track));
    _bottom = max(_bottom, _track_y + sprite_get_height(_track));
}
camera_visible_position = rectangle_in_rectangle(_left, _top, _right, _bottom,
    o_camera.start_x, o_camera.start_y, o_camera.end_x, o_camera.end_y) != 0;
camera_visible = camera_visible_always || (camera_visible_position
    && image_alpha != 0 && image_xscale != 0 && image_yscale != 0);
