/// @description Generate a random name for a location.
/// @function random_name_generator_location
/// @param type - The type of location ("country", "town", "planet", "moon", "star", "building", "neighbourhood", "battlefield").
/// @param genre - The genre of the location ("fantasy", "modern", "sci fi").
/// @returns The generated name as a string.
function random_name_generator_location(_type, _genre) {
    var _name;
    
    // Randomly select a name based on the location type and genre.
    switch (_type) {
		case "country":
		    switch (_genre) {
		        case "fantasy":
		            _name = choose(
		                "Valeria", "Eldoria", "Aetheria", "Drakoria", "Silvaris", "Mythria", "Glimmera", "Thundoria",
		                "Verdania", "Feyoria", "Crestoria", "Hallowind", "Stellara", "Elentia", "Sylvora", "Islevale",
		                "Runewind", "Duskhaven", "Avaloria", "Emberon", "Starfallen", "Shadowmere", "Celestria", "Lorendale",
		                "Elderwood", "Dawnkeep", "Skylandia", "Mistborne", "Aurorion", "Gloomsilver", "Hawthorne", "Mirthwind",
		                "Valeria", "Eldoria", "Aetheria", "Drakoria", "Silvaris", "Mythria", "Glimmera", "Thundoria",
		                "Verdania", "Feyoria", "Crestoria", "Hallowind", "Stellara", "Elentia", "Sylvora", "Islevale",
		                "Runewind", "Duskhaven", "Avaloria", "Emberon", "Starfallen", "Shadowmere", "Celestria", "Lorendale",
		                "Elderwood", "Dawnkeep", "Skylandia", "Mistborne", "Aurorion", "Gloomsilver", "Hawthorne", "Mirthwind",
		                "Valeria", "Eldoria", "Aetheria", "Drakoria", "Silvaris", "Mythria", "Glimmera", "Thundoria"
		            );
		            break;
		        case "modern":
		            _name = choose(
		                "Libertyland", "Harmonia", "Prosperia", "Evermere", "New Horizons", "Unity Republic", "Innovia", "Tranquilisia",
		                "Prospera", "Elysia", "Vistaoria", "Harmony Isles", "Tranquilitia", "New Crestland", "Verdania", "Civicland",
		                "Frontieria", "Astonia", "Eudora", "New Harmonia", "Pacificana", "Horizon Reach", "Crestville", "Vivacity",
		                "Libertyland", "Harmonia", "Prosperia", "Evermere", "New Horizons", "Unity Republic", "Innovia", "Tranquilisia",
		                "Prospera", "Elysia", "Vistaoria", "Harmony Isles", "Tranquilitia", "New Crestland", "Verdania", "Civicland",
		                "Frontieria", "Astonia", "Eudora", "New Harmonia", "Pacificana", "Horizon Reach", "Crestville", "Vivacity",
		                "Libertyland", "Harmonia", "Prosperia", "Evermere", "New Horizons", "Unity Republic", "Innovia", "Tranquilisia"
		            );
		            break;
		        case "sci fi":
		            _name = choose(
		                "Stellaris Prime", "Astoria-9", "Nexon Empire", "Galacticon-7", "Alpha Centuria", "Celestara", "Cosmara", "Orion Dominion",
		                "Nebulon-X", "Novaris Nexus", "Zypheria", "Hyperion-IX", "Astron Prime", "Xenovia Core", "Quantum Federation", "Nebula Reach",
		                "Starbound Dominion", "Astrotopia", "Galactia Major", "Lunarion-7", "Celestial Union", "Nexar-9", "Orbitalis-7", "Voyager's End",
		                "Stellaris Prime", "Astoria-9", "Nexon Empire", "Galacticon-7", "Alpha Centuria", "Celestara", "Cosmara", "Orion Dominion",
		                "Nebulon-X", "Novaris Nexus", "Zypheria", "Hyperion-IX", "Astron Prime", "Xenovia Core", "Quantum Federation", "Nebula Reach",
		                "Starbound Dominion", "Astrotopia", "Galactia Major", "Lunarion-7", "Celestial Union", "Nexar-9", "Orbitalis-7", "Voyager's End",
		                "Stellaris Prime", "Astoria-9", "Nexon Empire", "Galacticon-7", "Alpha Centuria", "Celestara", "Cosmara", "Orion Dominion"
		            );
		            break;
		    }
		    break;
        case "town":
		    switch (_genre) {
		        case "fantasy":
		            _name = choose(
		                "Oakendale", "Wildehaven", "Frostholm", "Mysthollow", "Dragonreach", "Elmspire", "Silverbrook", "Havenmoor",
		                "Thornwood", "Moonshire", "Ravenhold", "Duskwood", "Brightmeadow", "Fairgate", "Starfall", "Dewbourne",
		                "Moonshadow", "Glimmering", "Whisperwind", "Stormholm", "Fae Haven", "Elven Glade", "Dragon's Roost", "Thornvale",
		                "Aurora", "Verdantis", "Emberreach", "Drakoria", "Lunaria", "Celestis", "Nyxara", "Mystica",
		                "Thornala", "Auroria", "Embera", "Verdanis", "Twilight", "Eluna", "Serenara", "Duska",
		                "Starglow", "Nyxus", "Glimmera", "Starwing", "Thundoria", "Glimmera", "Brightwater", "Silvermoor",
		                "Eldoria", "Mythralia", "Arcadia", "Glimmeron", "Lumina", "Thundoria", "Aurora", "Ebonex",
		                "Nyxus", "Zephyria", "Havenora", "Eldoria", "Mythralia", "Verdantis", "Arcadia", "Aetheria",
		                "Glimmeron", "Celestoria", "Emberon", "Lumina", "Drakoria", "Thundoria", "Aurora", "Ebonex",
		                "Nyxus", "Zephyria", "Havenora", "Eldoria", "Mythralia", "Verdantis", "Arcadia", "Aetheria",
		                "Glimmeron", "Celestoria", "Emberon", "Lumina", "Drakoria", "Thundoria", "Aurora", "Ebonex",
		                "Nyxus", "Zephyria", "Havenora"
		            );
		            break;
		        case "modern":
		            _name = choose(
		                "Greenview", "Harborville", "Oakwood", "Pinecrest", "Maplebrook", "Riverdale", "Sunnydale", "Highland",
		                "Brookside", "Hillcrest", "Fairview", "Springfield", "Windsor", "Cedarville", "Lakewood", "Willowbrook",
		                "Harmony", "Pulse", "Vista", "Evergreen", "Unity", "Solstice", "Oasis", "Utopia",
		                "Genesis", "Skyline", "Pinnacle", "New Horizons", "Horizon", "EcoSphere", "Haven", "Harmony",
		                "Pulse", "Vista", "Evergreen", "Unity", "Solstice", "Oasis", "Utopia", "Genesis",
		                "Skyline", "Pinnacle", "New Horizons", "Horizon", "EcoSphere", "Haven", "Harmony", "Pulse",
		                "Vista", "Evergreen", "Unity", "Solstice", "Oasis", "Utopia", "Genesis", "Skyline",
		                "Pinnacle", "New Horizons", "Horizon", "EcoSphere", "Haven", "Harmony", "Pulse", "Vista",
		                "Evergreen", "Unity", "Solstice", "Oasis", "Utopia", "Genesis", "Skyline", "Pinnacle",
		                "New Horizons", "Horizon", "EcoSphere", "Haven", "Harmony", "Pulse", "Vista", "Evergreen",
		                "Unity", "Solstice", "Oasis", "Utopia", "Genesis", "Skyline", "Pinnacle", "New Horizons"
		            );
		            break;
		        case "sci fi":
		            _name = choose(
		                "Astron", "Nova Prime", "Cosmara", "Stellaris", "Galaxia", "Orbix", "Eclipse", "Hyperion",
		                "Nexopolis", "Quantum", "Celestia", "Starhaven", "Omnitron", "Skyridge", "Solara", "Astropolis",
		                "Nebulon", "Stellara", "Zeron", "Andromeda", "Luminara", "Xeron", "Proxima", "Umbra",
		                "Quasara", "Orion-7", "Nexara", "Alpha Prime", "Omega 9", "Astrum", "Centauri", "Nebulon",
		                "Stellara", "Zeron", "Andromeda", "Luminara", "Xeron", "Proxima", "Umbra", "Quasara",
		                "Orion-7", "Nexara", "Alpha Prime", "Omega 9", "Astrum", "Centauri", "Nebulon", "Stellara",
		                "Zeron", "Andromeda", "Luminara", "Xeron", "Proxima", "Umbra", "Quasara", "Orion-7",
		                "Nexara", "Alpha Prime", "Omega 9", "Astrum", "Centauri", "Nebulon", "Stellara", "Zeron",
		                "Andromeda", "Luminara", "Xeron", "Proxima", "Umbra", "Quasara", "Orion-7", "Nexara",
		                "Alpha Prime", "Omega 9", "Astrum", "Centauri", "Nebulon", "Stellara", "Zeron", "Andromeda"
		            );
		            break;
		    }
		    break;
        case "planet":
		    switch (_genre) {
		        case "fantasy":
		            _name = choose(
		                "Astralor", "Verdania", "Elysium", "Mythrend", "Celestara", "Nyxora", "Lunaris", "Faeloria",
		                "Auroria", "Zephyria", "Thornara", "Drakoria", "Glimmeron", "Solara", "Emberon", "Nyxara",
		                "Aurora", "Verdantis", "Emberreach", "Drakoria", "Lunaria", "Celestis", "Nyxara", "Mystica",
		                "Thornala", "Auroria", "Embera", "Verdanis", "Twilight", "Eluna", "Serenara", "Duska",
		                "Starglow", "Nyxus", "Glimmera", "Starwing", "Thundoria", "Glimmera", "Brightwater", "Silvermoor",
		                "Eldoria", "Mythralia", "Arcadia", "Glimmeron", "Lumina", "Thundoria", "Aurora", "Ebonex",
		                "Nyxus", "Zephyria", "Havenora", "Eldoria", "Mythralia", "Verdantis", "Arcadia", "Aetheria",
		                "Glimmeron", "Celestoria", "Emberon", "Lumina", "Drakoria", "Thundoria", "Aurora", "Ebonex",
		                "Nyxus", "Zephyria", "Havenora", "Eldoria", "Mythralia", "Verdantis", "Arcadia", "Aetheria",
		                "Glimmeron", "Celestoria", "Emberon", "Lumina", "Drakoria", "Thundoria", "Aurora", "Ebonex",
		                "Nyxus", "Zephyria", "Havenora"
		            );
		            break;
		        case "modern":
		            _name = choose(
		                "Terranova", "Aurorium", "Novus", "Ecosphere", "Utopia", "Genesis", "Everstar", "Horizon",
		                "Harmony", "Pulse", "Vista", "Skylight", "Eclipse", "Serenity", "Solstice", "Oasis",
		                "Pantheon", "Elysia", "Aurora", "Verdantis", "Emerald", "Luminara", "Stellara", "Zephyria",
		                "Andromeda", "Nebula", "Erebus", "Celestia", "Astralis", "Zenith", "Lunaria", "Pandora",
		                "Nova", "Olympia", "Thalassa", "Aetheria", "Horizon", "Icaria", "Seraphis", "Eldoria",
		                "Zephyria", "Equinox", "Avalon", "Nexara", "Tranquility", "Veridian", "Proxima", "Elysium",
		                "New Haven", "Galactia", "Nyxara", "Stellara", "Horizon", "Orion-7", "Nexara", "Alpha Prime",
		                "Omega 9", "Astrum", "Centauri", "Nebulon", "Stellara", "Zeron", "Andromeda", "Luminara",
		                "Xeron", "Proxima", "Umbra", "Quasara", "Orion-7", "Nexara", "Alpha Prime", "Omega 9"
		            );
		            break;
		        case "sci fi":
		            _name = choose(
		                "Astron", "Nova Prime", "Cosmara", "Stellaris", "Galaxia", "Orbix", "Eclipse", "Hyperion",
		                "Nexopolis", "Quantum", "Celestia", "Starhaven", "Omnitron", "Skyridge", "Solara", "Astropolis",
		                "Nebulon", "Stellara", "Zeron", "Andromeda", "Luminara", "Xeron", "Proxima", "Umbra",
		                "Quasara", "Orion-7", "Nexara", "Alpha Prime", "Omega 9", "Astrum", "Centauri", "Nebulon",
		                "Stellara", "Zeron", "Andromeda", "Luminara", "Xeron", "Proxima", "Umbra", "Quasara",
		                "Orion-7", "Nexara", "Alpha Prime", "Omega 9", "Astrum", "Centauri", "Nebulon", "Stellara",
		                "Zeron", "Andromeda", "Luminara", "Xeron", "Proxima", "Umbra", "Quasara", "Orion-7",
		                "Nexara", "Alpha Prime", "Omega 9", "Astrum", "Centauri", "Nebulon", "Stellara", "Zeron",
		                "Andromeda", "Luminara", "Xeron", "Proxima", "Umbra", "Quasara", "Orion-7", "Nexara",
		                "Alpha Prime", "Omega 9", "Astrum", "Centauri", "Nebulon", "Stellara", "Zeron", "Andromeda"
		            );
		            break;
		    }
		    break;
        case "moon":
		    switch (_genre) {
		        case "fantasy":
		            _name = choose(
		                "Lunaris", "Celestria", "Auroril", "Nyxaris", "Thornmoon", "Drakoria", "Glimmera", "Starglow",
		                "Nyxus", "Silvermoor", "Eldoria", "Mythrend", "Glimmeron", "Duskmere", "Stellaire", "Emberon",
		                "Luminara", "Thundoria", "Aurora", "Ebonex", "Zephyria", "Havenora", "Verdantis", "Arcadia",
		                "Aetheria", "Celestoria", "Starwing", "Mythralia", "Nyxara", "Mystica", "Lunara", "Elunaria",
		                "Glimmera", "Starglow", "Nyxus", "Silvermoor", "Eldoria", "Mythrend", "Glimmeron", "Duskmere",
		                "Stellaire", "Emberon", "Luminara", "Thundoria", "Aurora", "Ebonex", "Zephyria", "Havenora",
		                "Verdantis", "Arcadia", "Aetheria", "Celestoria", "Starwing", "Mythralia", "Nyxara", "Mystica",
		                "Lunara", "Elunaria", "Glimmera", "Starglow", "Nyxus", "Silvermoor", "Eldoria", "Mythrend",
		                "Glimmeron", "Duskmere", "Stellaire", "Emberon", "Luminara", "Thundoria", "Aurora", "Ebonex",
		                "Zephyria", "Havenora", "Verdantis", "Arcadia", "Aetheria", "Celestoria", "Starwing", "Mythralia",
		                "Nyxara", "Mystica"
		            );
		            break;
		        case "modern":
		            _name = choose(
		                "Luna", "Stellaris", "Harmony", "Nova", "Pulse", "Eclipse", "Horizon", "Serenity",
		                "Aurora", "Verdant", "Elysia", "Luminara", "Zephyr", "Andromeda", "Erebus", "Celestia",
		                "Nebula", "Astralis", "Thalassa", "Aetheria", "Equinox", "Tranquility", "Veridian", "Proxima",
		                "Elysium", "Galactia", "Stellara", "Horizon", "Orion-7", "Nexara", "Alpha Prime", "Omega 9",
		                "Astrum", "Centauri", "Nebulon", "Zeron", "Andromeda", "Luminara", "Xeron", "Proxima",
		                "Umbra", "Quasara", "Orion-7", "Nexara", "Alpha Prime", "Omega 9", "Astrum", "Centauri",
		                "Nebulon", "Zeron", "Andromeda", "Luminara", "Xeron", "Proxima", "Umbra", "Quasara",
		                "Orion-7", "Nexara", "Alpha Prime", "Omega 9", "Astrum", "Centauri", "Nebulon", "Zeron",
		                "Andromeda", "Luminara", "Xeron", "Proxima", "Umbra", "Quasara", "Orion-7", "Nexara",
		                "Alpha Prime", "Omega 9", "Astrum", "Centauri", "Nebulon", "Zeron", "Andromeda", "Luminara"
		            );
		            break;
		        case "sci fi":
		            _name = choose(
		                "Lunarix", "Nexopolis", "Celesticon", "Stellara", "Zeron", "Nebulon", "Andromeda", "Luminara",
		                "Xeron", "Proxima", "Umbra", "Quasara", "Orion-7", "Stargaze", "Nexara", "Alpha Prime",
		                "Omega 9", "Astrum", "Centauri", "Nebulus", "Zerion", "Astralis", "Lunaris", "Xenara",
		                "Omnitron", "Thundoria", "Orion-7", "Stellara", "Zeron", "Andromeda", "Luminara", "Xeron",
		                "Proxima", "Umbra", "Quasara", "Astralis", "Lunaris", "Xenara", "Omnitron", "Thundoria",
		                "Stargaze", "Nexara", "Alpha Prime", "Omega 9", "Astrum", "Centauri", "Nebulus", "Zerion",
		                "Astralis", "Lunaris", "Xenara", "Omnitron", "Thundoria", "Stellara", "Zeron", "Andromeda",
		                "Luminara", "Xeron", "Proxima", "Umbra", "Quasara", "Orion-7", "Nexara", "Alpha Prime",
		                "Omega 9", "Astrum", "Centauri", "Nebulus", "Zerion", "Andromeda", "Luminara", "Xeron",
		                "Proxima", "Umbra", "Quasara", "Orion-7"
		            );
		            break;
		    }
		    break;
        case "star":
		    switch (_genre) {
		        case "fantasy":
		            _name = choose(
		                "Astraclasp", "Stellara", "Solariel", "Nebuloria", "Celestria", "Aurorium", "Luminara", "Zypherus",
		                "Andromeda", "Thornaris", "Lyridor", "Elysium", "Zephyreon", "Astralis", "Lunoria", "Xenaris",
		                "Oriaxis", "Zerenity", "Nyxara", "Drakona", "Nebulastra", "Emberon", "Galaxia", "Thundoril",
		                "Mythrilis", "Nyxaris", "Glimmera", "Astraclasp", "Stellara", "Solariel", "Nebuloria", "Celestria",
		                "Aurorium", "Luminara", "Zypherus", "Andromeda", "Thornaris", "Lyridor", "Elysium", "Zephyreon",
		                "Astralis", "Lunoria", "Xenaris", "Oriaxis", "Zerenity", "Nyxara", "Drakona", "Nebulastra",
		                "Emberon", "Galaxia", "Thundoril", "Mythrilis", "Nyxaris", "Glimmera", "Astraclasp", "Stellara",
		                "Solariel", "Nebuloria", "Celestria", "Aurorium", "Luminara", "Zypherus", "Andromeda", "Thornaris",
		                "Lyridor", "Elysium", "Zephyreon", "Astralis", "Lunoria", "Xenaris", "Oriaxis", "Zerenity",
		                "Nyxara", "Drakona", "Nebulastra", "Emberon", "Galaxia", "Thundoril", "Mythrilis", "Nyxaris"
		            );
		            break;
		        case "modern":
		            _name = choose(
		                "Solaris", "Astralis", "Lyra", "Zephyra", "Aquila", "Nebulus", "Stellara", "Andromeda",
		                "Polaris", "Luminara", "Eclipse", "Zeron", "Thalassa", "Horizon", "Altair", "Vega",
		                "Aurora", "Orion", "Nexara", "Zenith", "Zeron", "Altair", "Vega", "Aurora",
		                "Orion", "Nexara", "Zenith", "Stellara", "Andromeda", "Polaris", "Luminara", "Eclipse",
		                "Zephyra", "Aquila", "Nebulus", "Stellara", "Andromeda", "Solaris", "Astralis", "Lyra",
		                "Zephyra", "Aquila", "Nebulus", "Altair", "Vega", "Aurora", "Orion", "Nexara",
		                "Zenith", "Altair", "Vega", "Aurora", "Orion", "Nexara", "Zenith", "Stellara",
		                "Andromeda", "Polaris", "Luminara", "Eclipse", "Zephyra", "Aquila", "Nebulus", "Altair",
		                "Vega", "Aurora", "Orion", "Nexara", "Zenith", "Solaris", "Astralis", "Lyra"
		            );
		            break;
		        case "sci fi":
		            _name = choose(
		                "Astronova", "Nexuron", "Stellarix", "Zypherius", "Aurora", "Centauri", "Luminara", "Andromeda",
		                "Zephyrion", "Nebulon", "Solaris", "Xenaris", "Quasara", "Orion-7", "Drakoria", "Nyxara",
		                "Nebulus", "Lunaris", "Zeron", "Thalassa", "Nexara", "Zypherius", "Aurora", "Centauri",
		                "Luminara", "Andromeda", "Zephyrion", "Nebulon", "Solaris", "Xenaris", "Quasara", "Orion-7",
		                "Drakoria", "Nyxara", "Nebulus", "Lunaris", "Zeron", "Thalassa", "Nexara", "Astronova",
		                "Nexuron", "Stellarix", "Zypherius", "Aurora", "Centauri", "Luminara", "Andromeda", "Zephyrion",
		                "Nebulon", "Solaris", "Xenaris", "Quasara", "Orion-7", "Drakoria", "Nyxara", "Nebulus",
		                "Lunaris", "Zeron", "Thalassa", "Nexara", "Astronova", "Nexuron", "Stellarix", "Zypherius"
		            );
		            break;
		    }
		    break;
        case "building":
		    switch (_genre) {
		        case "fantasy":
		            _name = choose(
		                "Dragon's Roost", "Elven Haven", "Sorcerer's Spire", "Witchwood Manor", "Knight's Keep", "Fairy's Glade", "Wizard's Tower", "Enchanted Hall",
		                "Goblin's Grotto", "Mystic Mansion", "Centaur's Stables", "Pixie Hollow", "Griffin's Perch", "Phoenix Forge", "Unicorn's Retreat", "Dwarf's Delve",
		                "Orcish Stronghold", "Mermaid's Cove", "Troll's Toll", "Cursed Crypt", "Gargoyle's Watch", "Manticore Den", "Basilisk Bastion", "Chimera Chambers",
		                "Dragon's Roost", "Elven Haven", "Sorcerer's Spire", "Witchwood Manor", "Knight's Keep", "Fairy's Glade", "Wizard's Tower", "Enchanted Hall",
		                "Goblin's Grotto", "Mystic Mansion", "Centaur's Stables", "Pixie Hollow", "Griffin's Perch", "Phoenix Forge", "Unicorn's Retreat", "Dwarf's Delve",
		                "Orcish Stronghold", "Mermaid's Cove", "Troll's Toll", "Cursed Crypt", "Gargoyle's Watch", "Manticore Den", "Basilisk Bastion", "Chimera Chambers",
		                "Dragon's Roost", "Elven Haven", "Sorcerer's Spire", "Witchwood Manor", "Knight's Keep", "Fairy's Glade", "Wizard's Tower", "Enchanted Hall",
		                "Goblin's Grotto", "Mystic Mansion", "Centaur's Stables", "Pixie Hollow", "Griffin's Perch", "Phoenix Forge", "Unicorn's Retreat", "Dwarf's Delve",
		                "Orcish Stronghold", "Mermaid's Cove", "Troll's Toll", "Cursed Crypt", "Gargoyle's Watch", "Manticore Den", "Basilisk Bastion", "Chimera Chambers"
		            );
		            break;
		        case "modern":
		            _name = choose(
		                "Oakwood Apartments", "Riverside Plaza", "Highland Tower", "Maple Street Lofts", "Sunnyview Condos", "City Center Offices", "Harborfront Suites", "Brookside Hotel",
		                "Parkview Residences", "Downtown Lofts", "Lakeview Mansion", "Hillside Villas", "Pinecrest Plaza", "Skyline Offices", "Willowbrook Mall", "Cedarville Tower",
		                "Harmony Hospital", "Meadowbrook Mansion", "Central Park Offices", "Sunset View Apartments", "Broadway Theater", "Main Street Clinic", "Greenville Studios", "Greenview Gym",
		                "Oakwood Apartments", "Riverside Plaza", "Highland Tower", "Maple Street Lofts", "Sunnyview Condos", "City Center Offices", "Harborfront Suites", "Brookside Hotel",
		                "Parkview Residences", "Downtown Lofts", "Lakeview Mansion", "Hillside Villas", "Pinecrest Plaza", "Skyline Offices", "Willowbrook Mall", "Cedarville Tower",
		                "Harmony Hospital", "Meadowbrook Mansion", "Central Park Offices", "Sunset View Apartments", "Broadway Theater", "Main Street Clinic", "Greenville Studios", "Greenview Gym",
		                "Oakwood Apartments", "Riverside Plaza", "Highland Tower", "Maple Street Lofts", "Sunnyview Condos", "City Center Offices", "Harborfront Suites", "Brookside Hotel",
		                "Parkview Residences", "Downtown Lofts", "Lakeview Mansion", "Hillside Villas", "Pinecrest Plaza", "Skyline Offices", "Willowbrook Mall", "Cedarville Tower"
		            );
		            break;
		        case "sci fi":
		            _name = choose(
		                "Astra Station", "Galactic Hub", "Starlight Tower", "Nebula Plaza", "Cosmic Complex", "Orion Outpost", "Nova Dome", "Stellar Habitat",
		                "Astro Labs", "Quantum Quarters", "Celestial Spire", "Solar Sphere", "Lunar Dome", "Xenon Facility", "Galaxy Nexus", "Astrum Tower",
		                "Nexopolis Hub", "Zypher Lab", "Orbital Outpost", "Hyperion Heights", "Voyager Villa", "Astral Chamber", "Stargazer Complex", "Eclipse Enclave",
		                "Astra Station", "Galactic Hub", "Starlight Tower", "Nebula Plaza", "Cosmic Complex", "Orion Outpost", "Nova Dome", "Stellar Habitat",
		                "Astro Labs", "Quantum Quarters", "Celestial Spire", "Solar Sphere", "Lunar Dome", "Xenon Facility", "Galaxy Nexus", "Astrum Tower",
		                "Nexopolis Hub", "Zypher Lab", "Orbital Outpost", "Hyperion Heights", "Voyager Villa", "Astral Chamber", "Stargazer Complex", "Eclipse Enclave",
		                "Astra Station", "Galactic Hub", "Starlight Tower", "Nebula Plaza", "Cosmic Complex", "Orion Outpost", "Nova Dome", "Stellar Habitat",
		                "Astro Labs", "Quantum Quarters", "Celestial Spire", "Solar Sphere", "Lunar Dome", "Xenon Facility", "Galaxy Nexus", "Astrum Tower"
		            );
		            break;
		    }
		    break;
        case "neighbourhood":
		    switch (_genre) {
		        case "fantasy":
		            _name = choose(
		                "Misty Grove", "Silvershade", "Glimmerbrook", "Dawnmeadow", "Rosewyn", "Whisperwind", "Thistledale", "Lilyvale",
		                "Hazelwood", "Starfield", "Moonrise", "Ivoryglade", "Emberwood", "Sablewood", "Amberhill", "Stardew",
		                "Mosswood", "Elmview", "Bramblewood", "Elderbrook", "Falconreach", "Hollyhollow", "Sylvancreek", "Oakenheart",
		                "Misty Grove", "Silvershade", "Glimmerbrook", "Dawnmeadow", "Rosewyn", "Whisperwind", "Thistledale", "Lilyvale",
		                "Hazelwood", "Starfield", "Moonrise", "Ivoryglade", "Emberwood", "Sablewood", "Amberhill", "Stardew",
		                "Mosswood", "Elmview", "Bramblewood", "Elderbrook", "Falconreach", "Hollyhollow", "Sylvancreek", "Oakenheart",
		                "Misty Grove", "Silvershade", "Glimmerbrook", "Dawnmeadow", "Rosewyn", "Whisperwind", "Thistledale", "Lilyvale",
		                "Hazelwood", "Starfield", "Moonrise", "Ivoryglade", "Emberwood", "Sablewood", "Amberhill", "Stardew"
		            );
		            break;
		        case "modern":
		            _name = choose(
		                "Maplewood Estates", "Pineview Heights", "Cedarbrook Terrace", "Willow Grove", "Oakshire Meadows", "Riverside Gardens", "Sunnyvale Park", "Highland Heights",
		                "Brookside Village", "Hillcrest Springs", "Lakeview Terrace", "Harborfront Heights", "Greenview Meadows", "Central Park Estates", "Fairview Square", "Windsor Gardens",
		                "Meadowbrook Estates", "Parkside Manor", "Downtown District", "Rosewood Gardens", "Chestnut Hill", "Briarwood Springs", "Riverdale Heights", "Greenville Meadows",
		                "Maplewood Estates", "Pineview Heights", "Cedarbrook Terrace", "Willow Grove", "Oakshire Meadows", "Riverside Gardens", "Sunnyvale Park", "Highland Heights",
		                "Brookside Village", "Hillcrest Springs", "Lakeview Terrace", "Harborfront Heights", "Greenview Meadows", "Central Park Estates", "Fairview Square", "Windsor Gardens",
		                "Meadowbrook Estates", "Parkside Manor", "Downtown District", "Rosewood Gardens", "Chestnut Hill", "Briarwood Springs", "Riverdale Heights", "Greenville Meadows",
		                "Maplewood Estates", "Pineview Heights", "Cedarbrook Terrace", "Willow Grove", "Oakshire Meadows", "Riverside Gardens", "Sunnyvale Park", "Highland Heights"
		            );
		            break;
		        case "sci fi":
		            _name = choose(
		                "Stellar Heights", "Astron Enclave", "Quantum District", "Celestia Terrace", "Nova City", "Galactix Heights", "Orbital Gardens", "Nebula Springs",
		                "Astroview Terrace", "Cosmic Gardens", "Orion District", "Lunar Springs", "Stargaze Heights", "Xenon Enclave", "Nexopolis City", "Zypher Gardens",
		                "Stellar Heights", "Astron Enclave", "Quantum District", "Celestia Terrace", "Nova City", "Galactix Heights", "Orbital Gardens", "Nebula Springs",
		                "Astroview Terrace", "Cosmic Gardens", "Orion District", "Lunar Springs", "Stargaze Heights", "Xenon Enclave", "Nexopolis City", "Zypher Gardens",
		                "Stellar Heights", "Astron Enclave", "Quantum District", "Celestia Terrace", "Nova City", "Galactix Heights", "Orbital Gardens", "Nebula Springs",
		                "Astroview Terrace", "Cosmic Gardens", "Orion District", "Lunar Springs", "Stargaze Heights", "Xenon Enclave", "Nexopolis City", "Zypher Gardens"
		            );
		            break;
		    }
		    break;
        case "battlefield":
		    switch (_genre) {
		        case "fantasy":
		            _name = choose(
		                "Bloodbriar Battlefield", "Dragon's Fall", "Shadowfen Marsh", "Goblin's Gulch", "Thunderpeak Ridge", "Raven's Hollow", "Darkwood Vale", "Dreadfort",
		                "Mournstone Quarry", "Crimson Fields", "Wyvern Pass", "Blackwater Gorge", "Frostwind Plateau", "Duskwood Plains", "Stormhold Keep", "Ironhold Citadel",
		                "Sorrowmist Basin", "Hallowed Ruins", "Wraithmoor Caverns", "Banekeep Bastion", "Moonshadow Glen", "Trollbone Crags", "Thornwatch Glen", "Silentwood Glade",
		                "Bloodbriar Battlefield", "Dragon's Fall", "Shadowfen Marsh", "Goblin's Gulch", "Thunderpeak Ridge", "Raven's Hollow", "Darkwood Vale", "Dreadfort",
		                "Mournstone Quarry", "Crimson Fields", "Wyvern Pass", "Blackwater Gorge", "Frostwind Plateau", "Duskwood Plains", "Stormhold Keep", "Ironhold Citadel",
		                "Sorrowmist Basin", "Hallowed Ruins", "Wraithmoor Caverns", "Banekeep Bastion", "Moonshadow Glen", "Trollbone Crags", "Thornwatch Glen", "Silentwood Glade",
		                "Bloodbriar Battlefield", "Dragon's Fall", "Shadowfen Marsh", "Goblin's Gulch", "Thunderpeak Ridge", "Raven's Hollow", "Darkwood Vale", "Dreadfort",
		                "Mournstone Quarry", "Crimson Fields", "Wyvern Pass", "Blackwater Gorge", "Frostwind Plateau", "Duskwood Plains", "Stormhold Keep", "Ironhold Citadel"
		            );
		            break;
		        case "modern":
		            _name = choose(
		                "Urban Wasteland", "Warzone Heights", "City Ruins", "Desolate Streets", "Combat Zone", "Blasted Alley", "Tactical Outpost", "Red Zone",
		                "Broken District", "Battlefront Plaza", "Torn Suburbs", "Shattered Square", "Abandoned Depot", "Siege Streets", "Deadlock Crossing", "Rubble Field",
		                "Lost Park", "Tactical HQ", "Wrecked Warehouse", "Bunker Outpost", "Battlefield Overpass", "Destruction Drive", "Hazard Zone", "Ruined Junction",
		                "Urban Wasteland", "Warzone Heights", "City Ruins", "Desolate Streets", "Combat Zone", "Blasted Alley", "Tactical Outpost", "Red Zone",
		                "Broken District", "Battlefront Plaza", "Torn Suburbs", "Shattered Square", "Abandoned Depot", "Siege Streets", "Deadlock Crossing", "Rubble Field",
		                "Lost Park", "Tactical HQ", "Wrecked Warehouse", "Bunker Outpost", "Battlefield Overpass", "Destruction Drive", "Hazard Zone", "Ruined Junction",
		                "Urban Wasteland", "Warzone Heights", "City Ruins", "Desolate Streets", "Combat Zone", "Blasted Alley", "Tactical Outpost", "Red Zone",
		                "Broken District", "Battlefront Plaza", "Torn Suburbs", "Shattered Square", "Abandoned Depot", "Siege Streets", "Deadlock Crossing", "Rubble Field"
		            );
		            break;
		        case "sci fi":
		            _name = choose(
		                "Starfall Battleground", "Nebula Nexus", "Astrofield", "Cosmic Conflict Zone", "Orbital Strike Site", "Stellar Rift", "Quantum Warzone", "Celestial Nexus",
		                "Astrobase Alpha", "Nova Defense Grid", "Galactic Warfront", "Lunar Outpost", "Stargate Crucible", "Xenon Warzone", "Nexopolis Battleground", "Zypher Zone",
		                "Starfall Battleground", "Nebula Nexus", "Astrofield", "Cosmic Conflict Zone", "Orbital Strike Site", "Stellar Rift", "Quantum Warzone", "Celestial Nexus",
		                "Astrobase Alpha", "Nova Defense Grid", "Galactic Warfront", "Lunar Outpost", "Stargate Crucible", "Xenon Warzone", "Nexopolis Battleground", "Zypher Zone",
		                "Starfall Battleground", "Nebula Nexus", "Astrofield", "Cosmic Conflict Zone", "Orbital Strike Site", "Stellar Rift", "Quantum Warzone", "Celestial Nexus",
		                "Astrobase Alpha", "Nova Defense Grid", "Galactic Warfront", "Lunar Outpost", "Stargate Crucible", "Xenon Warzone", "Nexopolis Battleground", "Zypher Zone"
		            );
		            break;
		    }
		    break;
        default:
            return "";
    }
    
    return _name;
}
