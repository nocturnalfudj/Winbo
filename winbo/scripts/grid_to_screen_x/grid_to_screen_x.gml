/// @description Converts isometric grid X position to screen X position
/// @function grid_to_screen_x
/// @param _grid_x (real) The X position in the isometric grid
/// @param _grid_y (real) The Y position in the isometric grid
/// @param _tile_width (real) The width of each isometric tile in pixels
/// @returns (real) The screen X position in pixels

function grid_to_screen_x(_grid_x, _grid_y, _tile_width) {
    // Calculate the difference between grid X and grid Y positions
    var _x_y_difference;
    _x_y_difference = _grid_x - _grid_y;

    // Calculate half of the tile width
    var _half_tile_width;
    _half_tile_width = _tile_width * 0.5;

    // Calculate the screen X position
    var _screen_x;
    _screen_x = _x_y_difference * _half_tile_width;

    // Return the screen X position
    return _screen_x;
}
