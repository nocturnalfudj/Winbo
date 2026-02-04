function anchor_interact_create_main(){
	//Ignore if No Space Set
	if(interact_space == noone)
		exit;
		
	#region UI Creation
		var _x,_y,_x_center,_y_center,_x_width,_y_height;
		with(o_camera){
			_x_center = width_ini_half;
			_y_center = height_ini_half;
			_x_width = width_ini;
			_y_height = height_ini;
		}
		
		var _interact_ui_children_list;
		_interact_ui_children_list = interact_ui_children;
		
		var _user;
		_user = interact_user_id;
		
		var _gui;
		_gui = gui;
		
		var _anchor_transform_child_array;
		_anchor_transform_child_array = transform_child;
		
		var _interact_system_instance,_interactor_instance;
		_interact_system_instance = interact_system_instance;
		_interactor_instance = interactor_instance;
		
		var _anchor_x,_anchor_y;
		_anchor_x = x;
		_anchor_y = y;
		
		var _interaction;
		
		with(interact_space){
			var _indicator_x,_indicator_y,_indicator_title,_indicator_subtitle;
			var _indicator_position_relative_instance,_indicator_position_relative_x,_indicator_position_relative_y;
			var _indicator_down_time_enable,_indicator_down_time_x,_indicator_down_time_y;
			
			//Go Through Interactions
			for(var _i=0;_i<interaction_count;_i++){
				_interaction = interaction[_user][_i];
				with(_interaction){
					//Skip if Interaction Disabled
					if(!enable)
						continue;
					
					//Skip if Indicator Disabled
					if(!indicator_enable)
						continue;
					
					//Part of Group
					if(!indicator_part_of_group){
						//Indicator Position
						_indicator_position_relative_instance = noone;
						if(indicator_position_relative_to_interactor){
							_indicator_position_relative_instance = _interactor_instance;
						}
						else{
							_indicator_position_relative_instance = _interact_system_instance;
						}
						_indicator_position_relative_x = indicator_x;
						_indicator_position_relative_y = indicator_y;
						
						_indicator_x = _indicator_position_relative_instance.x + _indicator_position_relative_x;
						_indicator_y = _indicator_position_relative_instance.y + _indicator_position_relative_y;
						
						//Title
						_indicator_title = title_string;
						_indicator_subtitle = subtitle_string;
						
						//Indicator Down Time
						_indicator_down_time_enable = indicator_down_time_enable;
						_indicator_down_time_x = indicator_down_time_x;
						_indicator_down_time_y = indicator_down_time_y;
						
						//Create Indicator
						indicator_instance = instance_create_layer(_indicator_x,_indicator_y,"lyr_hud",indicator_object);
						ds_list_add(_interact_ui_children_list,indicator_instance);
						with(indicator_instance){
							//Appear
							transform_animate_grow_and_appear(0.2*SECOND,,-(_i * 0.1 * SECOND));
							
							//Interaction
							interaction = _interaction;
							
							//GUI
							gui = _gui;
							
							//Transform Parent
							transform_parent = _anchor_transform_child_array[transform_parent_anchor_child_id];
							
							//Do Not Inherit Position from the Anchor Parent
							transform_parent_inherit[TransformValue.x] = false;
							transform_parent_inherit[TransformValue.y] = false;
							
							transform_parent_distance_relative_to_scale_x = false;
							transform_parent_distance_relative_to_scale_y = false;
							
							//Position Relative Instance
							position_relative_instance = _indicator_position_relative_instance;
							position_relative_x = _indicator_position_relative_x;
							position_relative_y = _indicator_position_relative_y;
							
							//Title
							if(_indicator_title != ""){
								title_enable = true;
								title_string = _indicator_title;
							}
							else{
								title_enable = false;
							}
								
							//Subtitle
							if(_indicator_subtitle != ""){
								subtitle_enable = true;
								subtitle_string = _indicator_subtitle;
							}
							else{
								subtitle_enable = false;
							}
							
							//Down Time Indicator
							down_time_indicator_enable = _indicator_down_time_enable;
							down_time_indicator_x = _indicator_down_time_x;
							down_time_indicator_y = _indicator_down_time_y;
						}
					}
				}
			}
		}
	#endregion
	
	//Distribution Script
	if(distribution_script != noone)
		script_execute(distribution_script);
}