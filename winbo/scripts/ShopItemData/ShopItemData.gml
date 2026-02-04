/// @function ShopItemData
/// @summary Holds data for single-use shop items that don't persist between rooms.
/// @returns {struct} Item data struct.
/// @description
///   Items created through this struct integrate with the regular shop system
///   but are not saved when changing rooms.
function ShopItemData() constructor{
	//Level System
	item_system_create();
	
	//Create System
	shop_system_create();
}