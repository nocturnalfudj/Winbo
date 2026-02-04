/// @function director_room_path_finding_grid_setup
/// @summary Build the pathfinding grid for the current room.
function director_room_path_finding_grid_setup(){
	var _cells_horizontal,_cells_vertical;
	_cells_horizontal = ceil(room_width/CELL_WIDTH) + 1;
	_cells_vertical = ceil(room_height/CELL_HEIGHT);
	global.path_finding_grid = mp_grid_create(-CELL_WIDTH,-CELL_HEIGHT,_cells_horizontal,_cells_vertical,CELL_WIDTH,CELL_HEIGHT);
	mp_grid_add_instances(global.path_finding_grid,o_solid,false);
}