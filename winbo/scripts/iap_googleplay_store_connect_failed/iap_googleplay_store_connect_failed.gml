/// @function iap_googleplay_store_connect_failed
/// @summary Retry connecting to the Google Play store after a failure.
/// @returns {void} No return value.
function iap_googleplay_store_connect_failed(){
	// Store has failed to connect, so try again in 10s
	alarm[0] = SECOND * 10;
}