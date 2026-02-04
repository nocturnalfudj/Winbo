/// @function info_bar_system_update
/// @summary Update scaling and visibility for the info bar sections.
function info_bar_system_update(){
	if(info_bar_enable){
		//Scale Lerp to Target
		info_bar_scale = lerp_with_gap_close(info_bar_scale,info_bar_scale_target,0.25,0.1,false);
		
		for(var _i=0;_i<InfoBarSection.SIZE;_i++){
			if(info_bar_section_enable[_i]){
				info_bar_section_scale[_i] = lerp(info_bar_section_scale[_i],1,0.2);
			}
			else{
				info_bar_section_scale[_i] = lerp(info_bar_section_scale[_i],0,0.2);
			}
		}
	}
}