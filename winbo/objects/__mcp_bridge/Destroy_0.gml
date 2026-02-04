/// @description Clean up MCP bridge connection
if (global.__mcp_socket >= 0) {
    network_destroy(global.__mcp_socket);
    global.__mcp_socket = -1;
}
global.__mcp_enabled = false;
