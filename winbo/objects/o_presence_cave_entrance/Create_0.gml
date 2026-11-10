event_inherited();

// One placeable prop that works on any layer: the back and portal sit just
// behind Winbo and the rock and vines just in front, so he walks into the cave.
var _player_depth = layer_get_depth(layer_get_id("lyr_player"));
depth = _player_depth + 1;
front_part = instance_create_depth(x, y, _player_depth - 1, o_presence_cave_entrance_front);
front_part.owner = id;

image_speed = 0;
portal_animation_fps = 30;
portal_frame_count = sprite_get_number(spr_presence_cave_portal);
portal_position = 0;
