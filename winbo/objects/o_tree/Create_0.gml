// Inherit the parent event
event_inherited();

//Variant (tree_variant is a Variable Definition: "random", "a", "b", "c", "d")
var _sprites = [spr_tree_a, spr_tree_b, spr_tree_c, spr_tree_d];
var _index = irandom(array_length(_sprites) - 1);

switch(tree_variant){
	case "a": _index = 0; break;
	case "b": _index = 1; break;
	case "c": _index = 2; break;
	case "d": _index = 3; break;
}

sprite_index = _sprites[_index];
sprite_current = sprite_index;

#region Scale
	//Trees keep their authored relative sizes; the set is scaled so its average visible height
	//matches the old trunk + leaves trees (1170, 1594, 1430, 1385 px tall)
	var _height_total = 0;
	for(var _i = 0; _i < array_length(_sprites); _i++)
		_height_total += sprite_get_yoffset(_sprites[_i]) - sprite_get_bbox_top(_sprites[_i]);

	var _scale = (1395 * array_length(_sprites)) / _height_total;
	image_xscale *= _scale;
	image_yscale *= _scale;
#endregion

//Ground - sit the lowest opaque pixel on the placement point
y += (sprite_get_yoffset(sprite_index) - sprite_get_bbox_bottom(sprite_index) - 1) * image_yscale;

//Camera Visible Buffer - origin is at the base, so the buffer must reach the full scaled height
camera_visible_buff_width = abs(sprite_width) * camera_visible_buff_factor;
camera_visible_buff_height = abs(sprite_height) * camera_visible_buff_factor;
