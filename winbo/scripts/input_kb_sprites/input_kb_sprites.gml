/// @function input_kb_sprites
/// @summary Build a lookup list of keyboard key sprites.
/// @returns {void}
function input_kb_sprites() {
	//Create List
	global.keyboard_sprite_list = ds_list_create();

	//Initialise all sprites to Undefined
	var _list,_keyboard_sprite_list_num;
	_list = global.keyboard_sprite_list;
	_keyboard_sprite_list_num = 523;

	for(var _i=0;_i<_keyboard_sprite_list_num;_i++){
		_list[| _i] = noone;
	}

	// In GM, the controls are set to the keyboard keys and NOT
	// every possible character. Below is the list of all the possible
	// keycodes usually used with the built-in GM variable vk_ or ord()...
	// Some characters, depending on your language, may vary. Simply
	// modify the string in the table below to your needs. Default keyboard
	// layout used is "English - US".

	// Set known characters
	#region Fill List
		_list[| 8] = Keyboard_Black_Backspace_Alt;
		_list[| 9] = Keyboard_Black_Tab;
		_list[| 12] = Keyboard_Black_Num_Lock;
		_list[| 13] = Keyboard_Black_Enter_Alt;
		_list[| 16] = Keyboard_Black_Shift_Alt;
		_list[| 19] = noone;						//"Pause";
		_list[| 20] = Keyboard_Black_Caps_Lock;
		_list[| 27] = Keyboard_Black_Esc;
		_list[| 32] = Keyboard_Black_Space;
		_list[| 33] = Keyboard_Black_Page_Up;
		_list[| 34] = Keyboard_Black_Page_Down;
		_list[| 35] = Keyboard_Black_End;
		_list[| 36] = Keyboard_Black_Home;
		_list[| 37] = Keyboard_Black_Arrow_Left;
		_list[| 38] = Keyboard_Black_Arrow_Up;
		_list[| 39] = Keyboard_Black_Arrow_Right;
		_list[| 40] = Keyboard_Black_Arrow_Down;
		_list[| 45] = Keyboard_Black_Insert;
		_list[| 46] = Keyboard_Black_Del;
		_list[| 48] = Keyboard_Black_0;
		_list[| 49] = Keyboard_Black_1;
		_list[| 50] = Keyboard_Black_2;
		_list[| 51] = Keyboard_Black_3;
		_list[| 52] = Keyboard_Black_4;
		_list[| 53] = Keyboard_Black_5;
		_list[| 54] = Keyboard_Black_6;
		_list[| 55] = Keyboard_Black_7;
		_list[| 56] = Keyboard_Black_8;
		_list[| 57] = Keyboard_Black_9;
		_list[| 65] = Keyboard_Black_A;
		_list[| 66] = Keyboard_Black_B;
		_list[| 67] = Keyboard_Black_C;
		_list[| 68] = Keyboard_Black_D;
		_list[| 69] = Keyboard_Black_E;
		_list[| 70] = Keyboard_Black_F;
		_list[| 71] = Keyboard_Black_G;
		_list[| 72] = Keyboard_Black_H;
		_list[| 73] = Keyboard_Black_I;
		_list[| 74] = Keyboard_Black_J;
		_list[| 75] = Keyboard_Black_K;
		_list[| 76] = Keyboard_Black_L;
		_list[| 77] = Keyboard_Black_M;
		_list[| 78] = Keyboard_Black_N;
		_list[| 79] = Keyboard_Black_O;
		_list[| 80] = Keyboard_Black_P;
		_list[| 81] = Keyboard_Black_Q;
		_list[| 82] = Keyboard_Black_R;
		_list[| 83] = Keyboard_Black_S;
		_list[| 84] = Keyboard_Black_T;
		_list[| 85] = Keyboard_Black_U;
		_list[| 86] = Keyboard_Black_V;
		_list[| 87] = Keyboard_Black_W;
		_list[| 88] = Keyboard_Black_X;
		_list[| 89] = Keyboard_Black_Y;
		_list[| 90] = Keyboard_Black_Z;
		_list[| 91] = Keyboard_Black_Win;
		_list[| 96] = Keyboard_Black_0;
		_list[| 97] = Keyboard_Black_1
		_list[| 98] = Keyboard_Black_2
		_list[| 99] = Keyboard_Black_3
		_list[| 100] = Keyboard_Black_4
		_list[| 101] = Keyboard_Black_5
		_list[| 102] = Keyboard_Black_6
		_list[| 103] = Keyboard_Black_7
		_list[| 104] = Keyboard_Black_8
		_list[| 105] = Keyboard_Black_9
		_list[| 106] = Keyboard_Black_Asterisk
		_list[| 107] = Keyboard_Black_Plus_Tall
		_list[| 109] = Keyboard_Black_Minus
		_list[| 110] = noone;						//"Numpad .";
		_list[| 111] = Keyboard_Black_Slash;		//"Numpad /";
		_list[| 112] = Keyboard_Black_F1
		_list[| 113] = Keyboard_Black_F2
		_list[| 114] = Keyboard_Black_F3
		_list[| 115] = Keyboard_Black_F4
		_list[| 116] = Keyboard_Black_F5
		_list[| 117] = Keyboard_Black_F6
		_list[| 118] = Keyboard_Black_F7
		_list[| 119] = Keyboard_Black_F8
		_list[| 120] = Keyboard_Black_F9
		_list[| 121] = Keyboard_Black_F10
		_list[| 122] = Keyboard_Black_F11
		_list[| 123] = Keyboard_Black_F12
		_list[| 144] = Keyboard_Black_Num_Lock;
		_list[| 145] = noone;						//"Scroll lock";
		_list[| 160] = Keyboard_Black_Shift_Alt;
		_list[| 161] = Keyboard_Black_Shift_Alt;
		_list[| 162] = Keyboard_Black_Ctrl;
		_list[| 163] = Keyboard_Black_Ctrl;
		_list[| 164] = Keyboard_Black_Alt;
		_list[| 165] = Keyboard_Black_Alt;
		_list[| 186] = Keyboard_Black_Semicolon;
		_list[| 187] = noone;						//"=";
		_list[| 188] = noone;						//",";
		_list[| 189] = noone;						//"-";
		_list[| 190] = noone;						//".";
		_list[| 191] = Keyboard_Black_Slash;		//"/";
		_list[| 192] = noone;						//"'";
		_list[| 219] = Keyboard_Black_Bracket_Left;
		_list[| 220] = Keyboard_Black_Slash;		//"\\";
		_list[| 221] = Keyboard_Black_Bracket_Right;
		_list[| 222] = noone;						//"#";
		_list[| 223] = noone;						//"`";

		_list[| 348] = noone;						//")";
		_list[| 349] = noone;						//"!";
		_list[| 350] = Keyboard_Black_Quote;
		_list[| 351] = noone;						//"";
		_list[| 352] = noone;						//"$";
		_list[| 353] = noone;						// "%";
		_list[| 354] = noone;						// "^";
		_list[| 355] = noone;						//"&";
		_list[| 356] = Keyboard_Black_Asterisk;
		_list[| 357] = noone;						//"(";
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

		_list[| 486] = noone;						//":";
		_list[| 487] = Keyboard_Black_Plus;
		_list[| 488] = Keyboard_Black_Mark_Left;
		_list[| 489] = noone;						//"_";
		_list[| 490] = Keyboard_Black_Mark_Right;
		_list[| 491] = Keyboard_Black_Question;
		_list[| 492] = noone;						//"@";
		_list[| 519] = noone;						//"{";
		_list[| 520] = noone;						//"|";
		_list[| 521] = noone;						//"}";
		_list[| 522] = Keyboard_Black_Tilda;
		_list[| 523] = noone;						//"¬";
	#endregion
}