function interact_system_cleanup(){
	//Get Toggle Group List
	var _toggle_group_list;
	_toggle_group_list = o_director.interact_toggle_group_space_interaction_list;
	
	//Go Through Spaces
	var _space;
	var _interaction;
	for(var _i=0;_i<interact_space_count;_i++){
		_space = interact_space[_i];
		with(_space){
			//Go Through Each User
			for(var _j=0;_j<USER_NUM_MAX;_j++){
				//Go Through Interactions
				for(var _k=0;_k<interaction_count;_k++){
					_interaction = interaction[_j][_k];
					with(_interaction){
						//If Space Interaction is in a Toggle Group that can have only One Interaction Toggled
						if(toggle_group_enable){
							var _toggle_group
							_toggle_group = toggle_group;
				
							//Find Position of Self in Group List
							var _list_position;
							_list_position = ds_list_find_index(_toggle_group_list[_toggle_group],_interaction);
			
							//Remove Self from List
							ds_list_delete(_toggle_group_list[_toggle_group],_list_position);
						}
					}
				}
				
				#region Indicator Group Anchor
					if(user_indicator_anchor[_j] != noone){
						with(user_indicator_anchor[_j]){
							//Disappear
							transform_animate_from_current_shrink_and_fade();
								
							//State to Destroy
							ui_object_state_set(UIState.destroy);
						}
							
						user_indicator_anchor[_j] = noone;
					}
				#endregion
			}
		}
	}
}