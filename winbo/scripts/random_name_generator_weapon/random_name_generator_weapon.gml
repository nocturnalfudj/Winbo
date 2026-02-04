/// @description Generate a random name for a weapon.
/// @function random_name_generator_weapon
/// @param weapon_type - The type of weapon ("bow", "staff", "sword", "axe", "mace", "pistol", "rifle", "heavy gun", "thrower", "launcher").
/// @param genre - The genre of the weapon ("fantasy", "modern", "sci fi").
/// @returns The generated name as a string.
function random_name_generator_weapon(_weapon_type, _genre) {
    var _weapon_name;
    
    // Randomly select a name for the weapon based on the type and genre.
    switch (_weapon_type) {
        case "bow":
		    switch (_genre) {
		        case "fantasy":
		            _weapon_name = choose(
		                "Elven Longbow", "Sylvan Arc", "Falcon's Eye", "Moonshadow Bow", "Windwhisper",
		                "Ethereal Bow", "Celestial Archer", "Starfire Longbow", "Silvermoon Bow", "Forest Guardian",
		                "Dreamweaver Bow", "Phoenix's Flight", "Duskwood Bow", "Stardust Bow", "Whispering Willow",
		                "Galestorm Bow", "Emberwood Bow", "Enchanted Hunter", "Thornwood Bow", "Stormbringer",
		                "Moonlit Serenade", "Windsong Bow", "Faerielight Bow", "Eclipse Bow", "Mystic Harmony",
		                "Wraithbane Bow", "Twilight Striker", "Thunderbolt Bow", "Viper's Sting", "Amberglow Bow",
		                "Silvershade Bow", "Silent Serenity", "Aurora's Embrace", "Sunfire Bow", "Loreweaver's Longbow",
		                "Starfall Bow", "Ebonwood Bow", "Frostmoon Bow", "Shadowhunter", "Dragonbone Bow",
		                "Songwood Bow", "Aether's Reach", "Wildfire Bow", "Moonglow Bow", "Bladewood Archer",
		                "Dawnseeker Bow", "Arcane Harmony", "Moonlit Breeze", "Emerald Gale", "Frostbloom Bow",
		                "Sapphire Skybow", "Arcane Whisper", "Rosewood Bow", "Violet Dreambow", "Golden Sunset",
		                "Serenewind Bow", "Crimson Skysplitter", "Mistral Bow", "Ancient Sylvan Bow", "Starweave Bow",
		                "Moonflame Bow", "Sable Shadow Bow", "Whisperwind Bow", "Veilstrike Bow", "Firefly Archer",
		                "Glimmering Comet Bow", "Stormchaser Bow", "Celestial Crescent", "Forestwail Bow", "Soulfire Bow",
		                "Sunflare Bow", "Dewdrop Bow", "Crystalglen Bow", "Harmony's Echo", "Starshot Bow",
		                "Thornheart Bow", "Moonshadow Whisper", "Blossomwood Bow", "Astral Mirage", "Nightfall Bow",
		                "Rainsong Bow", "Stellardust Bow", "Ravenwing Bow", "Flarewood Bow", "Heartwood Hunter",
		                "Gloomshadow Bow", "Silent Moonbow", "Amethyst Dream", "Garnet Starbow", "Sapwood Archer",
		                "Starlight Serenade", "Bramblethorn Bow", "Thunderstorm Bow", "Cerulean Skies", "Twilight's Embrace"
		            );
		            break;
		        case "modern":
		            _weapon_name = choose(
		                "Tactical Compound Bow", "Stealth Hunter", "Sniper's Crossbow", "Rapid Archer", "Urban Marksman",
		                "Shadowstalker Bow", "Delta Force Bow", "Recon Viper", "Predator's Aim", "Steelsight Longbow",
		                "Blackhawk Crossbow", "Ghoststrike Bow", "Assault Banshee", "Nightshade Sniper", "Striker One",
		                "Viperstrike Bow", "Widowmaker Crossbow", "Hawk's Eye", "Phantom Archer", "Silent Vanguard",
		                "Venomwing Bow", "Wraithfire Crossbow", "Spectre's Shot", "Steelspine Longbow", "Razorback Hunter",
		                "Shadowstrike Bow", "Wolfpack Crossbow", "Stealth Phantom", "Recon Viper", "Skyfall Archer",
		                "Nightshade Hunter", "Eclipse Longbow", "Stryker's Aim", "Sentinel's Crossbow", "Rapid Vanguard",
		                "Hawkeye Bow", "Steelsight Marksman", "Nightstalker Crossbow", "Ghoststrike Archer", "Blackhawk Sniper",
		                "Spectre's Strike", "Viper's Aim", "Phantomstrike Bow", "Silent Banshee", "Venomwing Marksman",
		                "Widowmaker Sniper", "Shadowstalker Aim", "Assault Phantom", "Wolfpack Crossbow", "Steelstrike Bow",
		                "Razorback Sniper", "Nightfall Vanguard", "Skyfall Aim", "Eclipse Crossbow", "Hawkeye Marksman",
		                "Steelsight Sniper", "Rapidstrike Bow", "Stryker's Vanguard", "Sentinel's Aim", "Nightshade Marksman",
		                "Ghoststrike Crossbow", "Viper's Vanguard", "Phantomstrike Aim", "Silent Vanguard", "Venomwing Marksman",
		                "Widowmaker Aim", "Shadowstalker Vanguard", "Assault Vanguard", "Spectre's Aim", "Steelstrike Marksman",
		                "Razorback Crossbow", "Skyfall Vanguard", "Eclipse Marksman", "Hawkeye Sniper", "Steelsight Aim",
		                "Rapidstrike Vanguard", "Stryker's Marksman", "Sentinel's Sniper", "Nightshade Aim", "Ghoststrike Vanguard"
		            );
		            break;
		        case "sci fi":
		            _weapon_name = choose(
		                "Photon Bow", "Plasma String Bow", "Nanotech Sniper Bow", "Graviton Arc", "Quantum Reflex",
		                "Fusionstar Bow", "Electro-Zephyr", "Neutron Striker", "Quantum Serenade", "Vortex Beam Bow",
		                "Cosmic Shard Bow", "Proton Fury", "Xenon Bowcaster", "Chrono-Dream Bow", "Ionstorm Arbalest",
		                "Astroflect Bow", "Particle Hunter", "Pulsar Bow", "Cyberstorm Emitter", "Voidflame Bow",
		                "Galactic Wavebow", "Starfire Repeater", "Phasehunter Bow", "Novastring Bow", "Astrolance Bow",
		                "Quantum Thunderstrike", "Plasma Disruptor", "Eventide Archer", "Eclipse Lance", "Astronova Bow",
		                "Electroflux Bow", "Vortexstrike Bow", "Nanoblaze Bow", "Stellaris Bow", "Neurocaster Bow",
		                "Proton Scatterbow", "Graviton Enigma", "Xenon Phantom", "Timebender Bow", "Ionic Repeater",
		                "Chronoflux Bow", "Astropulse Bow", "Photon Fury", "Astrostrike Bow", "Phasefire Bow",
		                "Starcore Bow", "Plasmadance Bow", "Voidstrider Bow", "Galaxyshard Bow", "Particlestrike Bow",
		                "Quantum Nova Bow", "Pulsarflare Bow", "Neutronwave Bow", "Cyberstorm Bow", "Astrospire Bow",
		                "Xenonflux Bow", "Chronoshock Bow", "Ionstorm Serenade", "Eventide Emitter", "Eclipse Arbalest",
		                "Astronova Bow", "Electroflare Bow", "Vortex Disruptor", "Nanostar Bow", "Stellarforce Bow",
		                "Neurostrike Bow", "Proton Lance", "Graviton Hunter", "Xenonwave Bow", "Timeflux Bow",
		                "Ionicstrike Bow", "Chronoblaze Bow", "Astrothorn Bow", "Photon Striker", "Astroflare Bow",
		                "Phasewind Bow", "Starblaze Bow", "Plasmacore Bow", "Voidpulse Bow", "Galactic Emitter",
		                "Particle Serenade", "Quantum Lancer", "Pulsarstrike Bow", "Neutronflare Bow", "Cybercore Bow"
		            );
		            break;
		    }
		    break;
        case "staff":
		    switch (_genre) {
		        case "fantasy":
		            _weapon_name = choose(
		                "Archmage's Staff", "Sylvan Willow", "Frostfire Rod", "Dragon's Breath Staff", "Starfall Cane",
		                "Celestial Scepter", "Moonshadow Staff", "Enigma Wand", "Arcane Oak Staff", "Witchwood Rod",
		                "Ethereal Staff", "Phoenix Ember Rod", "Thornwood Staff", "Stardust Scepter", "Elven Starstaff",
		                "Galestorm Cane", "Emberwood Wand", "Enchanted Sagestaff", "Dreamweaver Rod", "Stormcaller Staff",
		                "Moonlit Serpentwand", "Windsong Cane", "Faerielight Rod", "Eclipse Scepter", "Mystic Rune Staff",
		                "Wraithbane Wand", "Twilight Adept Staff", "Thunderbolt Rod", "Viper's Fang", "Amberglow Staff",
		                "Silvershade Scepter", "Silent Serenity", "Aurora's Embrace", "Sunfire Wand", "Loreweaver's Staff",
		                "Starfall Arcanum", "Ebonwood Wand", "Frostmoon Scepter", "Shadowweaver Staff", "Dragonbone Cane",
		                "Songwood Rod", "Aether's Reach", "Wildfire Scepter", "Moonglow Wand", "Bladewood Enchanter",
		                "Dawnseeker Staff", "Arcane Harmony", "Moonlit Breeze", "Emerald Sage Rod", "Frostbloom Staff",
		                "Sapphire Starwand", "Arcane Whisper", "Rosewood Scepter", "Violet Dreamstaff", "Golden Sunset",
		                "Serenewind Wand", "Crimson Skysplitter", "Mistral Rod", "Ancient Runestaff", "Starweave Cane",
		                "Moonflame Wand", "Sable Shadowstaff", "Whisperwind Scepter", "Veilstrike Wand", "Firefly Enchanter",
		                "Glimmering Comet Staff", "Stormchaser Scepter", "Celestial Crescent", "Forestwail Wand", "Soulfire Staff",
		                "Sunflare Scepter", "Dewdrop Wand", "Crystalglen Rod", "Harmony's Echo", "Starshot Cane",
		                "Thornheart Wand", "Moonshadow Whisper", "Blossomwood Scepter", "Astral Mirage", "Nightfall Cane",
		                "Rainsong Wand", "Stellardust Scepter", "Ravenwing Staff", "Flarewood Rod", "Heartwood Enchanter",
		                "Gloomshadow Wand", "Silent Moonstaff", "Amethyst Dream", "Garnet Starwand", "Sapwood Scepter",
		                "Starlight Serenade", "Bramblethorn Wand", "Thunderstorm Scepter", "Cerulean Skies", "Twilight's Embrace"
		            );
		            break;
		        case "modern":
		            _weapon_name = choose(
		                "Tactical Arcane Staff", "Stealth Magi", "Sniper's Scepter", "Rapid Enchanter", "Urban Runestaff",
		                "Shadowstalker Cane", "Delta Force Wand", "Recon Magestaff", "Predator's Scepter", "Steelsight Enchanter",
		                "Blackhawk Arcanum", "Ghoststrike Wand", "Assault Magestaff", "Nightshade Scepter", "Striker One",
		                "Viperstrike Cane", "Widowmaker Wand", "Hawk's Eye", "Phantom Enchanter", "Silent Vanguard",
		                "Venomwing Staff", "Wraithfire Wand", "Spectre's Scepter", "Steelspine Enchanter", "Razorback Arcane Staff",
		                "Shadowstrike Cane", "Wolfpack Wand", "Stealth Phantom", "Recon Viper", "Skyfall Enchanter",
		                "Nightshade Runestaff", "Eclipse Scepter", "Stryker's Arcanum", "Sentinel's Wand", "Rapid Vanguard",
		                "Hawkeye Staff", "Steelsight Magi", "Nightstalker Wand", "Ghoststrike Enchanter", "Blackhawk Runestaff",
		                "Spectre's Scepter", "Viper's Enchanter", "Phantomstrike Cane", "Silent Banshee", "Venomwing Magi",
		                "Widowmaker Scepter", "Shadowstalker Enchanter", "Assault Vanguard", "Wolfpack Wand", "Steelstrike Cane",
		                "Razorback Staff", "Nightfall Magi", "Skyfall Enchanter", "Eclipse Scepter", "Hawkeye Runestaff",
		                "Steelsight Staff", "Rapidstrike Cane", "Stryker's Enchanter", "Sentinel's Scepter", "Nightshade Magi",
		                "Ghoststrike Wand", "Viper's Enchanter", "Phantomstrike Staff", "Silent Vanguard", "Venomwing Magi",
		                "Widowmaker Staff", "Shadowstalker Scepter", "Assault Vanguard", "Spectre's Enchanter", "Steelstrike Runestaff",
		                "Razorback Staff", "Skyfall Magi", "Eclipse Enchanter", "Hawkeye Wand", "Steelsight Scepter",
		                "Rapidstrike Magi", "Stryker's Wand", "Sentinel's Enchanter", "Nightshade Staff", "Ghoststrike Runestaff"
		            );
		            break;
		        case "sci fi":
		            _weapon_name = choose(
		                "Photon Staff", "Plasma Arcanum", "Nanotech Enchanter", "Graviton Scepter", "Quantum Rune Staff",
		                "Fusionstar Wand", "Electro-Zephyr", "Neutron Magi", "Quantum Serpentwand", "Vortex Cane",
		                "Cosmic Shard Staff", "Proton Fury", "Xenon Magestaff", "Chrono-Dream Scepter", "Ionstorm Arcane Staff",
		                "Astroflect Wand", "Particle Scepter", "Pulsar Cane", "Cyberstorm Enchanter", "Voidflame Staff",
		                "Galactic Wavecrafter", "Starfire Scepter", "Phasehunter Wand", "Novastring Enchanter", "Astrolance Rune Staff",
		                "Quantum Thunderstrike", "Plasma Disruptor", "Eventide Staff", "Eclipse Rune Staff", "Astronova Cane",
		                "Electroflux Wand", "Vortexstrike Scepter", "Nanoblaze Enchanter", "Stellaris Staff", "Neurocaster Rune Staff",
		                "Proton Scatterwand", "Graviton Enigma", "Xenon Phantom", "Timeflux Scepter", "Ionicstrike Arcane Staff",
		                "Chronostar Wand", "Astrostrike Enchanter", "Photon Dreamstaff", "Plasmaforce Scepter", "Nanostar Magi",
		                "Graviton Magitech", "Xenon Techstaff", "Timebender Rune Staff", "Astrostrike Scepter", "Photon Magi",
		                "Plasmaflare Cane", "Nanospark Staff", "Gravitonstar Wand", "Xenoblaze Enchanter", "Timequill Rune Staff",
		                "Astroflux Arcane Staff", "Photon Nova", "Plasmatide Wand", "Nanospark Scepter", "Graviton Arcane",
		                "Xenocore Enchanter", "Timefury Scepter", "Ionicstrike Rune Staff", "Chronoflux Wand", "Astroflare Enchanter",
		                "Photonstrike Staff", "Plasmalance Scepter", "Nanoflare Wand", "Graviton Enchanter", "Xenon Arcanum",
		                "Timeforce Rune Staff", "Astrostrike Staff", "Photon Enchanter", "Plasmatide Scepter", "Nanospark Rune Staff"
		            );
		            break;
		    }
		    break;
		case "sword":
		    switch (_genre) {
		        case "fantasy":
		            _weapon_name = choose(
		                "Excalibur", "Dragonslayer", "Sword of Kings", "Frostbite Blade", "Stormbringer",
		                "Moonlight Blade", "Elven Grace", "Celestial Edge", "Shadowmourne", "Aurora's Song",
		                "Doomblade", "Soulreaver", "Blade of Valor", "Starsteel Sword", "Wrathguard",
		                "Oathbreaker", "Glimmersteel", "Serpentfang", "Bloodmoon Blade", "Sunstrike",
		                "Dawnbreaker", "Faithkeeper", "Eclipse Blade", "Runeblade", "Thornstrike",
		                "Nightfall Sword", "Wraithblade", "Phantom Edge", "Ashenfang", "Venomstrike",
		                "Frostfire Sword", "Mournblade", "Stormrender", "Moonshadow Blade", "Skysteel",
		                "Starshard Sword", "Ebonwrath", "Soulslayer", "Blade of Fate", "Crimson Carver",
		                "Sunfire Sword", "Doombringer", "Shadowstrike", "Dragonsteel Blade", "Frostwind",
		                "Thundersoul Sword", "Nightslayer", "Windweaver", "Arcane Edge", "Obsidian Blade",
		                "Ebonsteel Sword", "Abyssal Cleaver", "Voidpiercer", "Bloodthorn Blade", "Solarflare",
		                "Dawnforged Sword", "Divine Lightblade", "Deathbringer", "Moonfall Blade", "Gloomreaver",
		                "Stardust Sword", "Shadowbane", "Eclipse Carver", "Runebound Blade", "Ashenbane",
		                "Venomfang Sword", "Frostbite", "Stormbringer", "Moonlight Blade", "Elven Grace",
		                "Celestial Edge", "Shadowmourne", "Aurora's Song", "Doomblade", "Soulreaver",
		                "Blade of Valor", "Starsteel Sword", "Wrathguard", "Oathbreaker", "Glimmersteel",
		                "Serpentfang", "Bloodmoon Blade", "Sunstrike", "Dawnbreaker", "Faithkeeper"
		            );
		            break;
		        case "modern":
		            _weapon_name = choose(
		                "Tactical Saber", "Stealthblade", "Nightstrike", "Shadowblade", "Urban Edge",
		                "Sword of Justice", "Recon Blade", "Predator's Grace", "Steelslash", "Phantomstrike",
		                "Blackhawk Sword", "Ghostblade", "Assault Saber", "Silentstrike", "Striker One",
		                "Viper's Fang", "Widowmaker", "Hawk's Edge", "Phantom's Fury", "Silent Vanguard",
		                "Venomblade", "Wraithblade", "Spectre's Grace", "Steelsoul", "Razorback Saber",
		                "Shadowstrike", "Wolfpack Blade", "Stealth Phantom", "Recon Viper", "Skyfall Edge",
		                "Nightshade Sword", "Eclipse Blade", "Stryker's Saber", "Sentinel's Grace", "Rapidstrike",
		                "Hawkeye Sword", "Steelslash", "Nightstalker", "Ghostblade", "Blackhawk Edge",
		                "Spectre's Saber", "Viper's Fury", "Phantomstrike", "Silent Banshee", "Venomblade",
		                "Widowmaker", "Shadowstrike", "Assault Vanguard", "Wolfpack Blade", "Steelshiver",
		                "Razorback Sword", "Nightfall Saber", "Skyfall Edge", "Eclipse Grace", "Hawkeye Saber",
		                "Steelslash", "Rapidstrike", "Stryker's Edge", "Sentinel's Fury", "Nightshade Blade",
		                "Ghoststrike", "Viper's Fury", "Phantomstrike", "Silent Vanguard", "Venomblade"
		            );
		            break;
		        case "sci fi":
		            _weapon_name = choose(
		                "Photon Blade", "Plasma Saber", "Nanotech Edge", "Graviton Sword", "Quantumstrike",
		                "Fusionsteel Saber", "Electroblade", "Neutron Edge", "Quantum Carver", "Vortex Blade",
		                "Cosmicstrike", "Proton Saber", "Xenoblade", "Chrono Edge", "Ionstorm Sword",
		                "Astroblade", "Particle Saber", "Pulsar Edge", "Cyberstrike", "Voidblade",
		                "Galactic Saber", "Starfire Edge", "Phaseblade", "Novastrike", "Astrostrike",
		                "Quantum Blade", "Plasma Carver", "Eventide Sword", "Eclipse Edge", "Astronova Saber",
		                "Electroflux", "Vortexstrike", "Nanofang", "Stellaris Edge", "Neuroblade",
		                "Proton Saber", "Graviton Carver", "Xenosteel", "Timebender Sword", "Astrostrike",
		                "Photon Blade", "Plasma Carver", "Nanospark Edge", "Graviton Edge", "Xenoblade",
		                "Timeflux Sword", "Ionicstrike Saber", "Chronostrike", "Astroblade", "Photon Carver",
		                "Plasma Saber", "Nanospark Edge", "Graviton Edge", "Xenoblade", "Timeflux Sword"
		            );
		            break;
		    }
		    break;
		case "axe":
		    switch (_genre) {
		        case "fantasy":
		            _weapon_name = choose(
		                "Warbringer", "Battlefury", "Axe of Titans", "Doomcleaver", "Skullsplitter",
		                "Stormbeard", "Frostbite", "Voidreaver", "Ragefire", "Thunderstrike",
		                "Soulcarver", "Runeaxe", "Dreadforge", "Executioner's Bite", "Bloodmoon",
		                "Frostrend", "Ironbark", "Bonecrusher", "Axe of Ruin", "Skysunder",
		                "Wraithcleaver", "Gorehowl", "Blazefury", "Ancient Waraxe", "Hellscream",
		                "Darkfury", "Ravenwing", "Doomsayer", "Mournblade", "Crimsoncleave",
		                "Abyssal Executioner", "Voidrender", "Skullcrusher", "Rageflame", "Thunderfury",
		                "Soulreaper", "Runesteel Axe", "Deathbringer", "Bloodfrost", "Frostbite",
		                "Ironrend", "Boneshatter", "Axe of Desolation", "Skullsmasher", "Wraithrender",
		                "Gorefang", "Blazeguard", "Ancient Battleaxe", "Hellslicer", "Darkcleave",
		                "Ravenshadow", "Doombringer", "Sorrowstrike", "Crimsonrend", "Abyssal Waraxe",
		                "Voidcleaver", "Skullsplitter", "Ragefire", "Thunderstrike", "Soulcarver",
		                "Runesteel Axe", "Dreadforge", "Executioner's Bite", "Bloodmoon", "Frostrend",
		                "Ironbark", "Bonecrusher", "Axe of Ruin", "Skysunder", "Wraithcleaver"
		            );
		            break;
		        case "modern":
		            _weapon_name = choose(
		                "Tactical Waraxe", "Assault Fury", "Breach Cleaver", "Rampage Axe", "Urban Shredder",
		                "Annihilator", "Predator's Bite", "Crimson Butcher", "Steelslayer", "Reaper's Grasp",
		                "Blackout Axe", "Ghostcleaver", "Tactical Executioner", "Silent Carnage", "Striker Axe",
		                "Venom Splitter", "Widowmaker", "Hawk's Butcher", "Cobra's Bite", "Silent Vanguard",
		                "Viper's Axe", "Wraithrender", "Spectre's Fury", "Steelskull", "Razorback Cleaver",
		                "Shadowstrike", "Wolfpack Axe", "Stealth Phantom", "Recon Viper", "Skyfall Shredder",
		                "Nightshade Butcher", "Eclipse Cleaver", "Stryker's Bite", "Sentinel's Grasp", "Rapidstrike",
		                "Hawkeye Axe", "Urban Slayer", "Nightstalker", "Ghostcleaver", "Blackout Shredder",
		                "Spectre's Axe", "Viper's Fury", "Silent Banshee", "Venom Splitter", "Widowmaker",
		                "Shadowstrike", "Assault Vanguard", "Wolfpack Axe", "Steelskull", "Razorback Cleaver",
		                "Nightfall Fury", "Skyfall Shredder", "Eclipse Grasp", "Hawkeye Axe", "Urban Slayer",
		                "Rapidstrike", "Stryker's Bite", "Sentinel's Grasp", "Nightshade Butcher", "Ghoststrike"
		            );
		            break;
		        case "sci fi":
		            _weapon_name = choose(
		                "Photon Axe", "Plasma Cleaver", "Nanotech Butcher", "Graviton Splitter", "Quantumstrike",
		                "Fusionsteel Axe", "Electroaxe", "Neutron Cleaver", "Quantum Cleaver", "Vortex Axe",
		                "Cosmicrender", "Proton Waraxe", "Xeno Cleaver", "Chrono Splitter", "Ionstorm Axe",
		                "Astrocleaver", "Particle Splitter", "Pulsar Waraxe", "Cyberstrike", "Voidrender",
		                "Galactic Butcher", "Starfire Cleaver", "Phaseaxe", "Novastrike", "Astrostrike",
		                "Quantum Waraxe", "Plasma Splitter", "Eventide Cleaver", "Eclipse Splitter", "Astronova Axe",
		                "Electroflux", "Vortexrender", "Nanofang", "Stellaris Cleaver", "Neuroaxe",
		                "Proton Waraxe", "Graviton Splitter", "Xenosteel", "Timebender Axe", "Astrostrike",
		                "Photon Waraxe", "Plasma Splitter", "Nanospark Cleaver", "Graviton Splitter", "Xenoblade",
		                "Timeflux Axe", "Ionicstrike Waraxe", "Chronostrike", "Astrocleaver", "Photon Splitter",
		                "Plasma Waraxe", "Nanospark Cleaver", "Graviton Splitter", "Xenoblade", "Timeflux Axe"
		            );
		            break;
		    }
		    break;
		case "mace":
		    switch (_genre) {
		        case "fantasy":
		            _weapon_name = choose(
		                "Hammer of Justice", "Warhammer", "Divine Maul", "Skullcrusher", "Lightbringer",
		                "Cyclone Mace", "Stoneforged Maul", "Doomhammer", "Frostbitten Mace", "Thunderstrike",
		                "Soulreaper", "Righteous Fury", "Giant's Bane", "Tidebreaker", "Oathkeeper",
		                "Darkwood Maul", "Dreadbringer", "Serpent's Strike", "Boneshatter", "Judgment",
		                "Warbringer", "Blessed Maul", "Hallowed Mallet", "Ebon Impact", "Windbreaker",
		                "Moonlight Mace", "Stellar Smasher", "Soulrender", "Runebreaker", "Skysplitter",
		                "Titanstrike", "Starsteel Maul", "Doomcaster", "Frostwind Hammer", "Thunderfury",
		                "Soulcrusher", "Righteous Wrath", "Giant's Heart", "Tidewarden", "Oathsworn",
		                "Shadowfury", "Dreadstrike", "Serpent's Embrace", "Boneshatter", "Verdict",
		                "Hammer of Legends", "Celestial Maul", "Voidcrusher", "Eclipse Mace", "Skyfall",
		                "Moonshadow Hammer", "Astral Maul", "Soulbinder", "Runesteel Mace", "Skysunder",
		                "Titan's Grip", "Starmetal Maul", "Doombringer", "Frost's Bite", "Thundercrush",
		                "Souldrainer", "Divine Punisher", "Giantbane", "Tidesplitter", "Oathbreaker",
		                "Darkfallen Mace", "Dread Doomhammer", "Serpent's Vengeance", "Bonecrusher", "Verdict",
		                "Hammer of the Ancients", "Blessed Mallet", "Hallowed Warhammer", "Ebonfall", "Windrender"
		            );
		            break;
		        case "modern":
		            _weapon_name = choose(
		                "Tactical Mace", "Assault Maul", "Breach Hammer", "Rampage Mallet", "Urban Warhammer",
		                "Annihilator", "Predator's Strike", "Crimson Mauler", "Steelsledge", "Reaper's Demise",
		                "Blackout Mace", "Ghostbreaker", "Tactical Maul", "Silent Carnage", "Striker Hammer",
		                "Venom Smasher", "Widow's Bite", "Hawk's Demolisher", "Cobra's Crush", "Silent Vanguard",
		                "Viper's Mace", "Wraithrender", "Spectre's Strike", "Steelskull", "Razorback Hammer",
		                "Shadowstrike", "Wolfpack Mallet", "Stealth Phantom", "Recon Viper", "Skyfall Smasher",
		                "Nightshade Mauler", "Eclipse Strike", "Stryker's Demolisher", "Sentinel's Demise", "Rapidstrike",
		                "Hawkeye Mace", "Urban Maul", "Nightstalker", "Ghostbreaker", "Blackout Warhammer",
		                "Spectre's Mace", "Viper's Strike", "Silent Banshee", "Venom Smasher", "Widow's Bite",
		                "Shadowstrike", "Assault Vanguard", "Wolfpack Mallet", "Steelskull", "Razorback Hammer",
		                "Nightfall Strike", "Skyfall Smasher", "Eclipse Demolisher", "Hawkeye Mace", "Urban Maul",
		                "Rapidstrike", "Stryker's Demolisher", "Sentinel's Demise", "Nightshade Mauler", "Ghoststrike"
		            );
		            break;
		        case "sci fi":
		            _weapon_name = choose(
		                "Photon Mace", "Plasma Hammer", "Nanotech Maul", "Graviton Strike", "Quantum Demolisher",
		                "Fusionsteel Mace", "Electrohammer", "Neutron Crush", "Quantum Crush", "Vortex Mallet",
		                "Cosmicrender", "Proton Mace", "Xeno Hammer", "Chrono Demolisher", "Ionstorm Mallet",
		                "Astrostrike", "Particle Hammer", "Pulsar Mace", "Cyberstrike", "Voidcrusher",
		                "Galactic Maul", "Starfire Hammer", "Phase Mallet", "Novastrike", "Astro Maul",
		                "Quantum Mace", "Plasma Crush", "Eventide Hammer", "Eclipse Mallet", "Astronova Mace",
		                "Electroflux", "Vortexrender", "Nanofang", "Stellaris Hammer", "Neurohammer",
		                "Proton Mace", "Graviton Strike", "Xenosteel", "Timebender Mallet", "Astro Maul",
		                "Photon Mace", "Plasma Crush", "Nanospark Hammer", "Graviton Strike", "Xenoblade",
		                "Timeflux Mallet", "Ionicstrike Mace", "Chronostrike", "Astrostrike", "Photon Crush",
		                "Plasma Mace", "Nanospark Hammer", "Graviton Strike", "Xenoblade", "Timeflux Mallet"
		            );
		            break;
		    }
		    break;
		case "pistol":
		    switch (_genre) {
		        case "fantasy":
		            _weapon_name = choose(
		                "Witch's Whisper", "Dragonfire", "Shadowcaster", "Viper's Kiss", "Moonlit Gaze",
		                "Stormbreaker", "Starfall", "Soulhunter", "Hellfire Revolver", "Thunderclap",
		                "Frostbite Pistol", "Nightshade", "Banshee's Howl", "Demon's Breath", "Rune Engraved",
		                "Duskblade", "Deathdealer", "Silvershooter", "Skysplitter", "Whisperwind",
		                "Eagle Eye", "Nightsong", "Serpent's Fang", "Stardust", "Phantom's Embrace",
		                "Doombringer", "Voidcannon", "Wraithstrike", "Shadowstrike", "Moonshadow",
		                "Thunderstrike", "Frostburst", "Soulreaper", "Ebonspire", "Windchill",
		                "Starflare", "Netherfire", "Deathwhisper", "Silent Seeker", "Banebringer",
		                "Rune Shot", "Abyssal Whisper", "Twilight's Grasp", "Dragon's Fury", "Stellar Shard",
		                "Phantom's Toll", "Deathpiercer", "Silvermoon", "Skypiercer", "Ghostfire",
		                "Shadowshot", "Moonfall", "Thunderclaw", "Frostfang", "Soulrender",
		                "Ebonfang", "Windreaver", "Starshot", "Netherspark", "Doomstinger",
		                "Voidseeker", "Wraithwalker", "Twilight's Shadow", "Drake's Breath", "Stardust",
		                "Phantom's Mercy", "Deathstalker", "Silent Shadow", "Baneblade", "Rune Carver",
		                "Abyssal Strike", "Twilight's Call", "Dragon's Bane", "Stellar Flare", "Phantom's Grace",
		                "Deathbringer", "Silverstrike", "Skyrender", "Ghostshade", "Shadowshriek",
		                "Moonshadow", "Thunderstrike", "Frostburst", "Soulreaper", "Ebonspire"
		            );
		            break;
		        case "modern":
		            _weapon_name = choose(
		                "Tactical Defender", "Stealthfire", "Rapid Vengeance", "Nightstalker", "Venomous",
		                "Assault Viper", "Silent Avenger", "Hawk's Gaze", "Cobra's Kiss", "Blackhawk",
		                "Ghostshot", "Shadow's Whisper", "Boltstrike", "Steelshroud", "Reaper's Whisper",
		                "Blackout Pistol", "Phantom's Edge", "Havoc Viper", "Rapidfire", "Venomstrike",
		                "Widowmaker", "Viper's Bite", "Silent Seeker", "Nightfall", "Stalker's Mark",
		                "Crimson Shade", "Shadow's Embrace", "Wolf's Fang", "Steelsight", "Razorback",
		                "Hawk's Eye", "Cobra's Fang", "Blackhawk", "Ghostshot", "Shadow's Whisper",
		                "Boltstrike", "Steelshroud", "Reaper's Whisper", "Blackout Pistol", "Phantom's Edge",
		                "Havoc Viper", "Rapidfire", "Venomstrike", "Widowmaker", "Viper's Bite",
		                "Silent Seeker", "Nightfall", "Stalker's Mark", "Crimson Shade", "Shadow's Embrace",
		                "Wolf's Fang", "Steelsight", "Razorback", "Hawk's Eye", "Cobra's Fang",
		                "Blackhawk", "Ghostshot", "Shadow's Whisper", "Boltstrike", "Steelshroud",
		                "Reaper's Whisper", "Blackout Pistol", "Phantom's Edge", "Havoc Viper", "Rapidfire"
		            );
		            break;
		        case "sci fi":
		            _weapon_name = choose(
		                "Photon Blaster", "Plasma Sidearm", "Nanotech Pistol", "Graviton Emitter", "Quantum Strike",
		                "Fusionsteel", "Electroshocker", "Neutron Disruptor", "Cosmic Burst", "Vortex Blaster",
		                "Astroscorch", "Proton Pistol", "Xeno Blaster", "Chrono Repeater", "Ionstorm",
		                "Astrofire", "Particle Sidearm", "Pulsar Blaster", "Cybercaster", "Voidcannon",
		                "Galactic Guardian", "Starfire Repeater", "Phase Blaster", "Novablaze", "Astro Blaster",
		                "Photon Blaster", "Plasma Sidearm", "Nanotech Pistol", "Graviton Emitter", "Quantum Strike",
		                "Fusionsteel", "Electroshocker", "Neutron Disruptor", "Cosmic Burst", "Vortex Blaster",
		                "Astroscorch", "Proton Pistol", "Xeno Blaster", "Chrono Repeater", "Ionstorm",
		                "Astrofire", "Particle Sidearm", "Pulsar Blaster", "Cybercaster", "Voidcannon",
		                "Galactic Guardian", "Starfire Repeater", "Phase Blaster", "Novablaze", "Astro Blaster",
		                "Photon Blaster", "Plasma Sidearm", "Nanotech Pistol", "Graviton Emitter", "Quantum Strike"
		            );
		            break;
		    }
		    break;
		case "rifle":
		    switch (_genre) {
		        case "fantasy":
		            _weapon_name = choose(
		                "Dragonsbane", "Stormbreaker", "Moonshadow", "Thunderstrike", "Frostwind",
		                "Soulreaper", "Windchaser", "Starflame", "Nightsorrow", "Shadowstrike",
		                "Dawnforged", "Voidseeker", "Phoenixfire", "Serpent's Bite", "Witch's Wail",
		                "Runesteel Rifle", "Celestial Guardian", "Boltcaster", "Skysplitter", "Skyfall",
		                "Ebonsteel", "Elven Longrifle", "Silvershot", "Moonfire", "Doomshot",
		                "Firestorm", "Shadowshot", "Windwhisper", "Netherbane", "Frostbite",
		                "Soulpiercer", "Starrunner", "Moonshard", "Thunderstrike", "Froststorm",
		                "Soulflare", "Starshooter", "Nightpiercer", "Shadowstrike", "Dawn's Light",
		                "Voidcaster", "Phoenix Wing", "Serpent's Fang", "Witchbane", "Runesteel Rifle",
		                "Celestial Guardian", "Boltcaster", "Skysplitter", "Skyfall", "Ebonsteel",
		                "Elven Longrifle", "Silvershot", "Moonfire", "Doomshot", "Firestorm",
		                "Shadowshot", "Windwhisper", "Netherbane", "Frostbite", "Soulpiercer",
		                "Starrunner", "Moonshard", "Thunderstrike", "Froststorm", "Soulflare",
		                "Starshooter", "Nightpiercer", "Shadowstrike", "Dawn's Light", "Voidcaster",
		                "Phoenix Wing", "Serpent's Fang", "Witchbane", "Runesteel Rifle", "Celestial Guardian"
		            );
		            break;
		        case "modern":
		            _weapon_name = choose(
		                "Tactical Annihilator", "Rapid Falcon", "Stealth Striker", "Silent Eagle", "Venom Viper",
		                "Hawk's Fury", "Cobra's Sting", "Nightshade", "Rapidfire", "Viper's Fang",
		                "Widowmaker", "Shadow's Gaze", "Steelshroud", "Reaper's Whisper", "Phantom's Embrace",
		                "Blackout Rifle", "Havoc Hawk", "Rapidfire", "Venomstrike", "Widowmaker",
		                "Viper's Fang", "Silent Seeker", "Nightfall", "Stalker's Mark", "Crimson Shade",
		                "Shadow's Embrace", "Wolf's Fang", "Steelsight", "Razorback", "Hawk's Eye",
		                "Cobra's Fang", "Nightshade", "Rapidfire", "Viper's Fang", "Widowmaker",
		                "Shadow's Gaze", "Steelshroud", "Reaper's Whisper", "Phantom's Embrace", "Blackout Rifle",
		                "Havoc Hawk", "Rapidfire", "Venomstrike", "Widowmaker", "Viper's Fang",
		                "Silent Seeker", "Nightfall", "Stalker's Mark", "Crimson Shade", "Shadow's Embrace",
		                "Wolf's Fang", "Steelsight", "Razorback", "Hawk's Eye", "Cobra's Fang",
		                "Nightshade", "Rapidfire", "Viper's Fang", "Widowmaker", "Shadow's Gaze",
		                "Steelshroud", "Reaper's Whisper", "Phantom's Embrace", "Blackout Rifle", "Havoc Hawk"
		            );
		            break;
		        case "sci fi":
		            _weapon_name = choose(
		                "Plasma Carbine", "Photon Rifle", "Quantum Blaster", "Nanotech Repeater", "Graviton Pulse",
		                "Fusionfire", "Astroscorch", "Neutron Rifle", "Vortex Disruptor", "Chrono Rifle",
		                "Ionstorm", "Xeno Rifle", "Astrofire", "Cosmic Shredder", "Pulsar Carbine",
		                "Galactic Guardian", "Starfire Repeater", "Nova Blaster", "Astro Blaster", "Plasma Carbine",
		                "Photon Rifle", "Quantum Blaster", "Nanotech Repeater", "Graviton Pulse", "Fusionfire",
		                "Astroscorch", "Neutron Rifle", "Vortex Disruptor", "Chrono Rifle", "Ionstorm",
		                "Xeno Rifle", "Astrofire", "Cosmic Shredder", "Pulsar Carbine", "Galactic Guardian",
		                "Starfire Repeater", "Nova Blaster", "Astro Blaster", "Plasma Carbine", "Photon Rifle",
		                "Quantum Blaster", "Nanotech Repeater", "Graviton Pulse", "Fusionfire", "Astroscorch",
		                "Neutron Rifle", "Vortex Disruptor", "Chrono Rifle", "Ionstorm", "Xeno Rifle",
		                "Astrofire", "Cosmic Shredder", "Pulsar Carbine", "Galactic Guardian", "Starfire Repeater",
		                "Nova Blaster", "Astro Blaster", "Plasma Carbine", "Photon Rifle", "Quantum Blaster",
		                "Nanotech Repeater", "Graviton Pulse", "Fusionfire", "Astroscorch", "Neutron Rifle",
		                "Vortex Disruptor", "Chrono Rifle", "Ionstorm", "Xeno Rifle", "Astrofire",
		                "Cosmic Shredder", "Pulsar Carbine", "Galactic Guardian", "Starfire Repeater", "Nova Blaster"
		            );
		            break;
		    }
		    break;
		case "heavy gun":
		    switch (_genre) {
		        case "fantasy":
		            _weapon_name = choose(
		                "Dwarven Minigun", "Goliath's Wrath", "Behemoth Cannon", "Dragonfire Artillery", "Titan's Roar",
		                "Soulcannon", "Stormbreaker", "Wyvern's Breath", "Froststorm Mortar", "Earthshaker",
		                "Voidcannon", "Phoenix Emberthrower", "Gorgon's Gaze", "Banshee's Howl", "Witch's Cauldron",
		                "Rune-forged Blaster", "Celestial Annihilator", "Starhammer", "Skysplitter Cannon", "Skyfall Devastator",
		                "Ebonsteel Destroyer", "Elven Ballista", "Silvershot Artillery", "Moonshadow Mortar", "Doomsday",
		                "Firestorm Launcher", "Shadowstrike Repeater", "Windwhisper Heavy Gun", "Netherbane Gatling", "Frostbite Crusher",
		                "Soulreaper Blaster", "Starrunner Cannon", "Moonshard Howitzer", "Thunderstrike Autocannon", "Frostwind Ballista",
		                "Soulflare Launcher", "Starshooter Artillery", "Nightpiercer Mortar", "Shadowstrike Devastator", "Dawnforged Annihilator",
		                "Voidseeker", "Phoenixfire Cannon", "Serpent's Breath", "Witch's Bane", "Rune-forged Blaster", "Celestial Annihilator",
		                "Starhammer", "Skysplitter Cannon", "Skyfall Devastator", "Ebonsteel Destroyer", "Elven Ballista",
		                "Silvershot Artillery", "Moonshadow Mortar", "Doomsday", "Firestorm Launcher", "Shadowstrike Repeater",
		                "Windwhisper Heavy Gun", "Netherbane Gatling", "Frostbite Crusher", "Soulreaper Blaster", "Starrunner Cannon",
		                "Moonshard Howitzer", "Thunderstrike Autocannon", "Frostwind Ballista", "Soulflare Launcher", "Starshooter Artillery",
		                "Nightpiercer Mortar", "Shadowstrike Devastator", "Dawnforged Annihilator", "Voidseeker", "Phoenixfire Cannon",
		                "Serpent's Breath", "Witch's Bane", "Rune-forged Blaster", "Celestial Annihilator", "Starhammer",
		                "Skysplitter Cannon", "Skyfall Devastator", "Ebonsteel Destroyer", "Elven Ballista", "Silvershot Artillery",
		                "Moonshadow Mortar", "Doomsday", "Firestorm Launcher", "Shadowstrike Repeater", "Windwhisper Heavy Gun",
		                "Netherbane Gatling", "Frostbite Crusher", "Soulreaper Blaster", "Starrunner Cannon", "Moonshard Howitzer",
		                "Thunderstrike Autocannon", "Frostwind Ballista", "Soulflare Launcher", "Starshooter Artillery", "Nightpiercer Mortar",
		                "Shadowstrike Devastator", "Dawnforged Annihilator", "Voidseeker", "Phoenixfire Cannon", "Serpent's Breath",
		                "Witch's Bane"
		            );
		            break;
		        case "modern":
		            _weapon_name = choose(
		                "Tactical Annihilator", "Rapid Falcon", "Stealth Striker", "Silent Eagle", "Venom Viper",
		                "Hawk's Fury", "Cobra's Sting", "Nightshade Heavy Gun", "Rapidfire Minigun", "Viper's Fang",
		                "Widowmaker Artillery", "Shadow's Gaze", "Steelshroud", "Reaper's Whisper", "Phantom's Embrace",
		                "Blackout Heavy Gun", "Havoc Hawk", "Rapidfire Minigun", "Venomstrike Cannon", "Widowmaker Artillery",
		                "Viper's Fang", "Silent Seeker", "Nightfall Mortar", "Stalker's Mark", "Crimson Shade",
		                "Shadow's Embrace", "Wolf's Fang", "Steelsight", "Razorback Cannon", "Hawk's Eye",
		                "Cobra's Fang", "Nightshade Heavy Gun", "Rapidfire Minigun", "Viper's Fang", "Widowmaker Artillery",
		                "Shadow's Gaze", "Steelshroud", "Reaper's Whisper", "Phantom's Embrace", "Blackout Heavy Gun",
		                "Havoc Hawk", "Rapidfire Minigun", "Venomstrike Cannon", "Widowmaker Artillery", "Viper's Fang",
		                "Silent Seeker", "Nightfall Mortar", "Stalker's Mark", "Crimson Shade", "Shadow's Embrace",
		                "Wolf's Fang", "Steelsight", "Razorback Cannon", "Hawk's Eye", "Cobra's Fang",
		                "Nightshade Heavy Gun", "Rapidfire Minigun", "Viper's Fang", "Widowmaker Artillery", "Shadow's Gaze",
		                "Steelshroud", "Reaper's Whisper", "Phantom's Embrace", "Blackout Heavy Gun", "Havoc Hawk"
		            );
		            break;
		        case "sci fi":
		            _weapon_name = choose(
		                "Plasma Minigun", "Photon Cannon", "Quantum Annihilator", "Nanotech Devastator", "Graviton Mortar",
		                "Fusionfire Artillery", "Astroscorch Heavy Gun", "Neutron Blaster", "Vortex Cannon", "Chrono Minigun",
		                "Ionstorm Artillery", "Xeno Annihilator", "Astrofire Cannon", "Cosmic Shredder", "Pulsar Heavy Gun",
		                "Galactic Guardian", "Starfire Minigun", "Nova Cannon", "Astro Blaster", "Plasma Minigun",
		                "Photon Cannon", "Quantum Annihilator", "Nanotech Devastator", "Graviton Mortar", "Fusionfire Artillery",
		                "Astroscorch Heavy Gun", "Neutron Blaster", "Vortex Cannon", "Chrono Minigun", "Ionstorm Artillery",
		                "Xeno Annihilator", "Astrofire Cannon", "Cosmic Shredder", "Pulsar Heavy Gun", "Galactic Guardian",
		                "Starfire Minigun", "Nova Cannon", "Astro Blaster", "Plasma Minigun", "Photon Cannon",
		                "Quantum Annihilator", "Nanotech Devastator", "Graviton Mortar", "Fusionfire Artillery", "Astroscorch Heavy Gun",
		                "Neutron Blaster", "Vortex Cannon", "Chrono Minigun", "Ionstorm Artillery", "Xeno Annihilator",
		                "Astrofire Cannon", "Cosmic Shredder", "Pulsar Heavy Gun", "Galactic Guardian", "Starfire Minigun",
		                "Nova Cannon", "Astro Blaster", "Plasma Minigun", "Photon Cannon", "Quantum Annihilator",
		                "Nanotech Devastator", "Graviton Mortar", "Fusionfire Artillery", "Astroscorch Heavy Gun", "Neutron Blaster",
		                "Vortex Cannon", "Chrono Minigun", "Ionstorm Artillery", "Xeno Annihilator", "Astrofire Cannon",
		                "Cosmic Shredder", "Pulsar Heavy Gun", "Galactic Guardian", "Starfire Minigun", "Nova Cannon"
		            );
		            break;
		    }
		    break;
		case "thrower":
		    switch (_genre) {
		        case "fantasy":
		            _weapon_name = choose(
		                "Inferno Flamethrower", "Wyvern's Breath Blaster", "Frostbite Frost Cannon", "Thunderstorm Tesla Sprayer", "Venom Viper Acid Spewer",
		                "Gorgon's Gaze Petrifier", "Celestial Starfire Emitter", "Soulflame Soul Devourer", "Aqua Serpent Water Jet", "Stormcaller Cyclone Cannon",
		                "Earthshaker Tremor Thrower", "Darkfire Shadow Eradicator", "Solar Flare Solarbeam Spout", "Netherbane Dark Matter Discharger", "Windwhisper Gale Gust Cannon",
		                "Pyroclasm Flame Vortex Spitter", "Blizzard Brimstone Blaster", "Volt Surge Lightning Zapper", "Venomfang Acidic Nozzle", "Tornado Tempest Twister",
		                "Seismic Quake Rumbler", "Shadowburn Void Tearer", "Stellar Flare Starburst Emitter", "Soulreaper Soul Harvester", "Hydra Hydro Pressurizer",
		                "Tempest Storm Squall Cannon", "Terraquake Tremor Emitter", "Darkvoid Shadow Vanquisher", "Helios Solar Incinerator", "Abyssal Void Darkener",
		                "Zephyr Gale Gust Emitter", "Pyroclasm Flame Vortex Spitter", "Blizzard Brimstone Blaster", "Volt Surge Lightning Zapper", "Venomfang Acidic Nozzle",
		                "Tornado Tempest Twister", "Seismic Quake Rumbler", "Shadowburn Void Tearer", "Stellar Flare Starburst Emitter", "Soulreaper Soul Harvester",
		                "Hydra Hydro Pressurizer", "Tempest Storm Squall Cannon", "Terraquake Tremor Emitter", "Darkvoid Shadow Vanquisher", "Helios Solar Incinerator",
		                "Abyssal Void Darkener", "Zephyr Gale Gust Emitter", "Pyroclasm Flame Vortex Spitter", "Blizzard Brimstone Blaster", "Volt Surge Lightning Zapper",
		                "Venomfang Acidic Nozzle", "Tornado Tempest Twister", "Seismic Quake Rumbler", "Shadowburn Void Tearer", "Stellar Flare Starburst Emitter",
		                "Soulreaper Soul Harvester", "Hydra Hydro Pressurizer", "Tempest Storm Squall Cannon", "Terraquake Tremor Emitter", "Darkvoid Shadow Vanquisher",
		                "Helios Solar Incinerator", "Abyssal Void Darkener", "Zephyr Gale Gust Emitter", "Pyroclasm Flame Vortex Spitter", "Blizzard Brimstone Blaster",
		                "Volt Surge Lightning Zapper", "Venomfang Acidic Nozzle", "Tornado Tempest Twister", "Seismic Quake Rumbler", "Shadowburn Void Tearer",
		                "Stellar Flare Starburst Emitter", "Soulreaper Soul Harvester", "Hydra Hydro Pressurizer", "Tempest Storm Squall Cannon", "Terraquake Tremor Emitter",
		                "Darkvoid Shadow Vanquisher", "Helios Solar Incinerator", "Abyssal Void Darkener", "Zephyr Gale Gust Emitter", "Pyroclasm Flame Vortex Spitter",
		                "Blizzard Brimstone Blaster", "Volt Surge Lightning Zapper", "Venomfang Acidic Nozzle", "Tornado Tempest Twister", "Seismic Quake Rumbler",
		                "Shadowburn Void Tearer", "Stellar Flare Starburst Emitter", "Soulreaper Soul Harvester", "Hydra Hydro Pressurizer", "Tempest Storm Squall Cannon",
		                "Terraquake Tremor Emitter", "Darkvoid Shadow Vanquisher", "Helios Solar Incinerator", "Abyssal Void Darkener", "Zephyr Gale Gust Emitter"
		            );
		            break;
		        case "modern":
		            _weapon_name = choose(
		                "Blaze-X Flamethrower", "Torrential Aqua Cannon", "Lightning Storm Tesla Thrower", "Corrosion Acid Spreader", "Hurricane Gust Cannon",
		                "Shadowburn Shadow Igniter", "Plasmaflux Heat Emitter", "Soulvapor Soul Extractor", "Riptide Water Blaster", "Cyclone Cyclone Blaster",
		                "Seismic Tremor Generator", "Darkvoid Shadow Discharger", "Solar Flare Solar Incinerator", "Abyssal Dark Matter Disperser", "Galeforce Gust Emitter",
		                "Blaze-X Flamethrower", "Torrential Aqua Cannon", "Lightning Storm Tesla Thrower", "Corrosion Acid Spreader", "Hurricane Gust Cannon",
		                "Shadowburn Shadow Igniter", "Plasmaflux Heat Emitter", "Soulvapor Soul Extractor", "Riptide Water Blaster", "Cyclone Cyclone Blaster",
		                "Seismic Tremor Generator", "Darkvoid Shadow Discharger", "Solar Flare Solar Incinerator", "Abyssal Dark Matter Disperser", "Galeforce Gust Emitter",
		                "Blaze-X Flamethrower", "Torrential Aqua Cannon", "Lightning Storm Tesla Thrower", "Corrosion Acid Spreader", "Hurricane Gust Cannon",
		                "Shadowburn Shadow Igniter", "Plasmaflux Heat Emitter", "Soulvapor Soul Extractor", "Riptide Water Blaster", "Cyclone Cyclone Blaster",
		                "Seismic Tremor Generator", "Darkvoid Shadow Discharger", "Solar Flare Solar Incinerator", "Abyssal Dark Matter Disperser", "Galeforce Gust Emitter",
		                "Blaze-X Flamethrower", "Torrential Aqua Cannon", "Lightning Storm Tesla Thrower", "Corrosion Acid Spreader", "Hurricane Gust Cannon",
		                "Shadowburn Shadow Igniter", "Plasmaflux Heat Emitter", "Soulvapor Soul Extractor", "Riptide Water Blaster", "Cyclone Cyclone Blaster",
		                "Seismic Tremor Generator", "Darkvoid Shadow Discharger", "Solar Flare Solar Incinerator", "Abyssal Dark Matter Disperser", "Galeforce Gust Emitter"
		            );
		            break;
		        case "sci fi":
		            _weapon_name = choose(
		                "Plasmaflame Flamethrower", "Electro Aqua Cannon", "Quantum Thunder Tesla Emitter", "Acidic Corrosion Spewer", "Galactic Gust Cannon",
		                "Dark Matter Shadowburner", "Photon Starflare Emitter", "Void Soul Extractor", "Nanotech Waterjet", "Temporal Cyclone Blaster",
		                "Graviton Tremor Generator", "Nanotech Shadow Discharger", "Solar Flare Solar Incinerator", "Graviton Dark Matter Disperser", "Photon Gale Gust Emitter",
		                "Plasmaflame Flamethrower", "Electro Aqua Cannon", "Quantum Thunder Tesla Emitter", "Acidic Corrosion Spewer", "Galactic Gust Cannon",
		                "Dark Matter Shadowburner", "Photon Starflare Emitter", "Void Soul Extractor", "Nanotech Waterjet", "Temporal Cyclone Blaster",
		                "Graviton Tremor Generator", "Nanotech Shadow Discharger", "Solar Flare Solar Incinerator", "Graviton Dark Matter Disperser", "Photon Gale Gust Emitter",
		                "Plasmaflame Flamethrower", "Electro Aqua Cannon", "Quantum Thunder Tesla Emitter", "Acidic Corrosion Spewer", "Galactic Gust Cannon",
		                "Dark Matter Shadowburner", "Photon Starflare Emitter", "Void Soul Extractor", "Nanotech Waterjet", "Temporal Cyclone Blaster",
		                "Graviton Tremor Generator", "Nanotech Shadow Discharger", "Solar Flare Solar Incinerator", "Graviton Dark Matter Disperser", "Photon Gale Gust Emitter",
		                "Plasmaflame Flamethrower", "Electro Aqua Cannon", "Quantum Thunder Tesla Emitter", "Acidic Corrosion Spewer", "Galactic Gust Cannon",
		                "Dark Matter Shadowburner", "Photon Starflare Emitter", "Void Soul Extractor", "Nanotech Waterjet", "Temporal Cyclone Blaster",
		                "Graviton Tremor Generator", "Nanotech Shadow Discharger", "Solar Flare Solar Incinerator", "Graviton Dark Matter Disperser", "Photon Gale Gust Emitter"
		            );
		            break;
		    }
		    break;
		case "launcher":
		    switch (_genre) {
		        case "fantasy":
		            _weapon_name = choose(
		                "Dragonfire Launcher", "Phoenix Wing Blaster", "Frostbite Icebreaker", "Thunderstrike Cannon", "Venomspitter",
		                "Gorgon's Gaze Launcher", "Celestial Comet Blaster", "Soulshatterer", "Aqua Serpent Launcher", "Stormcaller Tempest",
		                "Earthshaker Cannon", "Darkfire Obliterator", "Solarflare Rocketeer", "Netherbane Annihilator", "Windwhisper Cyclone",
		                "Stellarflare Supernova", "Soulreaper Desolator", "Hydra Hydrofury", "Tempest Fury Cannon", "Terraquake Earthshaker",
		                "Darkvoid Abyss", "Helios Sunflare", "Abyssal Devastator", "Zephyr Skyfall", "Dragonfire Launcher", "Phoenix Wing Blaster",
		                "Frostbite Icebreaker", "Thunderstrike Cannon", "Venomspitter", "Gorgon's Gaze Launcher", "Celestial Comet Blaster",
		                "Soulshatterer", "Aqua Serpent Launcher", "Stormcaller Tempest", "Earthshaker Cannon", "Darkfire Obliterator",
		                "Solarflare Rocketeer", "Netherbane Annihilator", "Windwhisper Cyclone", "Stellarflare Supernova", "Soulreaper Desolator",
		                "Hydra Hydrofury", "Tempest Fury Cannon", "Terraquake Earthshaker", "Darkvoid Abyss", "Helios Sunflare",
		                "Abyssal Devastator", "Zephyr Skyfall", "Dragonfire Launcher", "Phoenix Wing Blaster", "Frostbite Icebreaker",
		                "Thunderstrike Cannon", "Venomspitter", "Gorgon's Gaze Launcher", "Celestial Comet Blaster", "Soulshatterer",
		                "Aqua Serpent Launcher", "Stormcaller Tempest", "Earthshaker Cannon", "Darkfire Obliterator", "Solarflare Rocketeer",
		                "Netherbane Annihilator", "Windwhisper Cyclone", "Stellarflare Supernova", "Soulreaper Desolator", "Hydra Hydrofury",
		                "Tempest Fury Cannon", "Terraquake Earthshaker", "Darkvoid Abyss", "Helios Sunflare", "Abyssal Devastator",
		                "Zephyr Skyfall", "Dragonfire Launcher", "Phoenix Wing Blaster", "Frostbite Icebreaker", "Thunderstrike Cannon",
		                "Venomspitter", "Gorgon's Gaze Launcher", "Celestial Comet Blaster", "Soulshatterer", "Aqua Serpent Launcher",
		                "Stormcaller Tempest", "Earthshaker Cannon", "Darkfire Obliterator", "Solarflare Rocketeer", "Netherbane Annihilator",
		                "Windwhisper Cyclone", "Stellarflare Supernova", "Soulreaper Desolator", "Hydra Hydrofury", "Tempest Fury Cannon",
		                "Terraquake Earthshaker", "Darkvoid Abyss", "Helios Sunflare", "Abyssal Devastator", "Zephyr Skyfall"
		            );
		            break;
		        case "modern":
		            _weapon_name = choose(
		                "Scorch-X Launcher", "Torrential Cannon", "Thunderclap Missile", "Venomstrike Launcher", "Rapidfire",
		                "Shadowstrike Blaster", "Plasmaflame Rocket", "Soulcrusher", "Riptide Launcher", "Cyclone Cannon",
		                "Seismic Tremor Launcher", "Darkshadow Destructor", "Solarburst Rocket", "Abyssal Annihilator", "Galeforce",
		                "Scorch-X Launcher", "Torrential Cannon", "Thunderclap Missile", "Venomstrike Launcher", "Rapidfire",
		                "Shadowstrike Blaster", "Plasmaflame Rocket", "Soulcrusher", "Riptide Launcher", "Cyclone Cannon",
		                "Seismic Tremor Launcher", "Darkshadow Destructor", "Solarburst Rocket", "Abyssal Annihilator", "Galeforce",
		                "Scorch-X Launcher", "Torrential Cannon", "Thunderclap Missile", "Venomstrike Launcher", "Rapidfire",
		                "Shadowstrike Blaster", "Plasmaflame Rocket", "Soulcrusher", "Riptide Launcher", "Cyclone Cannon",
		                "Seismic Tremor Launcher", "Darkshadow Destructor", "Solarburst Rocket", "Abyssal Annihilator", "Galeforce",
		                "Scorch-X Launcher", "Torrential Cannon", "Thunderclap Missile", "Venomstrike Launcher", "Rapidfire",
		                "Shadowstrike Blaster", "Plasmaflame Rocket", "Soulcrusher", "Riptide Launcher", "Cyclone Cannon",
		                "Seismic Tremor Launcher", "Darkshadow Destructor", "Solarburst Rocket", "Abyssal Annihilator", "Galeforce"
		            );
		            break;
		        case "sci fi":
		            _weapon_name = choose(
		                "Plasmafire Launcher", "Electro Cannon", "Quantum Missile", "Acidic Venom Launcher", "Galactic Rapidfire",
		                "Dark Matter Shadowstrike", "Photon Blaster", "Void Devastator", "Nanotech Riptide Launcher", "Temporal Cyclone Cannon",
		                "Graviton Tremor Launcher", "Nanotech Darkshadow Destructor", "Solar Flare Rocket", "Graviton Abyssal Annihilator", "Photon Galeforce",
		                "Plasmafire Launcher", "Electro Cannon", "Quantum Missile", "Acidic Venom Launcher", "Galactic Rapidfire",
		                "Dark Matter Shadowstrike", "Photon Blaster", "Void Devastator", "Nanotech Riptide Launcher", "Temporal Cyclone Cannon",
		                "Graviton Tremor Launcher", "Nanotech Darkshadow Destructor", "Solar Flare Rocket", "Graviton Abyssal Annihilator", "Photon Galeforce",
		                "Plasmafire Launcher", "Electro Cannon", "Quantum Missile", "Acidic Venom Launcher", "Galactic Rapidfire",
		                "Dark Matter Shadowstrike", "Photon Blaster", "Void Devastator", "Nanotech Riptide Launcher", "Temporal Cyclone Cannon",
		                "Graviton Tremor Launcher", "Nanotech Darkshadow Destructor", "Solar Flare Rocket", "Graviton Abyssal Annihilator", "Photon Galeforce",
		                "Plasmafire Launcher", "Electro Cannon", "Quantum Missile", "Acidic Venom Launcher", "Galactic Rapidfire",
		                "Dark Matter Shadowstrike", "Photon Blaster", "Void Devastator", "Nanotech Riptide Launcher", "Temporal Cyclone Cannon",
		                "Graviton Tremor Launcher", "Nanotech Darkshadow Destructor", "Solar Flare Rocket", "Graviton Abyssal Annihilator", "Photon Galeforce"
		            );
		            break;
		    }
		    break;
        default:
            _weapon_name = "Unknown Weapon";
            break;
    }
    
    return _weapon_name;
}
