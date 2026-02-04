//Get Event ID
var _event_id = async_load[? "id"];

sdm("IAP Response Event ID: " + string(_event_id));

//Handle Different Event IDs
switch (_event_id){
	#region Google
		case gpb_store_connect:
			sdm("IAP Response Store Connect");
			iap_googleplay_store_connect();
		break;
	
		case gpb_store_connect_failed:
			sdm("IAP Response Store Connect Failed");	
			iap_googleplay_store_connect_failed();
		break;
	
		case gpb_product_data_response:
			sdm("IAP Response Product Data Response");
			iap_googleplay_product_data_response();
	    break;
	
		case gpb_iap_receipt:
			sdm("IAP Response IAP Receipt");
			iap_googleplay_iap_receipt();
	    break;
	
		case gpb_product_consume_response:
			sdm("IAP Response Consume Response");
			iap_googleplay_product_consume_response();
		break;
	#endregion
	
	#region iOS
		case ios_product_update:
			sdm("IAP Response Product Update");
			iap_ios_product_update();
		break;
	
		case ios_payment_queue_update:
			sdm("IAP Response Payment Queue Update");
			iap_ios_payment_queue_update();
		break;
	
		case ios_receipt_refresh:
			sdm("IAP Response Receipt Refresh");
			iap_ios_receipt_refresh();
		break;
	#endregion
}