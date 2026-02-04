/// @function shop_system_shop_object_cost_can_afford_update
/// @summary Update item cost displays and affordability flags for each team.
function shop_system_shop_object_cost_can_afford_update(){
	var _resource,_resource_cost
	
	var _shop_item_cost,_shop_cost_factor;
	
	var _can_afford_all;
	
	var _resource_array;
	_resource_array = o_director.resource;
	
	//By Default Each Team Can Afford
	for(var _i=0;_i<Team.npc;_i++){
		cost_can_afford_all[_i] = true;
	}
	
	for(var _i=0;_i<Resource.SIZE;_i++){
		_shop_item_cost = shop_item_data.cost[_i];
		_shop_cost_factor = shop_cost_factor[_i];
		
		//Update Cost Title String
		if(free){
			cost_title_string[_i] = "FREE";
		}
		else{
			cost_title_string[_i] = number_with_commas(_shop_item_cost * _shop_cost_factor,2,true);
		}
		
		for(var _j=0;_j<Team.npc;_j++){
			_can_afford_all = true;
			
			_resource = _resource_array[@ _i][@ _j];
			if(free)
				_resource_cost = 0;
			else
				_resource_cost = _shop_item_cost * _shop_cost_factor;
			
			cost_can_afford[_i][_j] = (_resource >= _resource_cost);
			
			if(!cost_can_afford[_i][_j])
				cost_can_afford_all[_j] = false;
		}
	}
}