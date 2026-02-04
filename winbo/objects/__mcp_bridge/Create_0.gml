/// @description Initialize MCP Bridge connection
// This object connects to the MCP bridge server for debugging/control

global.__mcp_socket = -1;
global.__mcp_enabled = false;
global.__mcp_buffer = "";
global.__mcp_port = 6502;

// Try to connect to MCP bridge server
var _socket = network_create_socket(network_socket_tcp);
var _result = network_connect_raw(_socket, "127.0.0.1", global.__mcp_port);

if (_result >= 0) {
    global.__mcp_socket = _socket;
    global.__mcp_enabled = true;
    __mcp_log("[MCP] Bridge connected on port " + string(global.__mcp_port));
} else {
    // No bridge server running - that's fine, game runs normally
    network_destroy(_socket);
    global.__mcp_socket = -1;
    global.__mcp_enabled = false;
}
