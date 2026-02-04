/// @function shop_system_create
/// @summary Initialise the global shop system data.
/// @returns {void}
function shop_system_create(){
	//Shop enable
	shop_enable_run = false;
	shop_enable_base = false;
	
	//Cost
	for(var _i=0;_i<Resource.SIZE;_i++){
		cost[_i] = 0;
	}
	
	//Level Costs
	for(var _i=0;_i<=level_max;_i++){
		for(var _j=0;_j<Resource.SIZE;_j++){
			cost_level[_i][_j] = 0;
		}
	}
}