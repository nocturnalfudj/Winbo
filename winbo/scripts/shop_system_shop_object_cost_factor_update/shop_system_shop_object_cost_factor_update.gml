function shop_system_shop_object_cost_factor_update(){
	//Default to 1x Factor
	var _factor
	_factor = 1;
			
	//Apply Shop Sale Discount IF Active
	if(o_director.shop_sale_active){
		_factor *= (1 - SHOP_SALE_DISCOUNT);
	}
			
	for(var _i=0;_i<Resource.SIZE;_i++){
		shop_cost_factor[_i] = _factor * shop_cost_factor_instance[_i];
	}
}