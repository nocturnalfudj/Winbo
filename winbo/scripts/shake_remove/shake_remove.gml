/// @function shake_remove
/// @summary Remove a shake by ID
/// @param _shake_id ID of shake to remove
function shake_remove(_shake_id) {
    for(var _i = 0; _i < shake_count; _i++) {
        if(shake_list[_i].shake_id == _shake_id) {
            // Remove from array
            array_delete(shake_list, _i, 1);
            shake_count--;
            return true;
        }
    }
    return false;
}