#region Depth Grid
	//Reset Step Opperational Arrays
	for(var _i=0;_i<DepthObjectLayer.SIZE;_i++){
		depth_object_layer_instance_count[_i] = 0;
		depth_grid_row[_i] = 0;
	}
	
	var _depth_object_layer_instance_count;
	_depth_object_layer_instance_count = depth_object_layer_instance_count;
	with(o_depth_object){
		//Ignore if Not Visible to Camera
		if(!camera_visible)
			continue;
		
		_depth_object_layer_instance_count[@ depth_object_layer]++;
	}
	
	
	for(var _i=0;_i<DepthObjectLayer.SIZE;_i++){
		if(depth_object_layer_instance_count[_i] != depth_grid_height[_i]){
			depth_grid_height[_i] = depth_object_layer_instance_count[_i];
			ds_grid_resize(depth_grid[_i],2,depth_grid_height[_i]);
		}
	}
	
	var _grid,_grid_row;
	_grid = depth_grid;
	_grid_row = depth_grid_row;
	with(o_depth_object){
		//Ignore if Not Visible to Camera
		if(!camera_visible)
			continue;
			
		_grid[@ depth_object_layer][# DepthGrid.instance,_grid_row[depth_object_layer]] = id;
		_grid[@ depth_object_layer][# DepthGrid.y,_grid_row[depth_object_layer]] = y;
		_grid_row[@ depth_object_layer]++;
	}
	
	for(var _i=0;_i<DepthObjectLayer.SIZE;_i++){
		ds_grid_sort(depth_grid[_i],DepthGrid.y,true);
	}
#endregion