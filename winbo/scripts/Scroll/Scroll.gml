/// @function Scroll
/// @summary UI container that supports scrolling child elements.
/// @param {real} _x Starting x position for the scroll view.
/// @param {real} _y Starting y position for the scroll view.
/// @returns {struct} Scroll container struct.
/// @description
///   After creation call this object's `Step` script every frame to update scrolling.
function Scroll(_x,_y) constructor{
	//Create Dimensions System
	dimension_system_create();
	
	//This is needed for the first step the scroll exists
	//it needs to update its transform _before_ any other ui that is using it as a transform parent
	//otherwise all that child ui flashes onscreen in unupdated positions
	just_created = true;

	//Create Transform System
	x = -_x;
	y = -_y;
	image_xscale = 1;
	image_yscale = 1;
	image_blend = c_white;
	image_alpha = 1;
	image_angle = 0;
	transform_system_create();
	
	#region Transform Children
		//Transform Children
		var _x_center,_y_center,_x_width,_y_height;
		_x_center = 0;
		_y_center = 0;
		_x_width = 0;
		_y_height = 0;
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
	#endregion
	
	//Mouse Wheel Direction
	mouse_wheel_direction_y = -1;
	mouse_wheel_direction_x = 0;
	
	#region Position Clamp
		position_clamp_enable_x = false;
		position_clamp_enable_y = false;
		position_clamp_max = new Vector2(0,0);
		position_clamp_min = new Vector2(0,0);
	#endregion
	
	#region Movement
		//Movement System
		movement_system_create();
		move_collision_object = noone;
		move_trapped_check = false;
		move_grounded_check = false;
		
		movement_velocity_retention_and_acceleration_max_set(0.8,60);
		movement_input_move_acceleration_default_set(acceleration_max);
		
		#region Drag Pan
			//Enable Systems
			movement_drag_pan_enable();
			
			//Drag X Disable
			drag_enable_x = false;
			
			//Drag Y Invert
			drag_invert_y = true;
			
			//Pan Y Invert
			pan_invert_y = true;
			
			//Pan Mouse Scroll Y Enable
			pan_mouse_scroll_enable_y = true;
			
			//Edge Scroll
			pan_edge_scroll_enable_x = false;
			pan_edge_scroll_enable_y = false;
			
			//Clamp
			position_clamp_enable_y = true;
			
			var _y_max,_y_min;
			_y_max = y + 0;
			_y_min = y - 600;
			position_clamp_max.Set(0,_y_max);
			position_clamp_min.Set(0,_y_min);
		#endregion
	#endregion
}