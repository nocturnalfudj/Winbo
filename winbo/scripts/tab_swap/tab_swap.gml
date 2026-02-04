function tab_swap(_new_tab,_direction_override,_time_current){
	var _direction,_remove_tab;
	_direction = -1;
	_remove_tab = true;
	_time_current ??= 0;
	
	if(_direction_override != undefined)
		_direction = _direction_override;
	
	var _same_tab_group_swap_direction_set;
	_same_tab_group_swap_direction_set = false;
	
	#region Remove Current Tab
		with(o_tab){
			if(tab != _new_tab){
				//Exisitng Tab is in Same Tab Group as New Tab
				if(tab.tab_group == _new_tab.tab_group){
					//Direction Is NOT Being Overriden
					if(_direction_override == undefined){
						if(tab.position > _new_tab.position)
							_direction = 1;
						else
							_direction = -1;
					}
					
					//A Tab from the same tab group exists, and is being swapped out for the new one
					//so ignore any other tabs present (such as children tabs of the one being swapped out) for deciding direction
					_same_tab_group_swap_direction_set = true;
					
					_remove_tab = true;
				}
				//Exisiting Tab is NOT in Same Tab Group as New Tab
				else{
					//Check if Tab has a Tab Parent
					if(tab.parent_tab != noone){
						_remove_tab = false;
					}
					else{
						//Direction Is NOT Being Overriden
						if(_direction_override == undefined){
							if(!_same_tab_group_swap_direction_set){
								if(tab.tab_group > _new_tab.tab_group)
									_direction = 1;
								else
									_direction = -1;
							}
						}
					
						//Check if ALL Other Tabs Should be Removed
						if(_new_tab.remove_other_tab_group_tab)
							_remove_tab = true;
						//Or Just Tabs Within Same Tab Group as New Tab
						else
							_remove_tab = false;
					}
				}
				
				if(_remove_tab){
					if(state != UIState.destroy){
						script_execute(tab.exit_script,_direction,_time_current);
					}
					else{
						//Swipe Transform Animation Speed Up
						var _transform,_start,_time_max,_ease;
						_transform = transform[TransformType.anchor];
						_time_max = SECOND*0.3;
						transform_set_time_max(_transform,TransformValue.x,_time_max)
					}
				}
			}
		}
	#endregion
	
	//Create New Tab
	tab_create(_new_tab,-_direction,_time_current);
}