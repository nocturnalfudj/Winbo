function txtPstr_lucky_coin_destroy_main(){
	//Flash
	if(flash_alpha > 0.01){
		flash_alpha = lerp(flash_alpha,0,0.2);
	}
	else{
		flash_alpha = 0;
	}
	
	//Default UI
	ui_object_state_destroy_main();
}