///@param language
function text_language_set(_language) {
	var _language_column;
	_language_column = -1;
	
	with(o_text){
		if(language_current != _language){
			for(var _i=0;_i<TextGroup.SIZE;_i++){
				_language_column = text_language_column_get(_i,_language);
				if(_language_column!=-1){
					language_new = _language;
					language_swap = true;
					break;
				}
			}
		}
	}
	
	return _language_column;
}