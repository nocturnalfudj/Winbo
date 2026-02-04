function input_kb_codes() {
	//Create List
	global.keyboard_keycode_list = ds_list_create();

	//Initialise all keycodes to Undefined
	var _list,_keyboard_keycode_list_num;
	_list = global.keyboard_keycode_list;
	_keyboard_keycode_list_num = 523;

	for(var _i=0;_i<_keyboard_keycode_list_num;_i++){
		_list[| _i] = "Undefined";
	}

	// In GM, the controls are set to the keyboard keys and NOT
	// every possible character. Below is the list of all the possible
	// keycodes usually used with the built-in GM variable vk_ or ord()...
	// Some characters, depending on your language, may vary. Simply
	// modify the string in the table below to your needs. Default keyboard
	// layout used is "English - US".

	// Set known characters
	#region Fill List
		_list[| 8] = "Backspace";
		_list[| 9] = "Tab";
		_list[| 12] = "Numpad 5 (nmlk of";
		_list[| 13] = "Enter";
		_list[| 16] = "Shift";
		_list[| 19] = "Pause";
		_list[| 20] = "Caps lock";
		_list[| 27] = "Escape";
		_list[| 32] = "Space";
		_list[| 33] = "Page up";
		_list[| 34] = "Page down";
		_list[| 35] = "End";
		_list[| 36] = "Home";
		_list[| 37] = "Left";
		_list[| 38] = "Up";
		_list[| 39] = "Right";
		_list[| 40] = "Down";
		_list[| 45] = "Insert";
		_list[| 46] = "Delete";
		_list[| 48] = "0";
		_list[| 49] = "1";
		_list[| 50] = "2";
		_list[| 51] = "3";
		_list[| 52] = "4";
		_list[| 53] = "5";
		_list[| 54] = "6";
		_list[| 55] = "7";
		_list[| 56] = "8";
		_list[| 57] = "9";
		_list[| 65] = "A";
		_list[| 66] = "B";
		_list[| 67] = "C";
		_list[| 68] = "D";
		_list[| 69] = "E";
		_list[| 70] = "F";
		_list[| 71] = "G";
		_list[| 72] = "H";
		_list[| 73] = "I";
		_list[| 74] = "J";
		_list[| 75] = "K";
		_list[| 76] = "L";
		_list[| 77] = "M";
		_list[| 78] = "N";
		_list[| 79] = "O";
		_list[| 80] = "P";
		_list[| 81] = "Q";
		_list[| 82] = "R";
		_list[| 83] = "S";
		_list[| 84] = "T";
		_list[| 85] = "U";
		_list[| 86] = "V";
		_list[| 87] = "W";
		_list[| 88] = "X";
		_list[| 89] = "Y";
		_list[| 90] = "Z";
		_list[| 91] = "Windows";
		_list[| 96] = "Numpad 0";
		_list[| 97] = "Numpad 1";
		_list[| 98] = "Numpad 2";
		_list[| 99] = "Numpad 3";
		_list[| 100] = "Numpad 4";
		_list[| 101] = "Numpad 5";
		_list[| 102] = "Numpad 6";
		_list[| 103] = "Numpad 7";
		_list[| 104] = "Numpad 8";
		_list[| 105] = "Numpad 9";
		_list[| 106] = "Numpad *";
		_list[| 107] = "Numpad +";
		_list[| 109] = "Numpad -";
		_list[| 110] = "Numpad .";
		_list[| 111] = "Numpad /";
		_list[| 112] = "F1";
		_list[| 113] = "F2";
		_list[| 114] = "F3";
		_list[| 115] = "F4";
		_list[| 116] = "F5";
		_list[| 117] = "F6";
		_list[| 118] = "F7";
		_list[| 119] = "F8";
		_list[| 120] = "F9";
		_list[| 121] = "F10";
		_list[| 122] = "F11";
		_list[| 123] = "F12";
		_list[| 144] = "Num lock";
		_list[| 145] = "Scroll lock";
		_list[| 160] = "Shift (left)";
		_list[| 161] = "Shift (right)";
		_list[| 162] = "Ctrl (left)";
		_list[| 163] = "Ctrl (right)";
		_list[| 164] = "Alt (left)";
		_list[| 165] = "Alt (right)";
		_list[| 186] = ";";
		_list[| 187] = "=";
		_list[| 188] = ",";
		_list[| 189] = "-";
		_list[| 190] = ".";
		_list[| 191] = "/";
		_list[| 192] = "'";
		_list[| 219] = "[";
		_list[| 220] = "\\";
		_list[| 221] = "]";
		_list[| 222] = "#";
		_list[| 223] = "`";

		_list[| 348] = ")";
		_list[| 349] = "!";
		_list[| 350] = "\"";
		_list[| 351] = "";
		_list[| 352] = "$";
		_list[| 353] = "%";
		_list[| 354] = "^";
		_list[| 355] = "&";
		_list[| 356] = "*";
		_list[| 357] = "(";
		//_list[| 365] = "a";
		//_list[| 366] = "b";
		//_list[| 367] = "c";
		//_list[| 368] = "d";
		//_list[| 369] = "e";
		//_list[| 370] = "f";
		//_list[| 371] = "g";
		//_list[| 372] = "height";
		//_list[| 373] = "i";
		//_list[| 374] = "j";
		//_list[| 375] = "k";
		//_list[| 376] = "l";
		//_list[| 377] = "m";
		//_list[| 378] = "n";
		//_list[| 379] = "o";
		//_list[| 380] = "p";
		//_list[| 381] = "q";
		//_list[| 382] = "r";
		//_list[| 383] = "s";
		//_list[| 384] = "t";
		//_list[| 385] = "u";
		//_list[| 386] = "v";
		//_list[| 387] = "width";
		//_list[| 388] = "x";
		//_list[| 389] = "y";
		//_list[| 390] = "z";

		_list[| 486] = ":";
		_list[| 487] = "+";
		_list[| 488] = "<";
		_list[| 489] = "_";
		_list[| 490] = ">";
		_list[| 491] = "?";
		_list[| 492] = "@";
		_list[| 519] = "{";
		_list[| 520] = "|";
		_list[| 521] = "}";
		_list[| 522] = "~";
		_list[| 523] = "¬";
	#endregion
}