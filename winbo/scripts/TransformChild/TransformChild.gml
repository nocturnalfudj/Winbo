/// @function TransformChild
/// @summary Tracks per-child transform overrides.
/// @returns {struct} TransformChild struct.
function TransformChild() constructor{
	value[TransformValue.x] = 0;
	value[TransformValue.y] = 0;
	value[TransformValue.xscale] = 1;
	value[TransformValue.yscale] = 1;
	value[TransformValue.alpha] = 1;
	value[TransformValue.angle] = 0;
	value[TransformValue.colour] = c_white;
	
	value_update[TransformValue.x] = false;
	value_update[TransformValue.y] = false;
	value_update[TransformValue.xscale] = false;
	value_update[TransformValue.yscale] = false;
	value_update[TransformValue.alpha] = false;
	value_update[TransformValue.angle] = false;
	value_update[TransformValue.colour] = false;
	
	update = false;
	
	//Default Relationship
	anchor_child_relationship[TransformValue.x] = 0;
	anchor_child_relationship[TransformValue.y] = 0;
	anchor_child_relationship[TransformValue.xscale] = 1;
	anchor_child_relationship[TransformValue.yscale] = 1;
	anchor_child_relationship[TransformValue.alpha] = 1;
	anchor_child_relationship[TransformValue.angle] = 0;
	anchor_child_relationship[TransformValue.colour] = c_white;
	
	//Default Scale Enable
	anchor_child_scale_enable[TransformValue.x] = true;
	anchor_child_scale_enable[TransformValue.y] = true;
	anchor_child_scale_enable[TransformValue.xscale] = true;
	anchor_child_scale_enable[TransformValue.yscale] = true;
	anchor_child_scale_enable[TransformValue.alpha] = true;
	anchor_child_scale_enable[TransformValue.angle] = false;
	anchor_child_scale_enable[TransformValue.colour] = false;
	
	//Scale transform value can be used for animating the relationship between the anchor and the specific child
	anchor_child_scale = new TransValue(1);
}