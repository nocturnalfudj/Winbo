function iap_googleplay_product_data_response(){
	//Retrieve the JSON object response string
	var _json,_map;
	_json = async_load[? "response_json"];
	_map = json_decode(_json);
		
	// Check if the query was successful
	if(_map[? "success"] == true){
		// Get the DS list of products and loop through them
		var _product_list,_product_list_size;
		_product_list = _map[? "skuDetails"];
		_product_list_size = ds_list_size(_product_list);
			
		var _product_map;
		for(var _i=0;_i<_product_list_size;++_i;){
			// The skuDetails key contains a DS list where
			// each list entry corresponds to a single
			// product in DS map form. This DS map can be parsed
			// to extract details like title, description and
			// price, as shown in the example, below:
			_product_map = _product_list[| _i];
				
			for(var _j=0;_j<IAPProduct.SIZE;_j++){
				if(_product_map[? "productId"] == product[_j].purchase_id){
					product[_j].product_id	= _product_map[? "productId"];
					product[_j].price		= _product_map[? "price"];
					product[_j].title		= _product_map[? "title"];
					product[_j].description = _product_map[? "decription"];
				}
			}
		}

		// Query purchase data
		var _purchase_json,_purchase_map;
		_purchase_json = GPBilling_QueryPurchases(gpb_purchase_skutype_inapp);
		_purchase_map = json_decode(_purchase_json);
			
		//If Getting Purchase Map was Successful
	    if(_purchase_map[? "success"] == true){
			var _puchases_list,_purchases_list_size;
			_puchases_list = _purchase_map[? "purchases"];
			_purchases_list_size = ds_list_size(_puchases_list);
				
			var _purchases_purchase_map,_purchase_id,_purchase_token,_purchase_add;
				
			//Loop Through All Purchases
			for (var _i=0;_i<_purchases_list_size;++_i;){
				//Get Map for Specific Purchase in Purchases List
				_purchases_purchase_map = _puchases_list[| _i];
				if(_purchases_purchase_map[? "purchaseState"] == 0){
					// Purchase has been made, so now get the product ID
					// and unique "token" string to identify the purchase
					_purchase_id = _purchases_purchase_map[? "productId"];
					_purchase_token = _purchases_purchase_map[? "purchaseToken"];
					_purchase_add = false;
						
					// Check against existing purchase IDs
					for(var _j=0;_j<IAPProduct.SIZE;_j++){
						if(_purchase_id == product[_j].purchase_id){
							// It's a consumable purchase that hasn't been used yet
							// so call the consume function on it:
							GPBilling_ConsumeProduct(_purchase_token);
							_purchase_add = true;
						}
					}
						
					//Add all purchase IDs and tokens into the relevant
					//DS lists so they can be confirmed later
					if(_purchase_add){
						ds_list_add(current_tokens_list, _purchase_token);
						ds_list_add(current_products_list, _purchase_id);
					}
				}
			}
		}
	    ds_map_destroy(_purchase_map);
		iap_enabled = true;
	}
	ds_map_destroy(_map);
}