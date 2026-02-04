// Inherit the parent event
event_inherited();

mouse_collision_enable = true;

//Set Collision Mask
sprite_index = spr_bar_collision;
mask_index = spr_bar_collision;

//Do Not Inherit These Transform Values
transform_parent_inherit[TransformValue.xscale] = false;
transform_parent_inherit[TransformValue.yscale] = false;
transform_parent_inherit[TransformValue.angle] = false;
transform_parent_inherit[TransformValue.alpha] = false;

//Bar Fill Direction
enum BarDirection{
	up,
	down,
	left,
	right
}

bar_direction = BarDirection.up;

#region Image
	edge_sprite = spr_bar_shadow;
#endregion

//Disable Distance Relative to Scale of Parent
//bar ui objects do not operate correctly with this enabled
transform_parent_distance_relative_to_scale_x = false;
transform_parent_distance_relative_to_scale_y = false;

//Bar Colour
colour = c_ags_red;
distance = 125;
buff = 10;