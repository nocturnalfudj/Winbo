/// @description Generate a random name for a pet.
/// @function random_name_generator_pet
/// @param pet_type - The type of the pet ("cat", "dog", "bird", "fish", etc.).
/// @param genre - The genre for which the name should be generated ("fantasy", "modern", "sci fi").
/// @returns The generated pet name as a string.
function random_name_generator_pet(_pet_type, _genre) {
    var _name;

    // Randomly select a name based on the pet type and genre.
    switch (_pet_type) {
        case "cat":
		    switch (_genre) {
		        case "fantasy":
		            _name = choose(
		                "Luna", "Whiskerwyn", "Midnight", "Mystique", "Shadowpaw", 
		                "Sylvan", "Nimblewhisk", "Willow", "Aurora", "Velvet", 
		                "Pandora", "Bramble", "Calypso", "Thistle", "Moonshadow", 
		                "Jinx", "Mango", "Zephyr", "Cinders", "Glimmer", 
		                "Wisteria", "Stormy", "Banshee", "Oberon", "Cassiopeia", 
		                "Phantom", "Tigress", "Puck", "Moonshine", "Freyja", 
		                "Cheshire", "Stardust", "Galadriel", "Eclipse", "Nocturne", 
		                "Twilight", "Mystic", "Cosmic", "Dreamweaver", "Whisper", 
		                "Rhapsody", "Zinnia", "Obsidian", "Vesper", "Sable", 
		                "Abyss", "Zigzag", "Nebula", "Celestia", "Sabre",
		                "Inkspot", "Jaguar", "Eowyn", "Azrael", "Gossamer",
		                "Gwynevere", "Raven", "Sphinx", "Valkyrie", "Amethyst",
		                "Ebon", "Galaxy", "Dragonfly", "Panther", "Zora",
		                "Salem", "Nova", "Azalea", "Tyr", "Aspen",
		                "Witchcraft", "Indigo", "Shadowfax", "Astrid", "Selene",
		                "Artemis", "Scarlett", "Nyx", "Cyber", "Bastet",
		                "Jupiter", "Hecate", "Elara", "Hyacinth", "Triton",
		                "Zeppelin", "Ozymandias", "Merlin", "Wolfsbane", "Vex"
		            );
		            break;
		        case "modern":
		            _name = choose(
		                "Leo", "Max", "Oliver", "Lucy", "Chloe",
		                "Milo", "Luna", "Bella", "Simba", "Sophie",
		                "Jack", "Coco", "Charlie", "Daisy", "Tiger",
		                "Molly", "Oscar", "Sasha", "Tigger", "Misty",
		                "Felix", "Angel", "Sadie", "Rocky", "Nala",
		                "Whiskers", "Princess", "George", "Mia", "Shadow",
		                "Maggie", "Sam", "Cleo", "Buddy", "Lily",
		                "Tom", "Mocha", "Zeus", "Penny", "Oreo",
		                "Rusty", "Ruby", "Dusty", "Rosie", "Smokey",
		                "Misty", "Ziggy", "Lucky", "Cinnamon", "Zoe",
		                "Bandit", "Jasmine", "Salem", "Taz", "Sugar",
		                "Jinx", "Gizmo", "Cocoa", "Misty", "Ginger",
		                "Boots", "Lola", "Midnight", "Toby", "Cali",
		                "Pumpkin", "Shadow", "Tinkerbell", "Harley", "Isis"
		            );
		            break;
		        case "sci fi":
		            _name = choose(
		                "Cyber", "Zara", "Laser", "Nyx", "X-9",
		                "Binary", "Zap", "Cosmo", "Vortex", "Neon",
		                "Rex-7", "Nova", "Rocket", "Blitz", "Jupiter",
		                "Orbit", "Gizmo", "Galaxy", "Zigzag", "Axel",
		                "Kodiak", "Vega", "Astra", "Sputnik", "Comet",
		                "Zephyr", "Quantum", "Ripple", "Flux", "Ziggy",
		                "Bolt", "Astro", "Zenon", "Luna", "Spark",
		                "Nimbus", "Crux", "Zion", "Xylo", "Stellar",
		                "Gamma", "Mars", "Zinnia", "Xara", "PhantomX",
		                "Venom", "Vex", "Spectra", "Circuit", "Vapor",
		                "Warp", "Galax", "Ozone", "Blade", "Venus",
		                "Stardust", "Nyxon", "Halo", "Kronos", "Zero",
		                "Viper", "Zoltar", "Eclipse", "Zephyra", "Matrix",
		                "Vortex", "Haze", "Zodiac", "Wolfgang", "Xylon"
		            );
		            break;
		    }
		    break;
        case "dog":
		    switch (_genre) {
		        case "fantasy":
		            _name = choose(
		                "Fang", "Moonshadow", "Whiskerwyn", "Nimblepaws", "Wolfsbane", 
		                "Thunderpaws", "Aurora", "Midnight", "Mystique", "Shadowfang", 
		                "Sylvan", "Thistle", "Frost", "Moonlight", "Jinx",
		                "Ragnarok", "Zephyr", "Glimmer", "Pandora", "Rusty",
		                "Stormy", "Chaos", "Cinder", "Glimmer", "Phantom",
		                "Tundra", "Tigress", "Rex", "Sable", "Draco",
		                "Nyx", "Jade", "Bramble", "Vixen", "Mango",
		                "Zigzag", "Inferno", "Gossamer", "Raven", "Valkyrie",
		                "Gwynevere", "Jupiter", "Zara", "Sapphire", "Astrid",
		                "Cyber", "Avalanche", "Ozymandias", "Wolfbane", "Vex",
		                "Zion", "Elara", "Bolt", "Blade", "Zap",
		                "Galaxy", "Luna", "Pandora", "Stardust", "Mystic",
		                "Hecate", "Zara", "Eclipse", "Spectral", "Zeppelin",
		                "Zeus", "Hydra", "Cali", "Tiger", "Indigo",
		                "Nova", "Ares", "Banshee", "Celestia", "Saber",
		                "Fury", "Rosie", "Saphira", "Xara", "Gryffin"
		            );
		            break;
		        case "modern":
		            _name = choose(
		                "Buddy", "Charlie", "Cooper", "Daisy", "Max",
		                "Lucy", "Sadie", "Milo", "Molly", "Bailey",
		                "Rocky", "Lola", "Oliver", "Rosie", "Toby",
		                "Penny", "Zeus", "Ruby", "Winston", "Chloe",
		                "Riley", "Pepper", "Frankie", "Sasha", "Zeke",
		                "Sophie", "Bear", "Coco", "Duke", "Maggie",
		                "Harley", "Princess", "Gus", "Luna", "Oscar",
		                "Roxy", "Jackson", "Zoe", "Tank", "Mia",
		                "Apollo", "Hazel", "Zeus", "Ginger", "Dexter",
		                "Nala", "Finn", "Sadie", "Bruno", "Sasha",
		                "Otis", "Phoebe", "Gunner", "Delilah", "Rufus",
		                "Zara", "Remy", "Holly", "Cody", "Roxie",
		                "Kobe", "Josie", "Marley", "Mocha", "Ivy",
		                "Parker", "Skye", "Tyson", "Willow", "Winston"
		            );
		            break;
		        case "sci fi":
		            _name = choose(
		                "Zara", "Laser", "Bolt", "Flux", "Zeus",
		                "Rex-7", "Jupiter", "Orbit", "Gizmo", "Galaxy",
		                "Axel", "Kodiak", "Vega", "Astra", "Sputnik",
		                "Comet", "Zephyr", "Quantum", "Ripple", "Ziggy",
		                "Astro", "Zenon", "Luna", "Spark", "Nimbus",
		                "Crux", "Zion", "Xylo", "Stellar", "Gamma",
		                "Mars", "Zinnia", "Xara", "PhantomX", "Venom",
		                "Vex", "Spectra", "Circuit", "Vapor", "Warp",
		                "Galax", "Ozone", "Stardust", "Nyxon", "Halo",
		                "Kronos", "Zero", "Viper", "Zoltar", "Eclipse",
		                "Zephyra", "Matrix", "Vortex", "Haze", "Zodiac",
		                "Wolfgang", "Xylon", "Cosmo", "Nova", "Rocket",
		                "Blitz", "ZeroX", "Pulsar", "Copper", "Neutron",
		                "Quasar", "Zara", "Astro", "Voyager", "Zeppelin"
		            );
		            break;
		    }
		    break;
        case "bird":
		    switch (_genre) {
		        case "fantasy":
		            _name = choose(
		                "Phoenix", "Zephyr", "Aurora", "Mystique", "Peregrine", 
		                "Nimblewing", "Moonshadow", "Sylvan", "Starling", "Frost",
		                "Wisp", "Glimmer", "Thistle", "Moonlight", "Jinx",
		                "Ravenwing", "Zigzag", "Glimmer", "Firefly", "Pandora",
		                "Stormy", "Chaos", "Lark", "Sable", "Draco",
		                "Nyx", "Jade", "Bramble", "Vixen", "Mango",
		                "Zara", "Cinder", "Glimmer", "Shadowpaw", "Valkyrie",
		                "Gwynevere", "Jupiter", "Zara", "Sapphire", "Astrid",
		                "Nimblewhisk", "Avalanche", "Ozymandias", "Wolfbane", "Vex",
		                "Zion", "Elara", "Bolt", "Blade", "Zap",
		                "Galaxy", "Luna", "Pandora", "Stardust", "Mystic",
		                "Hecate", "Zara", "Eclipse", "Spectral", "Zeppelin",
		                "Zeus", "Hydra", "Cali", "Tiger", "Indigo",
		                "Nova", "Ares", "Banshee", "Celestia", "Saber",
		                "Fury", "Rosie", "Saphira", "Xara", "Gryffin"
		            );
		            break;
		        case "modern":
		            _name = choose(
		                "Sunny", "Kiwi", "Buddy", "Charlie", "Blue",
		                "Skye", "Rio", "Sunny", "Piper", "Oliver",
		                "Tweety", "Nala", "Chirpy", "Spike", "Toby",
		                "Ruby", "Chloe", "Rio", "Winnie", "Pippin",
		                "Sunny", "Beaky", "Jade", "Zeus", "Bella",
		                "Peanut", "Sky", "Coco", "Duke", "Angel",
		                "Marley", "Squeaky", "Finn", "Rosie", "Wally",
		                "Gizmo", "Kiki", "Koda", "Jojo", "Echo",
		                "Jazz", "Sunny", "Waldo", "Cookie", "Pickle",
		                "Ruby", "Gigi", "Skylar", "Biscuit", "Kiko",
		                "Sunny", "Beaker", "Sunny", "Rusty", "Kiwi",
		                "Jazz", "Sunny", "Waldo", "Cookie", "Pickle"
		            );
		            break;
		        case "sci fi":
		            _name = choose(
		                "Cyber", "Zara", "Laser", "Bolt", "Flux",
		                "Zeus", "Rocket", "Jupiter", "Orbit", "Gizmo",
		                "Galaxy", "Axel", "Kodiak", "Vega", "Astra",
		                "Sputnik", "Comet", "Zephyr", "Quantum", "Ripple",
		                "Ziggy", "Astro", "Zenon", "Sunny", "Nimbus",
		                "Crux", "Zion", "Xylo", "Stellar", "Gamma",
		                "Mars", "Zinnia", "Xara", "PhantomX", "Venom",
		                "Vex", "Spectra", "Circuit", "Vapor", "Warp",
		                "Galax", "Ozone", "Stardust", "Nyxon", "Halo",
		                "Kronos", "Zero", "Viper", "Zoltar", "Eclipse",
		                "Zephyra", "Matrix", "Vortex", "Haze", "Zodiac",
		                "Wolfgang", "Xylon", "Cosmo", "Nova", "Spark",
		                "Blitz", "ZeroX", "Pulsar", "Copper", "Neutron",
		                "Quasar", "Zara", "Astro", "Voyager", "Zeppelin"
		            );
		            break;
		    }
		    break;
        case "fish":
		    switch (_genre) {
		        case "fantasy":
		            _name = choose(
		                "Abyss", "Coralia", "Nixie", "Finley", "Marina", 
		                "Sirena", "Nimbus", "Neptune", "Pearl", "Seaglass",
		                "Oceana", "Koi", "Cascade", "Marlin", "Zephyr",
		                "Nymph", "Trident", "Caspian", "Celeste", "Bubbles",
		                "Zara", "Aurora", "Mystic", "Sylvan", "Nimble",
		                "Moonshadow", "Zigzag", "Glimmer", "Ripple", "Hydra",
		                "Jinx", "Thalassa", "Wave", "Starlight", "Glimmer",
		                "Sapphire", "Zion", "Lumina", "Luna", "Galaxy",
		                "Orion", "Cosmo", "Stardust", "Mystique", "Zara",
		                "Nyx", "Avalanche", "Draco", "Vex", "Marble",
		                "Kaleidoscope", "Waverider", "Triton", "Pandora", "Zara",
		                "Xena", "Astrid", "Olympia", "Gryph", "Fury",
		                "Gwynevere", "Triton", "Poseidon", "Valkyrie", "Gwynevere",
		                "Iris", "Fury", "Zara", "Banshee", "Zephyra"
		            );
		            break;
		        case "modern":
		            _name = choose(
		                "Bubbles", "Flounder", "Goldie", "Splash", "Finn",
		                "Sunny", "Pebbles", "Jaws", "Coral", "Gill",
		                "Dory", "Charlie", "Nemo", "Buddy", "Oscar",
		                "Lucky", "Spike", "Bella", "Tango", "Sushi",
		                "Wanda", "Gigi", "Bubbles", "Winston", "Lola",
		                "Dexter", "Kiki", "Rio", "Sandy", "Finley",
		                "Skippy", "Toby", "Wiggles", "Marley", "Guppy",
		                "Bubbles", "Finny", "Spike", "Tiger", "Misty",
		                "Kiwi", "Bubbles", "Sparky", "Flippy", "Gizmo",
		                "Bubbles", "Sunny", "Nala", "Puffy", "Kodiak",
		                "Tweety", "Blue", "Ziggy", "Angel", "Finn",
		                "Rosie", "Beaky", "Coco", "Pickle", "Ruby"
		            );
		            break;
		        case "sci fi":
		            _name = choose(
		                "B-7", "Cyber", "Zara", "Laser", "Nyx",
		                "X-9", "Binary", "Zap", "Cosmo", "Rocket",
		                "Jupiter", "Orbit", "Gizmo", "Galaxy", "Axel",
		                "Kodiak", "Vega", "Astra", "Sputnik", "Comet",
		                "Zephyr", "Quantum", "Ripple", "Ziggy", "Astro",
		                "Zenon", "Sunny", "Nimbus", "Crux", "Zion",
		                "Xylo", "Stellar", "Gamma", "Mars", "Zinnia",
		                "Xara", "PhantomX", "Venom", "Vex", "Spectra",
		                "Circuit", "Vapor", "Warp", "Galax", "Ozone",
		                "Stardust", "Nyxon", "Halo", "Kronos", "Zero",
		                "Viper", "Zoltar", "Eclipse", "Zephyra", "Matrix",
		                "Vortex", "Haze", "Zodiac", "Wolfgang", "Xylon",
		                "Cosmo", "Nova", "Spark", "Blitz", "ZeroX",
		                "Pulsar", "Copper", "Neutron", "Quasar", "Zara",
		                "Astro", "Voyager", "Zeppelin"
		            );
		            break;
		    }
		    break;
        default:
            return "Unknown";
    }

    return _name;
}