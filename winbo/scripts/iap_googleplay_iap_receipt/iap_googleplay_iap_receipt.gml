/// @function iap_googleplay_iap_receipt
/// @summary Parse a Google Play purchase receipt.
/// @returns {void}
function iap_googleplay_iap_receipt(){
	//Retrieve the JSON object response string
	var _json,_map;
	_json = async_load[? "response_json"];
	_map = json_decode(_json);
		
	// Check if the query was successful
	if(_map[? "success"] == true){
		// Check the purchases key for any outstanding product purchases
		if(ds_map_exists(_map, "purchases")){
			var _puchases_list,_purchases_list_size;
			_puchases_list = _map[? "purchases"];
			_purchases_list_size = ds_list_size(_puchases_list);
				
			var _purchases_purchase_map,_purchase_id,_purchase_token,_purchase_add,_purchase_signature,_purchase_json_original;
				
			// Loop through the purchases list and parse each
			// entry to get the purchase data DS map
			for (var _i=0;_i<_purchases_list_size;++_i;){
				//Get Map for Specific Purchase in Purchases List
				_purchases_purchase_map = _puchases_list[| _i];
				_purchase_token = _purchases_purchase_map[? "purchaseToken"];
				_purchase_signature = GPBilling_Purchase_GetSignature(_purchase_token);
				_purchase_json_original = GPBilling_Purchase_GetOriginalJson(_purchase_token);
					
				// Verify the purchase before consuming or acknowledging it
				if(GPBilling_Purchase_VerifySignature(_purchase_json_original, _purchase_signature)){
					GPBilling_ConsumeProduct(_purchase_token);
						
					ds_list_add(current_tokens_list, _purchase_token);
					ds_list_add(current_products_list, _purchases_purchase_map[? "productId"]);
				}
			}
		}
	}
		
	ds_map_destroy(_map);
}