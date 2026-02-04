/// @function iap_googleplay_product_consume_response
/// @summary Handle async consume response from Google Play billing.
function iap_googleplay_product_consume_response(){
	// Get the JSON object response string
	var _json = async_load[? "response_json"];
	var _map = json_decode(_json);
	var _num = -1;
		
	// Get the purchase token for the product that has been purchased
	if(ds_map_exists(_map, "purchaseToken")){
		// compare the response purchase token against the list
		// of purchase token requests
		for (var _i= 0;_i<ds_list_size(current_tokens_list);++_i;){
				
			// the response matches a token in the purchase check list
			if(_map[? "purchaseToken"] == current_tokens_list[| _i]){
				//Assign a reward according to the product being purchased
				switch(current_products_list[| _i]){
					case product[IAPProduct.product_0].purchase_id:
						//ACTIVATE PRODUCT IN GAME
						_num = _i;
					break;
				}
					
				if(_num != -1)
					break;
			}
		}
		// Remove the purchased product and its purchase token
		// from the appropriate check lists
		if(_num > -1){
			ds_list_delete(current_products_list, _num);
			ds_list_delete(current_tokens_list, _num);
		}
	}
	else{
		// Parse the error response codes here
		// and react appropriately
	}
		
	ds_map_destroy(_map);
}