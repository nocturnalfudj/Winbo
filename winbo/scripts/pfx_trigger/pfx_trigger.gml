/// @function pfx_trigger
/// @summary Activate a particle effect burst.
/// @param pfx Index of the effect to trigger.
function pfx_trigger(_pfx) {
	if(_pfx < pfx_num)
		pfx[_pfx][PFXProperty.burst_active] = true;
}