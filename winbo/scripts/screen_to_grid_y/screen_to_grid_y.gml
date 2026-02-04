/// @description Converts screen Y position to isometric grid Y position
/// @function screen_to_grid_y
/// @param _screen_x (real) The X position on the screen in pixels
/// @param _screen_y (real) The Y position on the screen in pixels
/// @param _tile_width (real) The width of each isometric tile in pixels
/// @param _tile_height (real) The height of each isometric tile in pixels
/// @returns (real) The grid Y position in the isometric grid

function screen_to_grid_y(_screen_x, _screen_y, _tile_width, _tile_height) {
    // Calculate half of the tile width and height
    var _tile_width_half;
    _tile_width_half = _tile_width / 2;

    var _tile_height_half;
    _tile_height_half = _tile_height / 2;

    // Calculate the grid Y position
    var _grid_y;
    _grid_y = ((_screen_y / _tile_height_half) - (_screen_x / _tile_width_half)) / 2;

    // Return the grid Y position
    return _grid_y;
}
