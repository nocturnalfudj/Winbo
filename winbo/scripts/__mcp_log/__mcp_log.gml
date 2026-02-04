/// @function __mcp_log(message)
/// @description Log a message to both debug output and MCP bridge
/// @param {string} message The message to log
function __mcp_log(_message) {
    var _timestamp = string(current_time);
    var _full_msg = "[" + _timestamp + "] " + string(_message);
    
    // Always log to standard debug output
    show_debug_message(_full_msg);
    
    // Send to MCP bridge if connected
    if (variable_global_exists("__mcp_socket") && global.__mcp_socket >= 0) {
        var _packet = "LOG:" + _timestamp + "|" + string(_message) + chr(10);
        var _buffer = buffer_create(string_byte_length(_packet) + 1, buffer_fixed, 1);
        buffer_write(_buffer, buffer_string, _packet);
        network_send_raw(global.__mcp_socket, _buffer, buffer_tell(_buffer));
        buffer_delete(_buffer);
    }
}

/// @function __mcp_send_response(cmd_id, result)
/// @description Send a command response to MCP bridge
/// @param {string} cmd_id The command ID to respond to
/// @param {string} result The result string
function __mcp_send_response(_cmd_id, _result) {
    if (variable_global_exists("__mcp_socket") && global.__mcp_socket >= 0) {
        var _packet = "RSP:" + string(_cmd_id) + "|" + string(_result) + chr(10);
        var _buffer = buffer_create(string_byte_length(_packet) + 1, buffer_fixed, 1);
        buffer_write(_buffer, buffer_string, _packet);
        network_send_raw(global.__mcp_socket, _buffer, buffer_tell(_buffer));
        buffer_delete(_buffer);
    }
}
