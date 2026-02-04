/// @function grid_to_screen_y
/// @summary Convert an isometric grid Y coordinate to screen space.
/// @param _grid_x X position in the isometric grid.
/// @param _grid_y Y position in the isometric grid.
/// @param _tile_height Height of each isometric tile in pixels.
/// @returns {real} The screen Y position in pixels.

function grid_to_screen_y(_grid_x, _grid_y, _tile_height) {
    // Calculate the sum of grid X and grid Y positions
    var _x_y_sum;
    _x_y_sum = _grid_x + _grid_y;

    // Calculate half of the tile height
    var _half_tile_height;
    _half_tile_height = _tile_height * 0.5;

    // Calculate the screen Y position
    var _screen_y;
    _screen_y = _x_y_sum * _half_tile_height;

    // Return the screen Y position
    return _screen_y;
}
