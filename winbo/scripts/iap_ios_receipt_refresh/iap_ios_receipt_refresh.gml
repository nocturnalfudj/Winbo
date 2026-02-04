function iap_ios_receipt_refresh(){
	//Get Status
	var _refresh_status;
	_refresh_status = async_load[? "status"];
	
	//Handle Different Status
	switch(_refresh_status){
		case ios_receipt_refresh_success:
			ios_iap_GetReceipt();
			
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
				
				ios_iap_FinishTransaction(purchase_token_to_validate);
				
				purchase_token_to_validate = noone;
			}
		break;
		
		case ios_receipt_refresh_failure:
			
		break;
	}
}