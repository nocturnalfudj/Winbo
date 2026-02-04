/// @description Converts screen X position to isometric grid X position
/// @function screen_to_grid_x
/// @param _screen_x (real) The X position on the screen in pixels
/// @param _screen_y (real) The Y position on the screen in pixels
/// @param _tile_width (real) The width of each isometric tile in pixels
/// @param _tile_height (real) The height of each isometric tile in pixels
/// @returns (real) The grid X position in the isometric grid

function screen_to_grid_x(_screen_x, _screen_y, _tile_width, _tile_height) {
    // Calculate half of the tile width and height
    var _tile_width_half;
    _tile_width_half = _tile_width / 2;

    var _tile_height_half;
    _tile_height_half = _tile_height / 2;

    // Calculate the grid X position
    var _grid_x;
    _grid_x = ((_screen_x / _tile_width_half) + (_screen_y / _tile_height_half)) / 2;

    // Return the grid X position
    return _grid_x;
}
