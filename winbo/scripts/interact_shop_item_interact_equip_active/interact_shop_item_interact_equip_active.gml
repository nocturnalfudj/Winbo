/// @function interact_shop_item_interact_equip_active
/// @summary Equip the shop item for a user if an equip script exists.
/// @param _user_id ID of the user performing the equip.
/// @returns {boolean} True if equipped successfully.
function interact_shop_item_interact_equip_active(_user_id){
	//Run Equip Script
	if(equip_script != noone){
		script_execute(equip_script,_user_id);
		
		//Successful Equip
		return true;
	}
	else{
		//Failed Equip
		return false;
	}
}