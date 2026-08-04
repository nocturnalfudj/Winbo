var _gui_width = display_get_gui_width();
var _gui_height = display_get_gui_height();
var _scale_x = _gui_width / 1920;
var _scale_y = _gui_height / 1080;

if(phase == OpeningCutscenePhase.interactive) {
	var _jump_y = _gui_height * 0.15;
	var _move_y = _gui_height * 0.21;
	var _shadow_x = 3 * _scale_x;
	var _shadow_y = 3 * _scale_y;
	draw_set_font(fnt_bahnschrift_32);
	draw_set_valign(fa_middle);

	if(prompt_use_sprites) {
		var _jump_prefix = "Press";
		var _jump_suffix = "to Jump";
		var _jump_icon_scale = 0.5;
		var _jump_gap = 12 * _scale_x;
		var _jump_prefix_width = string_width(_jump_prefix) * _scale_x;
		var _jump_suffix_width = string_width(_jump_suffix) * _scale_x;
		var _jump_icon_width = sprite_get_width(prompt_jump_sprite)
			* _jump_icon_scale * _scale_x;
		var _jump_width = _jump_prefix_width + _jump_icon_width
			+ _jump_suffix_width + _jump_gap * 2;
		var _jump_prefix_x = (_gui_width - _jump_width) * 0.5;
		var _jump_icon_x = _jump_prefix_x + _jump_prefix_width
			+ _jump_gap + _jump_icon_width * 0.5;
		var _jump_suffix_x = _jump_icon_x + _jump_icon_width * 0.5 + _jump_gap;

		draw_set_halign(fa_left);
		draw_set_colour(c_black);
		draw_text_transformed(
			_jump_prefix_x + _shadow_x,
			_jump_y + _shadow_y,
			_jump_prefix,
			_scale_x,
			_scale_y,
			0
		);
		draw_text_transformed(
			_jump_suffix_x + _shadow_x,
			_jump_y + _shadow_y,
			_jump_suffix,
			_scale_x,
			_scale_y,
			0
		);
		draw_set_colour(c_white);
		draw_text_transformed(
			_jump_prefix_x,
			_jump_y,
			_jump_prefix,
			_scale_x,
			_scale_y,
			0
		);
		draw_text_transformed(
			_jump_suffix_x,
			_jump_y,
			_jump_suffix,
			_scale_x,
			_scale_y,
			0
		);
		draw_sprite_ext(
			prompt_jump_sprite,
			0,
			_jump_icon_x,
			_jump_y,
			_jump_icon_scale * _scale_x,
			_jump_icon_scale * _scale_y,
			0,
			c_white,
			1
		);

		if(prompt_elapsed >= prompt_move_delay) {
			var _move_text_scale_x = _scale_x * 0.75;
			var _move_text_scale_y = _scale_y * 0.75;
			var _move_icon_scale = 0.42;
			var _move_gap = 10 * _scale_x;
			var _move_slash = "/";
			var _move_suffix = "to move Left/Right";
			var _left_icon_width = sprite_get_width(prompt_left_sprite)
				* _move_icon_scale * _scale_x;
			var _right_icon_width = sprite_get_width(prompt_right_sprite)
				* _move_icon_scale * _scale_x;
			var _move_slash_width = string_width(_move_slash) * _move_text_scale_x;
			var _move_suffix_width = string_width(_move_suffix) * _move_text_scale_x;
			var _move_width = _left_icon_width + _right_icon_width
				+ _move_slash_width + _move_suffix_width + _move_gap * 4;
			var _move_cursor = (_gui_width - _move_width) * 0.5;
			var _left_icon_x = _move_cursor + _left_icon_width * 0.5;
			var _slash_x = _move_cursor + _left_icon_width + _move_gap;
			var _right_icon_x = _slash_x + _move_slash_width
				+ _move_gap + _right_icon_width * 0.5;
			var _move_suffix_x = _right_icon_x + _right_icon_width * 0.5
				+ _move_gap * 2;

			draw_set_colour(c_black);
			draw_text_transformed(
				_slash_x + _shadow_x,
				_move_y + _shadow_y,
				_move_slash,
				_move_text_scale_x,
				_move_text_scale_y,
				0
			);
			draw_text_transformed(
				_move_suffix_x + _shadow_x,
				_move_y + _shadow_y,
				_move_suffix,
				_move_text_scale_x,
				_move_text_scale_y,
				0
			);
			draw_set_colour(c_white);
			draw_text_transformed(
				_slash_x,
				_move_y,
				_move_slash,
				_move_text_scale_x,
				_move_text_scale_y,
				0
			);
			draw_text_transformed(
				_move_suffix_x,
				_move_y,
				_move_suffix,
				_move_text_scale_x,
				_move_text_scale_y,
				0
			);
			draw_sprite_ext(
				prompt_left_sprite,
				0,
				_left_icon_x,
				_move_y,
				_move_icon_scale * _scale_x,
				_move_icon_scale * _scale_y,
				0,
				c_white,
				1
			);
			draw_sprite_ext(
				prompt_right_sprite,
				0,
				_right_icon_x,
				_move_y,
				_move_icon_scale * _scale_x,
				_move_icon_scale * _scale_y,
				0,
				c_white,
				1
			);
		}
	}
	else {
		var _jump_text = "Press " + prompt_jump_label + " to Jump";
		draw_set_halign(fa_center);
		draw_set_colour(c_black);
		draw_text_transformed(
			_gui_width * 0.5 + _shadow_x,
			_jump_y + _shadow_y,
			_jump_text,
			_scale_x,
			_scale_y,
			0
		);
		draw_set_colour(c_white);
		draw_text_transformed(
			_gui_width * 0.5,
			_jump_y,
			_jump_text,
			_scale_x,
			_scale_y,
			0
		);

		if(prompt_elapsed >= prompt_move_delay) {
			var _move_text = prompt_left_label + "/" + prompt_right_label
				+ " to move Left/Right";
			var _move_scale_x = _scale_x * 0.75;
			var _move_scale_y = _scale_y * 0.75;
			draw_set_colour(c_black);
			draw_text_transformed(
				_gui_width * 0.5 + 2 * _scale_x,
				_move_y + 2 * _scale_y,
				_move_text,
				_move_scale_x,
				_move_scale_y,
				0
			);
			draw_set_colour(c_white);
			draw_text_transformed(
				_gui_width * 0.5,
				_move_y,
				_move_text,
				_move_scale_x,
				_move_scale_y,
				0
			);
		}
	}

	draw_set_colour(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

if(phase == OpeningCutscenePhase.title && title_card_enabled) {
	var _black_alpha = clamp(title_elapsed / title_black_fade_duration,0,1);
	var _title_elapsed = max(0,title_elapsed - title_black_fade_duration);
	var _title_fade_in = clamp(
		_title_elapsed / title_text_fade_in_duration,
		0,
		1
	);
	var _title_fade_in_eased = _title_fade_in * _title_fade_in
		* (3 - 2 * _title_fade_in);
	var _title_fade_out = clamp(
		(title_duration - title_elapsed) / title_text_fade_out_duration,
		0,
		1
	);
	var _title_alpha = min(_title_fade_in_eased,_title_fade_out);
	var _title_scale = min(_scale_x,_scale_y)
		* lerp(1.8,2.25,_title_fade_in_eased);

	draw_set_alpha(_black_alpha);
	draw_set_colour(c_black);
	draw_rectangle(0,0,_gui_width,_gui_height,false);

	draw_set_alpha(_title_alpha);
	draw_set_font(fnt_default_100);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_colour(make_colour_rgb(255,209,63));
	draw_text_transformed(
		_gui_width * 0.5,
		_gui_height * 0.5,
		"WINBO",
		_title_scale,
		_title_scale,
		0
	);

	draw_set_alpha(1);
	draw_set_colour(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}
