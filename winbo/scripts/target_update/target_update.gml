function target_update(_target_type){
	var _target_data;
	_target_data = target[_target_type];
	
	var _target_exists;
	_target_exists = false;
	
	with(_target_data){
		var _target_x,_target_y;
		switch(type){
			case Target.object:
				if(instance_exists(object)){
					//Locate Nearest Move Target
					var _x,_y;
					_x = other.x;
					_y = other.y;
					var _nearest_instance,_nearest_instance_distance,_instance_distance;
					_nearest_instance = noone;
					_nearest_instance_distance = infinity;
					with(object){
						//Do Not Consider Instance if Cannot Be Targeted
						if(target_can_be_targeted[_target_type] == false){
							continue;
						}
						
						//Get Distance to Instance
						_instance_distance = point_distance(_x,_y,x,y);
						
						//If Closer than Previous Instances
						if(_instance_distance <= _nearest_instance_distance){
							//Update Nearest Instance
							_nearest_instance_distance = _instance_distance;
							_nearest_instance = id;
							
							//Update Target Coords
							_target_x = x;
							_target_y = y;
						}						
					}
					
					//Found a Target Instance (possible to not find one if instances of object exist, but none can be targeted)
					if(_nearest_instance != noone){
						//Update Target Values
						x = _target_x;
						y = _target_y;
						distance = _nearest_instance_distance;
						direction = point_direction(other.x,other.y,_target_x,_target_y);
						instance = _nearest_instance;
							
						//Move Target DOES Exist
						_target_exists = true;
					}
				}
				else{
					instance = noone;
				}
			break;
				
			case Target.instance:
				if(instance_exists(instance)){
					with(instance){
						_target_x = x;
						_target_y = y;
						
						//Do Not Consider Instance if Cannot Be Targeted
						if(target_can_be_targeted[_target_type] == false){
							other.instance = noone;
						}
					}
					
					if(instance != noone){
						x = _target_x;
						y = _target_y;
						direction = point_direction(other.x,other.y,_target_x,_target_y);
						distance = point_distance(other.x,other.y,_target_x,_target_y);
							
						//Move Target DOES Exist
						_target_exists = true;
					}
				}
				else{
					instance = noone;
				}
			break;
				
			case Target.position:
				_target_x = x;
				_target_y = y;
				direction = point_direction(other.x,other.y,_target_x,_target_y);
				distance = point_distance(other.x,other.y,_target_x,_target_y);
							
				//Move Target DOES Exist
				_target_exists = true;
			break;
		}
	}
	
	//Return Target Exists
	return _target_exists;
}