//Do Not Run this Event if in Boot Room
//as the layers do not exist
if(room == r_boot)
	exit;

//Move to Console Layer
layer = layer_get_id("lyr_console");

//Move Textfield to Correct Layer if Enabled
if(CONSOLE_TXTFLD_ENABLE){
	with(text_field_id){
		layer = layer_get_id("lyr_console_text_field");
	}
}