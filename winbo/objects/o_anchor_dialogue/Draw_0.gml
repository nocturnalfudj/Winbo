var _presence_x;
var _presence_y;
_presence_x = x;
_presence_y = y;

if(instance_number(o_npc_presence) > 0) {
	var _presence;
	_presence = instance_find(o_npc_presence,0);
	_presence_x = _presence.x + _presence.draw_adjustment_x;
	_presence_y = _presence.y + _presence.draw_adjustment_y + presence_dialogue_anchor_offset_y;
}

var _box_sprite;
var _text_offset_y;
switch(presence_dialogue_page_line_count) {
	case 1:
		_box_sprite = spr_presence_speech_box_small;
		_text_offset_y = presence_dialogue_text_offset_y_small;
	break;

	case 2:
		_box_sprite = spr_presence_speech_box_medium;
		_text_offset_y = presence_dialogue_text_offset_y_medium;
	break;

	default:
		_box_sprite = spr_presence_speech_box_large;
		_text_offset_y = presence_dialogue_text_offset_y_large;
	break;
}

var _frame;
_frame = floor(presence_dialogue_frame);
var _alpha;
_alpha = image_alpha;

draw_sprite_ext(_box_sprite,_frame,_presence_x,_presence_y,presence_dialogue_box_scale,presence_dialogue_box_scale,0,c_white,_alpha);

if(presence_dialogue_ready_for_advance && presence_dialogue_page_index < array_length(presence_dialogue_pages) - 1) {
	draw_sprite_ext(spr_presence_speech_prompt,_frame,_presence_x,_presence_y,presence_dialogue_box_scale,presence_dialogue_box_scale,0,c_white,_alpha);
}

var _text_x;
var _text_y;
_text_x = _presence_x + presence_dialogue_text_offset_x * presence_dialogue_box_scale;
_text_y = _presence_y + _text_offset_y * presence_dialogue_box_scale;

if(presence_dialogue_phase == PresenceDialoguePhase.decode_glitch) {
	presence_dialogue_decode_draw(_text_x,_text_y,_alpha);
}
else {
	with(presence_dialogue_text_instance) {
		image_alpha = _alpha;
		image_xscale = 1;
		image_yscale = 1;
		text_rich_draw_characters(other.presence_dialogue_text_scale,_text_x,_text_y);
	}
}
