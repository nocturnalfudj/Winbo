function text_password_string_update() {
	if(password_enable){
		var _string_length;
		_string_length = string_length(text_string);
		password_string = "";
		for(var _i=0;_i<_string_length;_i++){
			password_string += "*"
		}
	}
}