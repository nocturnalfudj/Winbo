function txtPstr_winbo_lives_idle_main(){
	var _lives;
	_lives = 0;
	with(o_director){
		_lives = resource[Resource.winbo_lives][Team.player];
	}
	
	text_string = string(_lives);
}