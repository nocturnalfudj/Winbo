/// @function status_effect_trigger_custom_activate
/// @summary Manually start a custom status effect trigger.
/// @param _status_effect_id Status effect identifier.
/// @returns {void}
function status_effect_trigger_custom_activate(_status_effect_id){
	status_effect_trigger_custom[_status_effect_id] = true;
}