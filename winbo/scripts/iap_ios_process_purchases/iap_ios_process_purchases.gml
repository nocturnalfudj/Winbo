function iap_ios_process_purchases(_json){
	var _map = json_decode(_json);
	var _purchases_list = _map[? "purchases"];
	var _purchases_list_size = ds_list_size(_purchases_list);
	
	// loop through purchases
	for(var _i=0;_i<_purchases_list_size;++_i;){
		var _purchase_map = _purchases_list[| _i];
		var _purchase_token = _purchase_map[? "purchaseToken"];
	
		// Check purchases
		if(_purchase_map[? "purchaseState"] != ios_purchase_failed){
			var _receipt = ios_iap_GetReceipt();
	
			//Validate, award the product, and finalise
			if(ios_iap_ValidateReceipt() == true){
				for(var _j=0;_j<IAPProduct.SIZE;_j++){
					if(product[_j].product_id == _purchase_map[? "productId"]){
						switch(_j){
							case IAPProduct.product_0:
								//ACTIVATE PRODUCT IN GAME
							break;
						}
					}
				}
			}
			else{
				// Validation failed, so deal with it here
				//ios_iap_RefreshReceipt();
				
				//purchase_token_to_validate = _purchase_token;
				
				// You will still need to finalise the transaction with
				//ios_iap_FinishTransaction(_purchase_token);
				
				//break;
			}
		}
		else{
			// Purchase failed, so deal with it here
			// You will still need to finalise the transaction
		}
		ios_iap_FinishTransaction(_purchase_token);
		ds_map_destroy(_purchase_map);
	}
	ds_map_destroy(_map);
}