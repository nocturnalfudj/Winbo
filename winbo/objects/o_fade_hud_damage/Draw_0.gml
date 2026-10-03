if(fade_factor <= 0) exit;

var _left = o_camera.start_x;
var _top = o_camera.start_y;
var _right = _left + o_camera.width;
var _bottom = _top + o_camera.height;
var _depth = min(o_camera.width, o_camera.height) * 0.18;
var _alpha = image_alpha * fade_factor;
var _outer_x = [_left, _right, _right, _left, _left];
var _outer_y = [_top, _top, _bottom, _bottom, _top];
var _inner_x = [_left + _depth, _right - _depth, _right - _depth, _left + _depth, _left + _depth];
var _inner_y = [_top + _depth, _top + _depth, _bottom - _depth, _bottom - _depth, _top + _depth];

draw_primitive_begin(pr_trianglestrip);
for(var _i = 0; _i < 5; _i++){
    draw_vertex_colour(_outer_x[_i], _outer_y[_i], c_black, _alpha);
    draw_vertex_colour(_inner_x[_i], _inner_y[_i], c_black, 0);
}
draw_primitive_end();
draw_set_alpha(1);
draw_set_colour(c_white);
