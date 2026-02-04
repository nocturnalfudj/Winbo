/// @function title_system_update
/// @summary Update on-screen title and subtitle text every step.
/// @returns {void}
function title_system_update(){
	//Title
	if(title_enable)
		title_string = text_update_string(title_string,title_text);
			
	//Subitle
	if(subtitle_enable)
		subtitle_string = text_update_string(subtitle_string,subtitle_text);
}