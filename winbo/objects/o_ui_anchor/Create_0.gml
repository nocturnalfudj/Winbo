// Inherit the parent event
event_inherited();

//Scroll
scroll = noone;

//Transform Children
var _x,_y,_x_center,_y_center,_x_width,_y_height;
with(o_camera){
	_x_center = width_ini_half;
	_y_center = height_ini_half;
	_x_width = width_ini;
	_y_height = height_ini;
}

for(var _i=0;_i<AnchorTransformChild.SIZE;_i++){
	//Other instances can use specific children for parents
	//allowing for essentially multiple anchors all controlled via one, without the need for more anchor instances
	transform_system_new_transform_child();
	
	
	with(transform_child[_i]){
		switch(_i){
			case AnchorTransformChild.center:
				anchor_child_relationship[TransformValue.x] = _x_center;
				anchor_child_relationship[TransformValue.y] = _y_center;
			break;
			
			case AnchorTransformChild.top_left:
				anchor_child_relationship[TransformValue.x] = 0;
				anchor_child_relationship[TransformValue.y] = 0;
			break;
		
			case AnchorTransformChild.top_center:
				anchor_child_relationship[TransformValue.x] = _x_center;
				anchor_child_relationship[TransformValue.y] = 0;
			break;
			
			case AnchorTransformChild.top_right:
				anchor_child_relationship[TransformValue.x] = _x_width;
				anchor_child_relationship[TransformValue.y] = 0;
			break;
			
			case AnchorTransformChild.center_right:
				anchor_child_relationship[TransformValue.x] = _x_width;
				anchor_child_relationship[TransformValue.y] = _y_center;
			break;
			
			case AnchorTransformChild.bottom_right:
				anchor_child_relationship[TransformValue.x] = _x_width;
				anchor_child_relationship[TransformValue.y] = _y_height;
			break;
			
			case AnchorTransformChild.bottom_center:
				anchor_child_relationship[TransformValue.x] = _x_center;
				anchor_child_relationship[TransformValue.y] = _y_height;
			break;
			
			case AnchorTransformChild.bottom_left:
				anchor_child_relationship[TransformValue.x] = 0;
				anchor_child_relationship[TransformValue.y] = _y_height;
			break;
			
			case AnchorTransformChild.center_left:
				anchor_child_relationship[TransformValue.x] = 0;
				anchor_child_relationship[TransformValue.y] = _y_center;
			break;
		}
	}
}
	
#region State Scripts
	state_script[UIState.destroy][UIStateStage.main] = anchor_destroy_main;
#endregion