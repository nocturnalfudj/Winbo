/// @description Google Store Connect
// Attempt to connect to the store
if (GPBilling_ConnectToStore() == gpb_error_unknown){
	sdm("ERROR - Billing API Has Not Connected!");
	alarm[0] = SECOND * 10;
}
