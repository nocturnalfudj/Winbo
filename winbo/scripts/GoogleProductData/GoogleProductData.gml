/// @function GoogleProductData
/// @summary Container for store product information returned from Google Play.
/// @param _purchase_id Transaction identifier assigned by the store.
/// @returns {struct} Product information struct.
/// @description
///   Populated after calling the Google Play billing API.
function GoogleProductData(_purchase_id) constructor{
	product_id	= noone;
	price		= 0;
	title		= "";
	description = "";
	
	purchase_id = _purchase_id;
}