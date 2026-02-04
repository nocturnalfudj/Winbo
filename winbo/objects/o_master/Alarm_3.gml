/// @description Network Connection Check
global.network_connected = os_is_network_connected(true);
alarm[MasterAlarm.network_connection_check] = 10 * SECOND;