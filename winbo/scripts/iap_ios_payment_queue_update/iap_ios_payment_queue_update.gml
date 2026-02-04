/// @function iap_ios_payment_queue_update
/// @summary Handle Apple's payment queue update events.
function iap_ios_payment_queue_update(){
	// Decode the returned JSON
	var _json = async_load[? "response_json"];
	if(_json != ""){
		iap_ios_process_purchases(_json);
	}
}