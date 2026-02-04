function txtPstr_cash_idle_main(){
	var _lives;
	_lives = 0;
	with(o_director){
		_lives = resource[Resource.cash][Team.player];
	}
	
	text_string = string(_lives);
}