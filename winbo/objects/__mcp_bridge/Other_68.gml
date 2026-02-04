/// @description Handle network events from MCP bridge
var _type = async_load[? "type"];
var _sock = async_load[? "id"];

// Only process our socket
if (_sock != global.__mcp_socket) exit;

switch (_type) {
    case network_type_data:
        // Received data from bridge
        var _buffer = async_load[? "buffer"];
        var _size = async_load[? "size"];

        if (_size > 0) {
            var _data = buffer_read(_buffer, buffer_string);
            global.__mcp_buffer += _data;

            // Process complete lines
            while (string_pos(chr(10), global.__mcp_buffer) > 0) {
                var _newline_pos = string_pos(chr(10), global.__mcp_buffer);
                var _line = string_copy(global.__mcp_buffer, 1, _newline_pos - 1);
                global.__mcp_buffer = string_delete(global.__mcp_buffer, 1, _newline_pos);

                // Process command line
                if (string_pos("CMD:", _line) == 1) {
                    var _content = string_delete(_line, 1, 4);
                    var _pipe_pos = string_pos("|", _content);
                    if (_pipe_pos > 0) {
                        var _cmd_id = string_copy(_content, 1, _pipe_pos - 1);
                        var _command = string_delete(_content, 1, _pipe_pos);

                        // Execute command
                        var _result = __mcp_execute_command(_command);
                        __mcp_send_response(_cmd_id, _result);
                    }
                }
            }
        }
        break;

    case network_type_disconnect:
        // Bridge disconnected
        __mcp_log("[MCP] Bridge disconnected");
        global.__mcp_enabled = false;
        global.__mcp_socket = -1;
        break;
}

/// @function __mcp_execute_command(command)
/// @description Execute a command from MCP and return result
function __mcp_execute_command(_command) {
    // Parse command (space-separated)
    var _parts = [];
    var _temp = _command;
    while (string_length(_temp) > 0) {
        var _space = string_pos(" ", _temp);
        if (_space > 0) {
            array_push(_parts, string_copy(_temp, 1, _space - 1));
            _temp = string_delete(_temp, 1, _space);
        } else {
            array_push(_parts, _temp);
            _temp = "";
        }
    }

    if (array_length(_parts) == 0) return "ERROR:Empty command";

    var _action = _parts[0];

    switch (_action) {
        case "ping":
            return "pong";

        case "goto_room":
            if (array_length(_parts) > 1) {
                var _room = asset_get_index(_parts[1]);
                if (_room >= 0 && room_exists(_room)) {
                    room_goto(_room);
                    return "OK:Changed to " + _parts[1];
                }
                return "ERROR:Room not found: " + _parts[1];
            }
            return "ERROR:Missing room name";

        case "level_start":
            // Use the game's proper level select system
            if (array_length(_parts) > 1) {
                var _level_id = _parts[1];
                if (level_select_start(_level_id)) {
                    return "OK:Started level " + _level_id;
                }
                return "ERROR:Failed to start level " + _level_id + " (check if unlocked)";
            }
            return "ERROR:Usage: level_start <level_id>";

        case "level_unlock":
            // Unlock a level for testing
            if (array_length(_parts) > 1) {
                var _level_id = _parts[1];
                level_select_unlock(_level_id);
                return "OK:Unlocked level " + _level_id;
            }
            return "ERROR:Usage: level_unlock <level_id>";

        case "get_var":
            if (array_length(_parts) > 1) {
                var _var_name = _parts[1];
                // Check if it starts with "global."
                if (string_pos("global.", _var_name) == 1) {
                    var _real_name = string_delete(_var_name, 1, 7);
                    if (variable_global_exists(_real_name)) {
                        return "OK:" + string(variable_global_get(_real_name));
                    }
                    return "ERROR:Global variable not found: " + _real_name;
                }
                return "ERROR:Only global variables supported";
            }
            return "ERROR:Missing variable name";

        case "set_var":
            if (array_length(_parts) > 2) {
                var _var_name = _parts[1];
                var _value = _parts[2];
                if (string_pos("global.", _var_name) == 1) {
                    var _real_name = string_delete(_var_name, 1, 7);
                    // Try to convert to real if it looks like a number
                    var _real_value = real(_value);
                    if (string(_real_value) == _value) {
                        variable_global_set(_real_name, _real_value);
                    } else {
                        variable_global_set(_real_name, _value);
                    }
                    return "OK:Set " + _var_name;
                }
                return "ERROR:Only global variables supported";
            }
            return "ERROR:Missing variable name or value";

        case "spawn":
            if (array_length(_parts) > 3) {
                var _obj = asset_get_index(_parts[1]);
                var _x = real(_parts[2]);
                var _y = real(_parts[3]);
                if (_obj >= 0 && object_exists(_obj)) {
                    var _inst = instance_create_depth(_x, _y, 0, _obj);
                    return "OK:Created " + _parts[1] + " at " + string(_x) + "," + string(_y);
                }
                return "ERROR:Object not found: " + _parts[1];
            }
            return "ERROR:Usage: spawn <object> <x> <y>";

        case "room_info":
            return "OK:" + room_get_name(room) + " (" + string(room_width) + "x" + string(room_height) + ")";

        case "instance_count":
            if (array_length(_parts) > 1) {
                var _obj = asset_get_index(_parts[1]);
                if (_obj >= 0) {
                    return "OK:" + string(instance_number(_obj));
                }
                return "ERROR:Object not found";
            }
            return "OK:" + string(instance_count);

        default:
            return "ERROR:Unknown command: " + _action;
    }
}
