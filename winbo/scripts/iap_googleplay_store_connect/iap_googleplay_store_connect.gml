/// @function iap_googleplay_store_connect
/// @summary Start the Google Play billing connection and query products.
/// @returns {void}
function iap_googleplay_store_connect(){
	//Start with IAP Disabled
	iap_enabled = false;
		
	//Add Products
	for(var _i=0;_i<IAPProduct.SIZE;_i++){
		GPBilling_AddProduct(product[_i].purchase_id);
	}
		
	//Query Products
	GPBilling_QueryProducts();
}