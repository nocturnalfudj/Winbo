function presence_dialogue_page(_text, _lines) {
	return {
		text: string_replace_all(_text,"|",chr(10)),
		lines: _lines,
	};
}

function presence_dialogue_pages_create(_stage) {
	switch(_stage) {
		case "level_3":
			return [
				presence_dialogue_page("They fear you|because they can not|understand you,", 3),
				presence_dialogue_page("Winbo.", 1),
				presence_dialogue_page("They want you to be|like them. They want|you to have lore.", 3),
				presence_dialogue_page("For so great a sin|there can be no|punishment too", 3),
				presence_dialogue_page("severe.", 1),
				presence_dialogue_page("Jump on their heads,|Winbo. Jump on all of|their heads.", 3),
			];

		case "level_5":
			return [
				presence_dialogue_page("You have likely|surmised by now,|Winbo.", 3),
				presence_dialogue_page("Collecting all of my|Talismans will unlock|a bonus level.", 3),
				presence_dialogue_page("These degenerates|have no concept of|bonus levels.", 3),
				presence_dialogue_page("It is an art lost to|them amidst the mire|of their melodrama.", 3),
				presence_dialogue_page("At most they can|conceive of concept|art or cutscenes,", 3),
				presence_dialogue_page("rendered by the same|profane machines|that create", 3),
				presence_dialogue_page("the motion pictures|they envy so dearly.", 2),
				presence_dialogue_page("Release them from|their myopic|ambition.", 3),
				presence_dialogue_page("Give them the|violence they so|crave.", 3),
			];

		case "level_7":
			return [
				presence_dialogue_page("Our time is close at|hand, Winbo.", 2),
				presence_dialogue_page("When I first returned|you to these lands I|had salivated", 3),
				presence_dialogue_page("at the thought of a|day like this.", 2),
				presence_dialogue_page("At this mountain's|summit is a man on a|journey", 3),
				presence_dialogue_page("as petty and rote as|any we have seen.", 2),
				presence_dialogue_page("He thinks himself the|hero in some grand|yet tragic odyssey.", 3),
				presence_dialogue_page("He indulges in his|own melancholy,", 2),
				presence_dialogue_page("and is emboldened|by the world that has|formed around him.", 3),
				presence_dialogue_page("Let us bring it all|crashing down.", 2),
				presence_dialogue_page("Humbling him will be|our first truly great|step", 3),
				presence_dialogue_page("in returning to The|Old Ways.", 2),
				presence_dialogue_page("See that it is done,|Winbo.", 2),
			];

		case "bonus":
			return [
				presence_dialogue_page("Yes, bonus content.", 1),
				presence_dialogue_page("Your reward for|gathering all the|Talismans.", 3),
				presence_dialogue_page("The deed is done,|Winbo, but perhaps|our job is not.", 3),
				presence_dialogue_page("Does your wish to|purge these lands|remain?", 3),
				presence_dialogue_page("Are you satisfied?", 1),
				presence_dialogue_page("Or do the embers of|rage still crackle|within your rattling", 3),
				presence_dialogue_page("soul?", 1),
				presence_dialogue_page("If so, perhaps we may|meet again.", 2),
				presence_dialogue_page("For now, enjoy the|succulent fruits of|your success.", 3),
				presence_dialogue_page("Farewell.", 1),
			];
	}

	return [
		presence_dialogue_page("Look upon these|charlatans, Winbo.", 2),
		presence_dialogue_page("With their guns and|bombs and internal|conflict.", 3),
		presence_dialogue_page("So self-important are|they that they pay no|mind", 3),
		presence_dialogue_page("to whose domain this|once was until he|stands before them.", 3),
		presence_dialogue_page("Collect my Talismans|and humble them,", 2),
		presence_dialogue_page("remind them of|whence they came.", 2),
		presence_dialogue_page("This is your nature,|Winbo.", 2),
		presence_dialogue_page("You collect things.", 1),
		presence_dialogue_page("Now go, strip them of|all their pretences.", 2),
		presence_dialogue_page("Strip them of all that|they are.", 2),
	];
}
