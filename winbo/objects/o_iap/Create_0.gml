//IAP Products
enum IAPProduct{
	product_0,
	
	SIZE
}

#region Android
	if(os_type == os_android){
		iap_enabled = false;

		product[IAPProduct.product_0]	= new GoogleProductData("product_0");

		current_tokens_list = ds_list_create();
		current_products_list = ds_list_create();

		// Attempt to connect to the store
		if (GPBilling_ConnectToStore() == gpb_error_unknown){
			sdm("ERROR - Billing API Has Not Connected!");
			alarm[0] = SECOND * 10;
		}
	}
#endregion

#region iOS
	if(os_type == os_ios){
		//IF USING IOS IAPS
		//NEED TO ADD AppleIncRootCertificate.cer TO INCLUDED FILES
		
		iap_enabled = ios_iap_IsAuthorisedForPayment();
		sdm("IOS IAP ENABLED: " + string(iap_enabled));

		product[IAPProduct.product_0]	= new IOSProductData("coin_100");
	
		purchase_token_to_validate = noone;

		if(iap_enabled){
			sdm("IOS IAP ADD PRODUCTS");
			for(var _i=0;_i<IAPProduct.SIZE;_i++){
				var _add_product_return;
				_add_product_return = ios_iap_AddProduct(product[_i].product_id);
				sdm("Add product return: " + string(_add_product_return));
			}
		
		    ios_iap_QueryProducts();
		}
	}
#endregion