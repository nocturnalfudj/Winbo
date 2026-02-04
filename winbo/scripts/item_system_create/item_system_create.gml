function item_system_create(){
	//Details
	name = "ITEM NAME";
	sprite = noone;
	icon = noone;
	description = "ITEM DESCRIPTION";
	
	//Equip
	equip_enable = false;
	
	//Level
	level = 0;
	level_max = 3;
	level_reset_after_run = false;
	
	#region Unlock
		unlocked = true;
		
		//Stat Conditions
		unlock_conditions = ds_list_create();
		
		//TODO - Bring Stat System over from Robot Rampge
		//in Robot Rampage it is part of the Director, but should be its own Control object
		
		//var _condition;
		//_condition = new UnlockStatConditionData(Stat.level_beaten,StatScope.area,10,Area.caves);
		//ds_list_add(unlock_conditions,_condition);
		
		//_condition = new UnlockStatConditionData(Stat.kill_any,StatScope.level,10,Area.caves);
		//ds_list_add(unlock_conditions,_condition);
		
		//unlocked = unlock_stat_condition_check_all(unlock_conditions);
	#endregion
}