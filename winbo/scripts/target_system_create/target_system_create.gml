/// @function target_system_create
/// @summary Initialize the data used by a target acquisition system.
function target_system_create(){
	//Targets
	target[TargetType.move] = new TargetData();
	target[TargetType.attack] = new TargetData();
	
	//Can Be Targeted by Other Target Systems
	target_can_be_targeted[TargetType.move] = true;
	target_can_be_targeted[TargetType.attack] = true;
}

enum TargetType{
	move,
	attack,
	
	SIZE
}