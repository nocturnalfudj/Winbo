enum PresenceDialoguePageMode {
	demon_decode,
	direct_english
}

function presence_dialogue_page(_text, _expected_lines, _text_scale = 1.35, _text_width = 370, _text_offset_y = 0) {
	return {
		text: string_replace_all(_text,"|",chr(10)),
		expected_lines: _expected_lines,
		mode: PresenceDialoguePageMode.direct_english,
		text_scale: _text_scale,
		text_width: _text_width,
		text_offset_y: _text_offset_y,
	};
}

function presence_dialogue_pages_prepare(_pages) {
	var _page_count;
	_page_count = array_length(_pages);
	for(var _i=0;_i<_page_count;_i++) {
		_pages[_i].mode = PresenceDialoguePageMode.direct_english;
	}
	if(_page_count > 0) {
		_pages[0].mode = PresenceDialoguePageMode.demon_decode;
	}
	return _pages;
}

function presence_dialogue_pages_create(_stage) {
	switch(_stage) {

		case "level_3":
			return presence_dialogue_pages_prepare([
				presence_dialogue_page("They fear you|because they can|not understand", 3),
				presence_dialogue_page("you, Winbo. They|want you to be like|them. They want", 3),
				presence_dialogue_page("you to have lore.|For so great a sin|there can be no", 3),
				presence_dialogue_page("punishment too|severe. Jump on|their heads,", 3),
				presence_dialogue_page("Winbo. Jump on|all of their heads.", 2),
			]);

		case "level_5":
			return presence_dialogue_pages_prepare([
				presence_dialogue_page("You have likely|surmised by now,|Winbo. Collecting", 3),
				presence_dialogue_page("all of my|Talismans will|unlock a bonus", 3),
				presence_dialogue_page("level. These|degenerates have|no concept of", 3),
				presence_dialogue_page("bonus levels. It is|an art lost to them|amidst the mire of", 3),
				presence_dialogue_page("their melodrama.|At most they can|conceive of", 3),
				presence_dialogue_page("concept art or|cutscenes,|rendered by the", 3),
				presence_dialogue_page("same profane|machines that|create the motion", 3),
				presence_dialogue_page("pictures they envy|so dearly. Release|them from their", 3),
				presence_dialogue_page("myopic ambition.|Give them the|violence they so", 3),
				presence_dialogue_page("crave.", 1),
			]);

		case "level_7":
			return presence_dialogue_pages_prepare([
				presence_dialogue_page("Our time is close|at hand, Winbo.|When I first", 3),
				presence_dialogue_page("returned you to|these lands I had|salivated at the", 3),
				presence_dialogue_page("thought of a day|like this. At this|mountain's", 3),
				presence_dialogue_page("summit is a man|on a journey as|petty and rote as", 3),
				presence_dialogue_page("any we have seen.|He thinks himself|the hero in some", 3),
				presence_dialogue_page("grand yet tragic|odyssey. He|indulges in his", 3),
				presence_dialogue_page("own melancholy,|and is|emboldened by", 3),
				presence_dialogue_page("the world that has|formed around|him. Let us bring it", 3),
				presence_dialogue_page("all crashing down.|Humbling him will|be our first truly", 3),
				presence_dialogue_page("great step in|returning to The|Old Ways. See", 3),
				presence_dialogue_page("that it is done,|Winbo.", 2),
			]);

		case "bonus":
			return presence_dialogue_pages_prepare([
				presence_dialogue_page("Yes, bonus|content. Your|reward for", 3),
				presence_dialogue_page("gathering all the|Talismans. The|deed is done,", 3),
				presence_dialogue_page("Winbo, but|perhaps our job is|not. Does your", 3),
				presence_dialogue_page("wish to purge|these lands|remain? Are you", 3),
				presence_dialogue_page("satisfied? Or do|the embers of rage|still crackle within", 3),
				presence_dialogue_page("your rattling soul?|If so, perhaps we|may meet again.", 3),
				presence_dialogue_page("For now, enjoy the|succulent fruits of|your success.", 3),
				presence_dialogue_page("Farewell.", 1),
			]);

	}

	return presence_dialogue_pages_prepare([
		presence_dialogue_page("Look upon these charlatans, Winbo.|With their guns and bombs and|internal conflict.", 3, 0.90, 750),
		presence_dialogue_page("So self-important are they that they|pay no mind to whose domain this|once was until he stands before them.", 3, 0.90, 750),
		presence_dialogue_page("Sweep through these lands, and|collect the Orbs, Winbo. Pass through|my doors, and gather my Talismans.", 3, 0.90, 750),
		presence_dialogue_page("Humble them.|Remind them of whence they came.", 2, 0.90, 750, -22),
		presence_dialogue_page("This is your nature, Winbo...|You collect things.", 2, 0.90, 750, -12),
		presence_dialogue_page("Now go. Strip them of|all their pretences. Strip|them of all that they are.", 3, 0.90, 750, -12),
	]);
}
