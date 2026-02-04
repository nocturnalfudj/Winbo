/// @function random_name_generator_character
/// @summary Generate a random name for a character.
/// @param _species The species for which the name should be generated ("human", "gamer", "alien", "robot").
/// @param _has_last_name Whether the generated name should include a last name.
/// @param _gender The desired gender or undefined for random.
/// @returns {string} The generated name.
function random_name_generator_character(_species, _has_last_name, _gender) {
    var _first_name;
    var _last_name;
	
	if(_gender == undefined)
		_gender = choose("male","female");
    
    // Randomly select a first name based on the species and gender.
    switch (_species) {
        case "human":
            if (_gender == "male") {
               _first_name = choose(
								    "John", "Michael", "David", "Daniel", "Mohammed", "Ali", "Ahmed", "Hassan",
								    "Mateo", "Carlos", "Diego", "Javier", "Ricardo", "Santiago", "Luis", "Pedro",
								    "Andres", "Gabriel", "Eduardo", "Sebastian", "Victor", "Ivan", "Alejandro", "Juan",
								    "Jose", "Miguel", "Liam", "Noah", "Ethan", "William", "James", "Oliver",
								    "Lucas", "Benjamin", "Alexander", "Elijah", "Daniel", "Matthew", "Jayden", "David",
								    "Joseph", "Michael", "Aiden", "Samuel", "Jackson", "Levi", "Carter", "Daniel",
								    "Gabriel", "Mateo", "José", "Lorenzo", "Lucas", "Carlos", "Emiliano", "Santiago",
								    "Sebastián", "Matías", "Liam", "Noah", "Ethan", "Muhammad", "Adam", "Ahmed",
								    "Ali", "Omar", "Youssef", "Khalid", "Abdullah", "Amir", "Zayd", "Ibrahim",
								    "Kaden", "Caleb", "Adrian", "Owen", "Aaron", "Dylan", "Adam", "Leo",
								    "Nathan", "Isaac", "Elias", "Isaiah", "Josiah", "Lucas", "Daniel", "Mateo",
								    "Alexander", "Joseph", "Elijah", "Anthony", "Matthew", "David", "Benjamin", "Samuel",
								    "James", "Aiden", "Logan", "Mason", "Oliver", "Ethan", "William", "Michael"
								);

            } else if (_gender == "female") {
               _first_name = choose(
								    "Emily", "Sophia", "Isabella", "Olivia", "Ava", "Mia", "Emma", "Charlotte",
								    "Amelia", "Harper", "Evelyn", "Abigail", "Elizabeth", "Sofia", "Ella", "Scarlett",
								    "Grace", "Victoria", "Aria", "Chloe", "Zoe", "Lily", "Hannah", "Samantha",
								    "Natalie", "Aaliyah", "Layla", "Eleanor", "Ellie", "Avery", "Camila", "Hazel",
								    "Penelope", "Luna", "Maya", "Violet", "Aurora", "Nova", "Emilia", "Stella",
								    "Zara", "Paisley", "Sarah", "Anaya", "Aisha", "Yara", "Lila", "Leila",
								    "Jasmine", "Alice", "Hana", "Zaina", "Valentina", "Ariana", "Fatima", "Nora",
								    "Hana", "Zahra", "Zara", "Yara", "Lina", "Layla", "Jana", "Ayla",
								    "Inaya", "Amina", "Nadia", "Amira", "Hanan", "Selma", "Amna", "Salma",
								    "Sara", "Nour", "Maya", "Hadia", "Lamia", "Leila", "Mariam", "Naya",
								    "Lama", "Noor", "Yasmin", "Samira", "Farah", "Alya", "Lena", "Mina",
								    "Tala", "Rana", "Lara", "Zeinab", "Rahaf", "Dalal", "Joud", "Jana",
								    "Rima", "Roula", "Nisrine", "Samar", "Joudi", "Dana", "Celine", "Dima"
								);
            }
            break;
        case "gamer":
            if (_gender == "male") {
                _first_name = choose(
								    "Ninja", "Pixel", "Shadow", "Mystic", "Epic", "Rocket", "Cyber", "Blaze",
								    "Storm", "Spectre", "Zephyr", "Titan", "Reaper", "Viper", "Razor", "Volt",
								    "Falcon", "Phantom", "Hawk", "Sonic", "Astral", "Rogue", "Venom", "Wolf",
								    "Raptor", "Zenith", "Vortex", "Striker", "Hunter", "Pulse", "Crash", "Nova",
								    "Neon", "Spartan", "Zero", "Matrix", "Skylark", "Bolt", "Raiden", "Rex",
								    "Voltz", "Orbit", "Reign", "Zion", "Raze", "Cipher", "Axel", "Omega",
								    "Stryker", "Cypher", "Ryder", "Vex", "ZeroX", "Phaze", "VenomX", "Blitz",
								    "Apex", "Nexus", "Havoc", "Strix", "Exodus", "Genesis", "Torque", "Frost",
								    "Kairos", "Xero", "Aero", "Skar", "Haze", "Spectra", "Vexx", "Kingsley",
								    "Riggs", "FalconX", "Stealth", "Synth", "Nyx", "Halo", "Blast", "Vertex",
								    "Vapor", "Rapid", "Ravage", "Fusion", "Voltage", "Slash", "Bullet", "Grit",
								    "Vice", "Kraken", "RogueX", "Drake", "Solar", "Shock", "Sylph", "PhantomX"
								);
            } else if (_gender == "female") {
                _first_name = choose(
								    "Siren", "Valkyrie", "Cyberia", "Astrid", "Mystique", "Zara", "Raven", "Luna",
								    "Aella", "Aria", "Nova", "Spectra", "Huntress", "Rogue", "Zephyra", "Seraph",
								    "Phantom", "Blaze", "Aurora", "Storm", "Jinx", "Reyna", "Lyra", "Viper",
								    "Kaiya", "Shadow", "Xena", "Skylar", "Ember", "Nymeria", "Vixen", "Nyx",
								    "Astra", "Cyra", "Vesper", "Ripley", "Artemis", "Lara", "Saffron", "Lilith",
								    "Trinity", "Venus", "Ravena", "Sylph", "Zelda", "Zara", "Arietta", "Elara",
								    "Pandora", "Xara", "Starla", "Zuri", "Electra", "Eclipse", "Selene", "Zenith",
								    "Maven", "Tesla", "Jade", "Zephyrine", "Valka", "Raiden", "Nova", "Lysa",
								    "Astraea", "Ceridwen", "Seren", "Lyanna", "Vayda", "Zara", "Olympia", "Astraia",
								    "Kaida", "Arya", "Nixie", "Haven", "Nyx", "Arcadia", "Rhea", "Vespera",
								    "Lyric", "Selena", "Aella", "Zara", "Elora", "Soraya", "Saphira", "Nova",
								    "Kestrel", "Raven", "Eos", "Zara", "Dysis", "Talia", "Xyla", "Vexa"
								);
            }
            break;
        case "alien":
            if (_gender == "male") {
                _first_name = choose(
								    "Zog", "Xara", "Grok", "Vex", "Luna", "Nyx", "Razz", "Zara",
								    "Zotar", "Krel", "Xon", "Blip", "Glix", "Zyk", "Jaxx", "Zorr",
								    "Vlix", "Drax", "Zarx", "Grax", "Zylar", "Zogar", "Korg", "Xorn",
								    "Ylzar", "Grex", "Zolt", "Zygon", "Brax", "Xarv", "Grog", "Nyzar",
								    "Zang", "Zyrx", "Jarn", "Vrax", "Lyrx", "Vorg", "Xylor", "Gronk",
								    "Naxx", "Zork", "Zylas", "Graxx", "Xylax", "Zarv", "Zyxar", "Gron",
								    "Xarn", "Blix", "Zokar", "Zylor", "Klarx", "Vlax", "Glyx", "Zyros",
								    "Zarn", "Xonar", "Blorg", "Zark", "Zylox", "Karn", "Vonk", "Zygar",
								    "Zorn", "Glyzar", "Xorg", "Vlark", "Nyxar", "Zylax", "Grak", "Zygar",
								    "Zorx", "Xarnak", "Vorx", "Gylax", "Zangar", "Zyrax", "Klonk", "Xylox",
								    "Vexar", "Zyrak", "Gryx", "Nyk", "Zornak", "Xlyx", "Vorn", "Glyxon",
								    "Zryx", "Xygar", "Vylar", "Zynk", "Klox", "Xylon", "Vlyx", "Gryzar",
								    "Zarnax", "Xygon", "Vorl", "Zylark", "Korx", "Xygar", "Vlorn", "Zygar"
								);
            } else if (_gender == "female") {
                _first_name = choose(
								    "Zara", "Xyla", "Glix", "Vyx", "Luna", "Nyx", "Razz", "Zora",
								    "Zara", "Krexa", "Xena", "Bliss", "Gleera", "Zyla", "Jazra", "Zarla",
								    "Vexa", "Drayna", "Zalra", "Graxa", "Zelra", "Zara", "Krylla", "Xylia",
								    "Yxra", "Grexia", "Zoltara", "Zyla", "Blixia", "Zara", "Zyga", "Blarka",
								    "Xara", "Vraxa", "Lyra", "Zyra", "Gryxa", "Zorga", "Zara", "Gryla",
								    "Nyzara", "Zyla", "Gryla", "Xylara", "Zara", "Zyria", "Bryna", "Zara",
								    "Zoxia", "Zyla", "Kraza", "Vorna", "Glyxra", "Zara", "Zyga", "Zyla",
								    "Gralexa", "Xara", "Blyra", "Zara", "Zygar", "Xylra", "Vayna", "Zara",
								    "Zarla", "Xarna", "Vrya", "Glyxa", "Zara", "Zyra", "Kraza", "Xara",
								    "Vlyxra", "Zara", "Gryxa", "Nyla", "Zarlyn", "Xara", "Vona", "Graza",
								    "Zyra", "Xyna", "Vayla", "Zara", "Zorla", "Xylra", "Vayna", "Gryxa",
								    "Nyxra", "Zara", "Zylra", "Kryla", "Xora", "Vayra", "Zylra", "Glyna",
								    "Zara", "Zoxia", "Xyla", "Vyna", "Zarla", "Xena", "Vayna", "Gryxa"
								);
            }
            break;
        case "robot":
            if (_gender == "male") {
                _first_name = choose(
								    "B-4", "X9", "Alpha", "Max-7", "Axiom", "Circuit", "Z-12", "X-30",
								    "Vortex", "Tron", "Evo", "Cortex", "Blitz", "Titan", "Nexus", "Volt",
								    "Ratchet", "Sprocket", "Mecha", "Helix", "Zenith", "Galaxy", "Orbit", "Sentinel",
								    "Zephyr", "Vex", "Xenon", "Lumen", "Vector", "Spark", "Nanobot", "Mach",
								    "Gyro", "Cypher", "Dynamo", "Hydra", "Pulse", "Epsilon", "Fusion", "Gamma",
								    "Quantum", "Rez", "Kinesis", "Laser", "Omega", "Quasar", "Reactor", "Synth",
								    "Turbo", "Uplink", "Vapor", "Wave", "Xander", "Ypsilon", "Zap", "Bolt",
								    "Ziggy", "Rex", "Blip", "Wired", "Zigzag", "Archer", "Binary", "Comet",
								    "Deus", "Exo", "Flux", "Giga", "Hacker", "Inferno", "Juno", "Kronos",
								    "Lunar", "Mercury", "Neon", "Orion", "Plasma", "Quantum", "Radiant", "Solar",
								    "Torus", "Unity", "Voltage", "Warp", "Xenith", "Yuri", "Zen", "Zero"
								);
            } else if (_gender == "female") {
                _first_name = choose(
								    "A-7", "X-12", "Astra", "Vera", "Circuita", "Z-9", "X-27", "Vix",
								    "Nyx", "Synthia", "Zara", "Eva", "Blitzie", "Tara", "Nexus", "Viola",
								    "Roxie", "Sprockette", "Mecha", "Helixa", "Zenya", "Galaxia", "Orbix", "Sentella",
								    "Zephyra", "Vexa", "Xenia", "Lumina", "Vixen", "Sparks", "Nanette", "Mecha",
								    "Gyra", "Cytress", "Dynama", "Hydra", "Pulsa", "Epsie", "Fusia", "Gia",
								    "Quinta", "Reza", "Kinetica", "Laser", "Omegette", "Quara", "Reax", "Synthia",
								    "Turbo", "Uplinka", "Vaporia", "Wavea", "Xandera", "Ypsilona", "Zappia", "Bolta",
								    "Zigzaga", "Rexa", "Blipette", "Wireda", "Zigzaga", "Archa", "Binarya", "Cometa",
								    "Deusa", "Exa", "Fluxia", "Giga", "Hackera", "Inferna", "Junia", "Krona",
								    "Lunara", "Merca", "Neona", "Oriona", "Plasma", "Quantia", "Radiantia", "Solara",
								    "Tora", "Unitia", "Volta", "Warpa", "Xena", "Yurie", "Zena", "Zeroa"
								);
            }
            break;
        default:
            return "";
    }
    
    // If _has_last_name is true, generate a last name based on the species.
    if (_has_last_name) {
        switch (_species) {
            case "human":
                _last_name = choose(
								    "Smith", "Johnson", "Williams", "Brown", "Jones", "Miller", "Davis", "Garcia",
								    "Rodriguez", "Martinez", "Hernandez", "Lopez", "Gonzalez", "Wilson", "Anderson", "Thomas",
								    "Taylor", "Moore", "Jackson", "Martin", "Lee", "Perez", "Thompson", "White",
								    "Harris", "Sanchez", "Clark", "Ramirez", "Lewis", "Robinson", "Walker", "Young",
								    "Allen", "King", "Wright", "Scott", "Torres", "Nguyen", "Hill", "Flores",
								    "Green", "Adams", "Nelson", "Baker", "Hall", "Rivera", "Campbell", "Mitchell",
								    "Carter", "Roberts", "Gomez", "Phillips", "Evans", "Turner", "Diaz", "Parker",
								    "Cruz", "Edwards", "Collins", "Reyes", "Stewart", "Morris", "Morales", "Murphy",
								    "Cook", "Rogers", "Gutierrez", "Ortiz", "Morgan", "Cooper", "Peterson", "Bailey",
								    "Reed", "Kelly", "Howard", "Ramos", "Kim", "Cox", "Ward", "Richardson",
								    "Watson", "Brooks", "Chavez", "Wood", "James", "Bennett", "Gray", "Mendoza",
								    "Ruiz", "Hughes", "Price", "Alvarez", "Castillo", "Sanders", "Patel", "Myers"
								);
                break;
            case "gamer":
                _last_name = choose(
								    "Gamer", "Master", "Legend", "Champion", "Pro", "Warrior", "Ninja", "Cyber",
								    "Blaze", "Shadow", "Mystic", "Pixel", "Epic", "Rocket", "Storm", "Vortex",
								    "Volt", "Viper", "Raptor", "Spectre", "Astral", "Nova", "Spartan", "Vex",
								    "Xenon", "Reaper", "Rogue", "Stryker", "Venom", "Raiden", "Rex", "Xander",
								    "Zigzag", "Skylark", "Bolt", "Zarv", "Exodus", "Orbit", "Evo", "Galaxy",
								    "Zenith", "Neon", "Tron", "Zephyr", "Vexx", "Kingsley", "Riggs", "FalconX",
								    "Stealth", "Synth", "Phantom", "Blitz", "Hawk", "Zion", "Nyx", "Halo",
								    "Blast", "Vertex", "Hacker", "Matrix", "Vapor", "Reign", "Zarx", "Nexus",
								    "Laser", "Omega", "Kraken", "ZeroX", "Apex", "Nexus", "Havoc", "Strix",
								    "Kronos", "Plasma", "Radiant", "Turbo", "Giga", "Inferno", "Juno", "Zap"
								);
                break;
            case "alien":
                _last_name = choose(
								"Zarblax", "Xenon", "Vortus", "Lumina", "Nebula", "Zephyr", "Krelax", "Xylo",
								"Zigzor", "Xandar", "Blyxar", "Vylora", "Zygor", "Zonara", "Xarix", "Vylara",
								"Zarnak", "Gryxar", "Zoxia", "Xarnis", "Vixara", "Nyxar", "Zylara", "Gryla",
								"Zoran", "Xylar", "Glyxa", "Zayra", "Karnax", "Vylara", "Zoxa", "Xyla",
								"Glyza", "Zelnar", "Xylix", "Vylara", "Zogara", "Xylora", "Glyxa", "Zorana",
								"Xarnis", "Grylla", "Zarna", "Xylar", "Glyza", "Zarnis", "Xylara", "Glyla",
								"Zora", "Xylis", "Glyxar", "Zonara", "Xarina", "Gryzor", "Zarix", "Xylo",
								"Glyxa", "Zogara", "Xarnix", "Vylara", "Zorana", "Xylis", "Glyxar", "Zarnis",
								"Xylara", "Gryla", "Zorna", "Xylar", "Glyza", "Zarnis", "Xylara", "Glyla",
								"Zora", "Xylis", "Glyxar", "Zonara", "Xarina", "Gryzor", "Zarix", "Xylo"
							);
                break;
            case "robot":
                _last_name = choose(
							    "Circuit", "Zap", "Gear", "Wired", "Bolt", "Glix", "Spark", "Nanobot",
							    "Mecha", "Hydra", "Pulse", "Epsilon", "Fusion", "Gamma", "Quantum", "Reactor",
							    "Synth", "Turbo", "Vapor", "Wave", "Laser", "Plasma", "Radiant", "Solar",
							    "Torus", "Flux", "Inferno", "Juno", "Kronos", "Orion", "Neon", "Comet",
							    "Deus", "Exo", "Hacker", "Nyx", "Orbit", "Tron", "Zephyr", "Kronos",
							    "Plasma", "Radiant", "Turbo", "Giga", "Inferno", "Juno", "Zap", "Bolt",
							    "Zigzag", "Archer", "Binary", "Comet", "Deus", "Exo", "Flux", "Giga",
							    "Hacker", "Inferno", "Juno", "Kronos", "Lunar", "Mercury", "Neon", "Orion",
							    "Plasma", "Quantum", "Radiant", "Solar", "Torus", "Unity", "Voltage", "Warp",
							    "Xenith", "Yuri", "Zen", "Zero", "Archer", "Binary", "Comet", "Deus"
							);
                break;
        }
    }
    
    // Concatenate the first and last names (if available) and return the final generated name.
    if (_has_last_name) {
        return _first_name + " " + _last_name;
    } else {
        return _first_name;
    }
}
