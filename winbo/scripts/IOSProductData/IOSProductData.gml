/// @function IOSProductData
/// @summary Structure representing a purchasable item on iOS.
/// @param _product_id Product ID string from the App Store.
/// @returns {struct} Product information struct.
/// @description
///   Filled when requesting product info through the iOS store API.
function IOSProductData(_product_id) constructor{
	product_id	= _product_id;
	price		= 0;
	title		= "";
	description = "";
}