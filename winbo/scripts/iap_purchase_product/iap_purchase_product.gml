/// @function iap_purchase_product
/// @summary Initiate a purchase for the specified product.
function iap_purchase_product(_product){
	if(os_type == os_android){
		with(o_iap){
			//PURCHASE
			if(GPBilling_IsStoreConnected() && iap_enabled){
				var _purchase_result = GPBilling_PurchaseProduct(product[_product].purchase_id);
				if(_purchase_result != gpb_no_error){
					// Purchase unavailable, add failsafe code if required
				}
			}
		}
	}
	else if(os_type == os_ios){
		with(o_iap){
			//PURCHASE
			if(iap_enabled){
				var _purchase_return;
				_purchase_return = ios_iap_PurchaseProduct(product[_product].product_id);
				sdm("purchase return - " + string(_purchase_return));
			}
		}
	}
}