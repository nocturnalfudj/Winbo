/// @function tab_create
/// @summary Instantiate and display a new UI tab.
/// @param _tab Struct describing the tab to create.
/// @param _direction Direction (-1 or 1) for slide-in animation.
/// @param _time_current Initial animation timer value.
function tab_create(_tab,_direction,_time_current){
	//Default Direction Left
	if(_direction == undefined)
		_direction = -1;
		
	_time_current ??= 0;
	
	//Get Tab Data
	var _new_tab_instance,_new_tab_object,_new_tab_layer,_new_tab_group,_new_tab_position;
	with(_tab){
		_new_tab_object = object;
		_new_tab_layer = layer;
		_new_tab_group = tab_group;
		_new_tab_position = position;
	}
	
	//Update Current Tab in UI Control for Tab's Tab Group
	with(o_ui){
		tab_current[_new_tab_group] = _new_tab_position;
	}
	
	//If Tab Instance Already Exists Use That
	if(instance_number(_new_tab_object) > 0){
		_new_tab_instance = _new_tab_object;
	}
	//Otherwise Create a New One
	else{
		_new_tab_instance = instance_create_layer(0,0,_new_tab_layer,_new_tab_object);
	}
	
	//Animate Tab Instance Entrance
	with(_new_tab_instance){
		tab = _tab;
		script_execute(tab.entrance_script,_direction,_time_current);
		
		//Transform Update
		transform_system_update();
		
		//Transform Update
		with(scroll){
			transform_system_update();
		}
	}
}