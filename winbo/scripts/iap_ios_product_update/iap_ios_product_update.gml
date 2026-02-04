function iap_ios_product_update(){
	// Decode the returned JSON
	var _json = async_load[? "response_json"];
	var _map = json_decode(_json);
	var _products_list = _map[? "valid"];
	var _products_list_size = ds_list_size(_products_list);
	
	sdm("product update response: " + string(_json));
	
	// Loop through all valid products and store any data that you require
	for(var _i=0;_i<_products_list_size;++_i){
		var _product_map = _products_list[| _i];
		
		for(var _j=0;_j<IAPProduct.SIZE;_j++){
			if(product[_j].product_id == _product_map[? "productId"]){
				product[_j].price		= _product_map[? "price"];
				product[_j].description = _product_map[? "localizedDescription"];
				product[_j].title		= _product_map[? "localizedTitle"];
			}
		}
	}
	
	// Parse any invalid responses here if required
	ds_map_destroy(_map);
	
	var _json = ios_iap_QueryPurchases();
	if(_json != ""){
		iap_ios_process_purchases(_json);
	}
}