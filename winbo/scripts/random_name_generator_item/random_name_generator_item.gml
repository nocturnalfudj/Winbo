/// @description Generate a random name for an item.
/// @function random_name_generator_item
/// @param item_type - The type of the item ("data", "relic", "gadget", "gem", "key", "treasure").
/// @param genre - The genre of the item ("fantasy", "modern", "sci fi").
/// @returns The generated item name as a string.
function random_name_generator_item(_item_type, _genre) {
    var _item_name;
    
    // Randomly select a name based on the item type and genre.
    switch (_item_type) {
        case "data":
		    switch (_genre) {
		        case "fantasy":
		            _item_name = choose(
		                "Arcane Codex", "Enchanted Scroll", "Ethereal Tome", "Mystic Tablet",
		                "Ancient Manuscript", "Runed Papyrus", "Sorcerer's Grimoire", "Wizard's Scroll",
		                "Mythical Cipher", "Celestial Archive", "Chronicle Scroll", "Enigmatic Codex",
		                "Supernatural Records", "Spellbinder Tablet", "Fabled Manuscript", "Lorekeeper Tome",
		                "Ancient Prophecies", "Eldritch Codex", "Enchanted Lexicon", "Magical Cipher",
		                "Lost Arcanum", "Mystical Scroll", "Prophet's Tome", "Runic Codex",
		                "Sage's Archive", "Secrets of Elders", "Twilight Tablets", "Whispering Parchment",
		                "Celestial Atlas", "Ephemeral Tome", "Eternal Codex", "Moonlit Scroll",
		                "Astral Inscriptions", "Chronomancer's Grimoire", "Dreamweaver's Scroll", "Everlasting Codex",
		                "Fey Records", "Glyph-etched Tablet", "Hallowed Manuscript", "Illusionist's Grimoire",
		                "Sorcery Scroll", "Starlight Codex", "Timeless Archives", "Vortex Tome",
		                "Wardkeeper's Scroll", "Weaver's Codex", "Elden Engravings", "Forgotten Arcanum",
		                "Illusory Papyrus", "Luminous Lexicon", "Nightshade Codex", "Omniscient Scroll",
		                "Abyssal Grimoire", "Cryptic Manuscript", "Divination Tablets", "Empyrean Codex",
		                "Grimoire of Enigmas", "Harmony Scroll", "Infernal Codex", "Journeyman's Tome",
		                "Kaleidoscopic Records", "Labyrinthian Scroll", "Moonweaver's Tome", "Nebula Codex",
		                "Oracle's Scroll", "Pandora's Manuscript", "Quintessence Tablet", "Radiant Grimoire",
		                "Spectral Tome", "Twilight Codex", "Veiled Archives", "Whisperwind Scroll",
		                "Xenoglyphic Inscriptions", "Yggdrasil Tablet", "Zephyr Grimoire", "Augur's Scroll",
		                "Bewitched Codex", "Cerulean Manuscript", "Dreamer's Tome", "Eclipse Scroll",
		                "Feywild Records", "Gossamer Codex", "Halcyon Tablets", "Illusionist's Tome",
		                "Loreseeker's Scroll", "Moonshadow Grimoire", "Nimbus Codex", "Oraculum Parchment",
		                "Primordial Archive", "Quicksilver Codex", "Rhapsodic Scroll", "Sylvan Manuscript",
		                "Timebender's Tome", "Umbral Codex", "Virtuoso's Scroll", "Whispers of Eldritch",
		                "Xanadu Grimoire", "Yggdrasil Records", "Zephyr Tablet", "Aetheric Codex"
		            );
		            break;
		        case "modern":
		            _item_name = choose(
		                "Digital Archive", "Encrypted File", "Hacker's Data", "Virtual Blueprint",
		                "Techno Log", "Cyber Database", "Nano Memory", "Quantum Cache",
		                "Futuristic Datasphere", "Advanced Algorithms", "Neural Network", "Augmented Reality Logs",
		                "Digital Mindmap", "Crypto Vault", "Artificial Intelligence Core", "Biometric Records",
		                "Cloud Datastream", "Cognitive Encryption", "Drone Controller", "Electronic Manifesto",
		                "Genetic Sequencer", "Holonet Interface", "Infinite Data Grid", "Junction Junction",
		                "Kinetic Matrix", "Laser Disc", "Micronet Terminal", "Nanite Cluster",
		                "Omniscience Engine", "Personal Datapad", "Quantum Server", "Robotics Schema",
		                "Satellite Linkup", "Telecom Nexus", "Virtual Cognition", "Webnet Interface",
		                "Xenotech Repository", "Yottabyte Cache", "Zettabyte Drive", "Atomic Codebase",
		                "Binary Compendium", "Cyberspace Codex", "Data Haven", "Exabyte Terminal",
		                "Fiber Optic Nexus", "Genome Database", "Holographic Index", "Intelligent Mainframe",
		                "Jumpgate Coordinates", "Kinetic Flux Capacitor", "Lunar Data Node", "Multiverse Nexus",
		                "Nano Circuitry", "Omni-Protocol Core", "Photon Synapses", "Quantum Datastream",
		                "Robotic Neural Net", "Sentient Dataware", "Terabyte Matrix", "Virtual Blueprint",
		                "Webnode Network", "Xenodatabase", "Yottacore Processor", "Zettagrid Architecture",
		                "AI Mainframe", "Binary Codex", "Cybermind Cortex", "Digital Lifestream",
		                "Ephemeral E-data", "Fiber Optic Firewall", "Genetic Matrix", "Holo-Memex",
		                "Infosphere Hub", "Jumpgate Coordinates", "Kinetic Flux Capacitor", "Lunar Data Node",
		                "Multiverse Nexus", "Nano Circuitry", "Omni-Protocol Core", "Photon Synapses",
		                "Quantum Datastream", "Robotic Neural Net", "Sentient Dataware", "Terabyte Matrix",
		                "Virtual Blueprint", "Webnode Network", "Xenodatabase", "Yottacore Processor",
		                "Zettagrid Architecture", "AI Mainframe", "Binary Codex", "Cybermind Cortex",
		                "Digital Lifestream", "Ephemeral E-data", "Fiber Optic Firewall", "Genetic Matrix",
		                "Holo-Memex", "Infosphere Hub"
		            );
		            break;
		        case "sci fi":
		            _item_name = choose(
		                "Nanotech Records", "Holographic Data", "Hypercore Backup", "Quantum Relic",
		                "Cosmic Codex", "Exo Information", "Star Datasphere", "Astral Archive",
		                "Astro Codex", "Binary Datastream", "Cosmic Archives", "Deep Space Logs",
		                "Extragalactic Catalog", "Galactic Repository", "Holospatial Records", "Interstellar Cache",
		                "Jumpgate Blueprints", "Kinetic Flux Data", "Lunar Datapack", "Microverse Matrix",
		                "Nebula Navigator", "Orbital Charts", "Photon Spectrometer", "Quasar Matrix",
		                "Rocket Propulsion Data", "Stargazer Logs", "Terraforming Protocols", "Universal Schema",
		                "Void Resonance Maps", "Warp Drive Sequencer", "Xenobiology Studies", "Yottaflop Calculator",
		                "Zeta Energy Readings", "Astroarchaeological Data", "Binary Star Charts", "Celestial Harmonics",
		                "Deep Space Spectrograph", "Exoplanet Cartography", "Fusion Reactor Blueprints", "Galactic Codex",
		                "Hyperspace Coordinates", "Intergalactic Comms", "Jumpgate Navigation", "Kinetic Propulsion",
		                "Laser Weaponry Schematics", "Massive Particle Scanner", "Nebulon Cruiser Plans", "Omniversal Records",
		                "Plasma Shielding Data", "Quantum Entanglement", "Rocket Thruster Algorithms", "Singularity Analysis",
		                "Terraforming Nanites", "Universal Translator Codes", "Void Particle Physics", "Warp Field Simulations",
		                "Xenodiplomacy Research", "Yottagram Quantum Processor", "Zeta Radiation Readings", "Antigravity Stabilizers",
		                "Black Hole Observations", "Chronosync Projections", "Dark Matter Analysis", "Electromagnetic Resonance",
		                "Fusion Power Reactor", "Galactic Trade Routes", "Hyperspace Tunneling", "Interstellar Network",
		                "Jumpgate Stability Protocols", "Kinetic Energy Harvesting", "Laser Communication Network", "Microgravity Simulations",
		                "Nebula Expansion Data", "Orbital Dynamics Calculations", "Photon Propulsion", "Quantum Computing",
		                "Rocket Payload Optimization", "Stellar Cartography", "Temporal Anomalies Research", "Universal Constants",
		                "Void Manipulation", "Warp Field Stability", "Xenobotanical Studies", "Yottaparsec Projections",
		                "Zetahertz Clock Oscillators", "Astrophysical Phenomena Observations", "Binary Star Orbits", "Cosmic Background Radiation",
		                "Dark Energy Surveys", "Electromagnetic Spectrum Analysis", "Fusion Reaction Rates", "Galactic Civilization Records",
		                "Hyperspace Energy Patterns", "Interstellar Anomaly Detection", "Jumpgate Navigation Charts", "Kinetic Projectile Weapons",
		                "Laser Weapon Optics", "Microgravity Manufacturing", "Nebula Formation Models", "Orbital Rendezvous Procedures",
		                "Photon Flux Density", "Quantum Entropy", "Rocket Thrust Vectoring", "Singularity Stability"
		            );
		            break;
		    }
		    break;
        case "relic":
		    switch (_genre) {
		        case "fantasy":
		            _item_name = choose(
		                "Ornate Amulet", "Enchanted Crown", "Mystic Talisman", "Ancient Ring",
		                "Runed Bracelet", "Sorcerer's Staff", "Wizard's Cloak", "Celestial Pendant",
		                "Divine Chalice", "Eternal Flame", "Mythical Scepter", "Lost Reliquary",
		                "Hallowed Dagger", "Sage's Crystal", "Arcane Idol", "Sylvan Horn",
		                "Feywild Mirror", "Guardian Gauntlets", "Blessed Helm", "Chaos Embrace",
		                "Frostbound Orb", "Holy Scriptures", "Enigmatic Locket", "Ethereal Lantern",
		                "Moonstone Circlet", "Necromancer's Skull", "Oracle's Eye", "Runic Tablet",
		                "Scepter of the Ancients", "Thorned Vines", "Titan's Heart", "Wyrm Scale Shield",
		                "Yggdrasil Branch", "Zealot's Sigil", "Ancient Dragon Scale", "Behemoth Horn",
		                "Chrono Hourglass", "Druidic Totem", "Eclipse Cape", "Fairy's Wing",
		                "Gorgon's Gaze", "Harpy's Talon", "Ivory Griffin Statue", "Jade Serpent Figurine",
		                "Kingsguard Crest", "Lunar Tear", "Mystic Oak Staff", "Nymph's Tear",
		                "Olympian Laurel Wreath", "Phoenix Feather", "Quicksilver Arrowhead", "Radiant Sun Disk",
		                "Serpent Crown", "Thunderstrike Hammer", "Undying Grimoire", "Valkyrie's Warhorn",
		                "Witch's Broomstick", "Xiphos of Heroes", "Ymir's Frozen Heart", "Zephyr Wind Fan",
		                "Angel's Tear", "Berserker's Warpaint", "Cerberus Fang", "Djinn's Lamp",
		                "Eagle-Eye Gem", "Frost Giant's Gauntlet", "Golden Fleece", "Hydra Scale",
		                "Inferno Crest", "Jinn's Turban", "Kraken's Tentacle", "Leprechaun's Pot of Gold",
		                "Minotaur's Horn", "Nemean Lion Pelt", "Orcish War Drum", "Pandora's Box",
		                "Qilin Horn", "Roc's Feather", "Salamander Scale", "Troll's Club",
		                "Unicorn's Hoof", "Vampire's Fang", "Werewolf's Claw", "Xorn's Crystal Heart",
		                "Yeti's Fur", "Zodiac Medallion"
		            );
		            break;
		        case "modern":
		            _item_name = choose(
		                "Tech Savant's Circuit", "Nanobot Swarm Container", "Quantum Core Processor", "Neural Interface Helm",
		                "Cybernetic Arm Prosthesis", "Virtual Reality Visor", "Stealth Cloaking Device", "Holographic Hologram Projector",
		                "Plasma Energy Cell", "Fusion Reactor Core", "Laser Targeting Module", "Anti-Gravity Generator",
		                "Nanofiber Cloak", "Magnetic Levitation Disk", "Biometric Implant Chip", "Genetic Enhancement Serum",
		                "Augmented Reality Goggles", "Hyperdrive Engine Blueprint", "Synthetic Android Cortex", "Dyson Sphere Blueprint",
		                "Teleportation Relocator", "Quantum Entanglement Transceiver", "Cybernetic Enhancer Implant", "AI Neural Network Chip",
		                "Neuromorphic Quantum Processor", "Invisibility Cloak", "Antimatter Container", "Molecular Replicator",
		                "Gravity Manipulation Device", "Particle Beam Cannon", "Neural Network Implant", "Nanite Infusion Syringe",
		                "Digital Conciousness Imprint", "X-Ray Vision Lenses", "Artificial Intelligence Matrix", "Chrono-Displacement Device",
		                "Time Dilation Core", "Virtual Holographic Assistant", "Gravity Defying Boots", "Nanotech Healing Serum",
		                "Plasma Shield Generator", "Fusion-Powered Jetpack", "Inertial Dampening Field", "Molecular Teleportation Device",
		                "Nanoscopic Surveillance Drone", "Cybernetic Mind Enhancer", "Genome Editing Sequencer", "Reality Bending Prototype",
		                "Quantum Phase Shifter", "Telekinetic Amplifier", "Cyborg Exoskeleton", "Holodeck Simulator",
		                "Plasma Propulsion Engine", "Fusion-Powered Spacecraft", "Light Speed Navigation System", "Temporal Disruptor",
		                "Virtual Reality Arcade Pod", "Biomechanical Prosthetic Limb", "Gravity Manipulation Gauntlets", "Nanotech DNA Replicator",
		                "Digital Consciousness Upload", "Xenobiological Research Scanner", "Artificial Intelligence Virus", "Chrono-Anomaly Detector",
		                "Time Manipulation Device", "Virtual Neural Interface", "Gravity Suspension Harness", "Nanobot Medkit",
		                "Plasma Blade", "Fusion Energy Rifle", "Laser Guided Missile System", "Anti-Gravity Hoverboard",
		                "Nanoscopic Stealth Suit", "Cybernetic Neural Implant", "Genetic Memory Extractor", "Reality-Warping Prototype"
		            );
		            break;
		        case "sci fi":
		            _item_name = choose(
		                "Galactic Star Chart", "Astrogravitational Compass", "Exosolar Warp Drive", "Cosmic Rift Stabilizer",
		                "Hyperstellar Navigation Module", "Astrobiotic Genome Capsule", "Quantum Singularity Transmitter", "Nebulae Crystal Prism",
		                "Astrophysical Phenomena Detector", "Binary Star Finder", "Cosmological Relativity Engine", "Dark Matter Reactor",
		                "Electromagnetic Spectrum Scanner", "Fusion Plasma Containment Vessel", "Galaxy Cluster Analyzer", "Hyperspace Harmonic Resonator",
		                "Interstellar Wormhole Map", "Jumpgate Interdimensional Key", "Kiloparsec Range Teleporter", "Light-year Distance Measurer",
		                "Magnetic Plasma Thruster", "Nanoscopic Nanomaterial Fabricator", "Omnidirectional Antigravity Device", "Photonic Quantum Capacitor",
		                "Quantum Energy Singularity", "Radiation Shielding Nanoweave", "Stellar Core Fusion Chamber", "Tachyon Particle Emitter",
		                "Universal Gravitational Inverter", "Vortex Phase Shift Array", "Warp Singularity Coil", "Xenomagnetic Field Manipulator",
		                "Yottabit Data Storage Matrix", "Zettavolt Power Transmitter", "Astrodynamic Trajectory Planner", "Binary Code Decryptor",
		                "Cosmic Expansion Drive", "Dyson Sphere Shell", "Extragalactic Hyperspace Conduit", "Fermionic Dark Matter Detector",
		                "Galactic Hyperspeed Propulsion", "Holographic Quantum Emitter", "Interdimensional Chrono Detector", "Jumpgate Harmonic Encryption",
		                "Kilometer-scale Nanofabricator", "Light-speed Phase Modulator", "Molecular Data Encryption Key", "Nanite Swarmer Control Sphere",
		                "Orbital Kinetic Bombardment Platform", "Photonic Ionization Amplifier", "Quantum Artificial Intelligence Nexus", "Radiation Absorption Shield",
		                "Stellar Graviton Emission Array", "Tachyon Phase Inverter", "Universal Spectrum Analyzer", "Vortex Singularity Core",
		                "Warp Field Synchronization Matrix", "Xenoarchaeological Research Probe", "Yoctosecond Time Dilation Module", "Zettahertz Quantum Processor",
		                "Astrophotonic Data Transceiver", "Binary Star Fusion Reactor", "Cosmic String Harmonic Oscillator", "Dark Energy Particle Collider",
		                "Extradimensional Hyper-Relay", "Fermionic Quantum Computing Array", "Galactic Chroniton Infuser", "Holographic Data Entanglement Module",
		                "Interstellar Gravitational Anomaly Detector", "Jumpgate Phase Disruptor", "Kilopulse Quantum Transceiver", "Lightning-infused Nanocircuit Mesh",
		                "Molecular Nanobot Replicator", "Nanotech Biohazard Containment Module", "Orbital Ion Cannon Array", "Photonic Pulse Disruptor",
		                "Quantum Biomechanical Enhancement Core", "Radiation-emitting Nanite Injector", "Stellar Fusion Harmonic Conductor", "Tachyon Phase Modulator",
		                "Universal Genetic Recoder", "Vortex Particle Accelerator", "Warp Gate Deployment Mechanism", "Xenomatter Energy Condenser",
		                "Yottabyte Supercomputer Core", "Zettameter Wormhole Stabilizer"
		            );
		            break;
		    }
		    break;
        case "gadget":
		    switch (_genre) {
		        case "fantasy":
		            _item_name = choose(
		                "Alchemy Apparatus", "Chrono Amulet", "Enchanted Spyglass", "Mystic Compass",
		                "Celestial Astrolabe", "Runic Detector", "Sorcerer's Hourglass", "Wizard's Pocket Watch",
		                "Arcane Lantern", "Ethereal Communicator", "Raven's Messenger", "Moonlit Hourglass",
		                "Golem Automaton", "Whispering Harp", "Sylvan Leaf Cloak", "Feywild Prism",
		                "Dragon Scale Satchel", "Basilisk Gaze Viewer", "Phoenix Ash Incubator", "Wyvern Flight Harness",
		                "Cursed Talisman Breaker", "Gorgon Gaze Mirror", "Harpy Feather Fan", "Griffin Feather Wings",
		                "Pixie Dust Vial", "Nymph's Moonstone Mirror", "Orb of Fortune", "Faerie Fire Lantern",
		                "Banshee's Wail Amplifier", "Vampire Hunter's Kit", "Werewolf Tracker Compass", "Ghost Whisperer's Pendant",
		                "Mermaid's Seashell Horn", "Eldritch Rune Reader", "Leprechaun's Gold Detector", "Centaur Hoof Boots",
		                "Gryphon Feather Quill", "Hydra Venom Antidote", "Minotaur Maze Thread", "Orcish Disguise Mask",
		                "Pandora's Music Box", "Goblin's Sneak Gauntlets", "Nymph's Tears Vial", "Dryad's Enchanted Acorn",
		                "Satyr's Pan Flute", "Cyclops Eye Patch", "Medusa's Stone Gaze Shield", "Banshee's Ectoplasm Containment Jar",
		                "Troll Regeneration Salve", "Unicorn Harmony Bow", "Vampire Repellent Spray", "Witch's Cauldron",
		                "Yeti Snowshoes", "Zephyr Wings"
		            );
		            break;
		        case "modern":
		            _item_name = choose(
		                "Multifunctional Smartwatch", "Augmented Reality Glasses", "Holographic Projector Pen", "Nanobot Repair Kit",
		                "Quantum Encryption Key", "Neural Net Enhancer", "Cybernetic Drone Companion", "Virtual Assistant AI Chip",
		                "Plasma Welding Torch", "Fusion-Powered Energy Cell", "Laser Range Finder", "Anti-Gravity Repulsor",
		                "Nanofabricator 3D Printer", "Magnetic Suspension Boots", "Biometric Security Scanner", "Genetic Modification Kit",
		                "AR Gaming Controller", "Quantum Communication Device", "Synthetic Skin Mask", "Dyson Sphere Power Generator",
		                "Teleportation Pad", "Quantum Data Storage Device", "Cyber Defense Firewall", "AI Language Translator",
		                "Neuromorphic Robotic Limb", "Invisibility Cloak Mk II", "Antimatter Reactor Core", "Molecular Replication Chamber",
		                "Gravity Manipulation Gauntlets", "Plasma Beam Cannon", "Neural Interface Headset", "Nanite Healing Injector",
		                "Digital Consciousness Uploader", "X-Ray Vision Goggles", "AI Supercomputer Cluster", "Chrono-Displacement Watch",
		                "Time Dilation Module", "Virtual Reality Simulator", "Holographic Medical Scanner", "Nanotech Flight Suit",
		                "Plasma Shield Generator Mk II", "Fusion-Powered Jetpack Mk II", "Inertial Dampening Field Mk II", "Molecular Teleportation Device Mk II",
		                "Nanoscopic Surveillance Drone Mk II", "Cybernetic Mind Enhancer Mk II", "Genome Editing Sequencer Mk II", "Reality Bending Prototype Mk II",
		                "Quantum Phase Shifter Mk II", "Telekinetic Amplifier Mk II", "Cyborg Exoskeleton Mk II", "Holodeck Simulator Mk II",
		                "Plasma Propulsion Engine Mk II", "Fusion-Powered Spacecraft Mk II", "Light Speed Navigation System Mk II", "Temporal Disruptor Mk II",
		                "Virtual Reality Arcade Pod Mk II", "Biomechanical Prosthetic Limb Mk II", "Gravity Manipulation Gauntlets Mk II", "Nanotech DNA Replicator Mk II",
		                "Digital Consciousness Upload Mk II", "Xenobiological Research Scanner Mk II", "Artificial Intelligence Virus Mk II", "Chrono-Anomaly Detector Mk II",
		                "Time Manipulation Device Mk II", "Virtual Neural Interface Mk II", "Gravity Suspension Harness Mk II", "Nanobot Medkit Mk II",
		                "Plasma Blade Mk II", "Fusion Energy Rifle Mk II", "Laser Guided Missile System Mk II", "Anti-Gravity Hoverboard Mk II",
		                "Nanoscopic Stealth Suit Mk II", "Cybernetic Neural Implant Mk II", "Genetic Memory Extractor Mk II", "Reality-Warping Prototype Mk II"
		            );
		            break;
		        case "sci fi":
		            _item_name = choose(
		                "Galactic Positioning System", "Astroportal Generator", "Exosolar Nanomaterials Scanner", "Cosmic Plasma Core",
		                "Hyperstellar Phase Modulator", "Astrobiotic Energy Capacitor", "Quantum Singularity Engine", "Nebulae Data Cluster",
		                "Astrophysical Energy Matrix", "Binary Star Harmonizer", "Cosmological Data Processor", "Dark Matter Capacitor",
		                "Electromagnetic Forcefield Generator", "Fusion Plasma Propulsion Unit", "Galaxy-wide Communication Device", "Hyperspace Harmonic Resonator",
		                "Interstellar Wormhole Stabilizer", "Jumpgate Chrono Detector", "Kiloparsec Warp Drive", "Light-year Distance Scanner",
		                "Magnetic Plasma Shield", "Nanoscopic Nanomaterial Synthesizer", "Omnidirectional Gravitational Anchor", "Photonic Quantum Amplifier",
		                "Quantum Energy Matrix", "Radiation Absorption Shield Mk II", "Stellar Fusion Harmonic Conductor Mk II", "Tachyon Particle Emitter Mk II",
		                "Universal Gravitational Inverter Mk II", "Vortex Phase Shift Array Mk II", "Warp Singularity Coil Mk II", "Xenomagnetic Field Manipulator Mk II",
		                "Yottabit Data Storage Matrix Mk II", "Zettavolt Power Transmitter Mk II", "Astrodynamic Trajectory Planner Mk II", "Binary Code Decryptor Mk II",
		                "Cosmic Expansion Drive Mk II", "Dyson Sphere Shell Mk II", "Extragalactic Hyperspace Conduit Mk II", "Fermionic Dark Matter Detector Mk II",
		                "Galactic Hyperspeed Propulsion Mk II", "Holographic Quantum Emitter Mk II", "Interdimensional Chrono Detector Mk II", "Jumpgate Harmonic Encryption Mk II",
		                "Kilometer-scale Nanofabricator Mk II", "Light-speed Phase Modulator Mk II", "Molecular Data Encryption Key Mk II", "Nanite Swarmer Control Sphere Mk II",
		                "Orbital Kinetic Bombardment Platform Mk II", "Photonic Ionization Amplifier Mk II", "Quantum Artificial Intelligence Nexus Mk II", "Radiation Absorption Shield Mk II",
		                "Stellar Graviton Emission Array Mk II", "Tachyon Phase Inverter Mk II", "Universal Spectrum Analyzer Mk II", "Vortex Singularity Core Mk II",
		                "Warp Field Synchronization Matrix Mk II", "Xenoarchaeological Research Probe Mk II", "Yoctosecond Time Dilation Module Mk II", "Zettahertz Quantum Processor Mk II",
		                "Astrophotonic Data Transceiver Mk II", "Binary Star Fusion Reactor Mk II", "Cosmic String Harmonic Oscillator Mk II", "Dark Energy Particle Collider Mk II",
		                "Extradimensional Hyper-Relay Mk II", "Fermionic Quantum Computing Array Mk II", "Galactic Chroniton Infuser Mk II", "Holographic Data Entanglement Module Mk II",
		                "Interstellar Gravitational Anomaly Detector Mk II", "Jumpgate Phase Disruptor Mk II", "Kilopulse Quantum Transceiver Mk II", "Lightning-infused Nanocircuit Mesh Mk II",
		                "Molecular Nanobot Replicator Mk II", "Nanotech Biohazard Containment Module Mk II", "Orbital Ion Cannon Array Mk II", "Photonic Pulse Disruptor Mk II",
		                "Quantum Biomechanical Enhancement Core Mk II", "Radiation-emitting Nanite Injector Mk II", "Stellar Fusion Harmonic Conductor Mk II", "Tachyon Phase Modulator Mk II",
		                "Universal Genetic Recoder Mk II", "Vortex Particle Accelerator Mk II", "Warp Gate Deployment Mechanism Mk II", "Xenomatter Energy Condenser Mk II",
		                "Yottabyte Supercomputer Core Mk II", "Zettameter Wormhole Stabilizer Mk II"
		            );
		            break;
		    }
		    break;
        case "gem":
		    switch (_genre) {
		        case "fantasy":
		            _item_name = choose(
		                "Crimson Firestone", "Emerald Enigma", "Sapphire Serenity", "Amber Arcanum",
		                "Topaz Twilight", "Ruby Radiance", "Aquamarine Aura", "Opal Oracle",
		                "Moonstone Mirage", "Jade Juxtaposition", "Garnet Gleam", "Diamond Delight",
		                "Onyx Omen", "Pearl Paragon", "Peridot Pinnacle", "Turquoise Tempest",
		                "Obsidian Onslaught", "Citrine Celestial", "Lapis Lazuli Labyrinth", "Rose Quartz Reverie",
		                "Bloodstone Battlement", "Aventurine Adventure", "Sunstone Sanctuary", "Carnelian Cascade",
		                "Malachite Marvel", "Azurite Ascension", "Tiger's Eye Thrill", "Coral Carousel",
		                "Star Diopside", "Angelite Affinity", "Black Agate", "White Howlite",
		                "Rainbow Pyrite", "Mystic Charoite", "Celestite Crystal", "Heliodor Halo",
		                "Amazonite Alchemy", "Bronzite Brilliance", "Danburite Dream", "Hematite Harmony",
		                "Kyanite Key", "Labradorite Luminescence", "Moldavite Marvel", "Orthoclase Oracle",
		                "Pietersite Portal", "Rhodonite Radiance", "Serpentine Spellbound", "Sodalite Solace",
		                "Zircon Zenith", "Ametrine Amulet", "Iolite Illusion", "Jet Juggernaut",
		                "Kunzite Keen", "Larimar Lagoon", "Melanite Moonlight", "Nuummite Nexus",
		                "Prasiolite Phantasy", "Que Sera Quasar", "Rainbow Moonstone", "Sugilite Sanctuary",
		                "Thulite Thrive", "Uvarovite Unity", "Vesuvianite Vision", "Wulfenite Wonder",
		                "Xenotime Xenon", "Yttrium Yonder", "Zoisite Zephyr"
		            );
		            break;
		        case "modern":
		            _item_name = choose(
		                "Crystal Clear Quartz", "Sparkling Diamond Dust", "Electric Blue Zircon", "Platinum Ice",
		                "Rose Gold Garnet", "Sleek Black Onyx", "Emerald City", "Amethyst Dream",
		                "Sapphire Starlight", "Pearlescent Moonstone", "Topaz Twilight", "Aquamarine Breeze",
		                "Ruby Radiance", "Citrine Sunbeam", "Opal Opulence", "Tourmaline Treasure",
		                "Turquoise Tranquility", "Peridot Paradise", "Jade Jewel", "Obsidian Obsession",
		                "Lapis Lazuli Luster", "Golden Beryl", "Moonlit Pearl", "Coral Coast",
		                "Rainbow Fluorite", "Titanium Trilliant", "Silver Moonbeam", "Bronze Citrine",
		                "Graphite Grapheme", "Indigo Iolite", "Lunar Labradorite", "Plasma Pyrite",
		                "Solar Celestite", "Uranium Uranite", "Neon Zircon", "Silicon Spinel",
		                "Titanium Tanzanite", "Helium Hematite", "Xenon Xenotime", "Yttrium Yag",
		                "Zinc Zirconia", "Argon Azurite", "Krypton Kunzite", "Calcium Crystal",
		                "Lithium Lepidolite", "Magnesium Malachite", "Potassium Peridot", "Rubidium Rhodonite",
		                "Sodium Serpentine", "Strontium Sodalite", "Barium Beryl", "Cesium Chrysoberyl",
		                "Gallium Galaxite", "Iodine Idocrase", "Rubidium Rhodochrosite", "Sulfur Sphene",
		                "Thallium Thulite", "Xenon Xenotime", "Niobium Nephrite", "Bismuth Benitoite",
		                "Boron Bornite", "Cadmium Carnelian", "Chromium Chrysoberyl", "Cobalt Coral",
		                "Germanium Grossular", "Radium Rhodonite", "Rhenium Rhodochrosite", "Tellurium Taaffeite",
		                "Thorium Thulite", "Uranium Uvarovite", "Vanadium Vesuvianite", "Zircon Zoisite"
		            );
		            break;
		        case "sci fi":
		            _item_name = choose(
		                "Luminous Plasma Gem", "Nanotech Diamondoid", "Quantum Crystal Lattice", "Hyperium Radiance",
		                "Cosmic Iridescence", "Neutrino Nebula Gem", "Antimatter Spark", "Graviton Glitterstone",
		                "Photon Prism Core", "Dark Matter Diamant", "Electron Enigma", "Exotic Particle Pearl",
		                "Chrono Crystal", "Nanomesh Gemstone", "Zero-Point Zircon", "Plasma Particle Inclusion",
		                "Tachyon Trinket", "Nuclear Fusion Flare", "Holographic Hemoquartz", "Molecular Mirage Gem",
		                "Astrovoid Ametrine", "Extradimensional Diamond", "Stellar Sapphire", "Ionized Ice Gem",
		                "Fusion Plasma Facet", "Radiant Resonance Crystal", "Transdimensional Tourmaline", "Warp Rift Ruby",
		                "Photon Fluxite", "Quantum Quasar Crystal", "Galactic Glowstone", "Nebula Nexus Gem",
		                "Plasma Pulse Prism", "Singularity Starstone", "Temporal Topaz", "Void Vortex Gem",
		                "Warp Bubble Beryl", "Xenomatter Crystal", "Zeta-Phase Zircon", "Gravitational Gem",
		                "Nanopulse Amethyst", "Interstellar Inclusion Opal", "Synthetic Singularity Gem", "Hypernova Heliodor",
		                "Quantum Entanglement Emerald", "Antigravity Ametrine", "Neutron Starstone", "Photonic Plasma Diamond",
		                "Electromagnetic Echo Gem", "Chroniton Chrysoberyl", "Nanoflare Crystal", "Zero-G Zeolite",
		                "Dark Energy Diamant", "Exoplanet Pearl", "Stellar Rift Ruby", "Ion Storm Sapphire",
		                "Fusion Flamestone", "Radiant Ripple Crystal", "Wormhole Quartz", "Plasma Prismatic Pearl",
		                "Tachyon Tear Gem", "Nucleonic Nacre", "Holographic Hyperionite", "Molecular Meteorite Gem",
		                "Astrofire Ametrine", "Exotic Echo Gem", "Cosmic Conflux Crystal", "Nebula Nexus Pearl",
		                "Plasma Particle Prism", "Singularity Sparkstone", "Temporal Twist Topaz", "Void Vortex Gem"
		            );
		            break;
		    }
		    break;
        case "key":
		    switch (_genre) {
		        case "fantasy":
		            _item_name = choose(
		                "Ancient Iron Key", "Enchanted Skeleton Key", "Emerald Lockpick", "Mystic Crystal Key",
		                "Rune-etched Key", "Golden Serpent Key", "Sorcerer's Sigil Key", "Wizard's Ward Key",
		                "Bronze Gate Key", "Silver Moon Key", "Copper Dragon Key", "Steel Guardian Key",
		                "Ruby Heart Key", "Sapphire Star Key", "Amethyst Tower Key", "Topaz Dungeon Key",
		                "Obsidian Crypt Key", "Crystal Butterfly Key", "Jade Emperor Key", "Garnet Phoenix Key",
		                "Diamond Enigma Key", "Pearl Sea Key", "Peridot Forest Key", "Turquoise Labyrinth Key",
		                "Moonstone Owl Key", "Bloodstone Skull Key", "Aventurine Thief Key", "Sunstone Sun Key",
		                "Carnelian Flame Key", "Malachite Moon Key", "Azurite Sea Key", "Tiger's Eye Talon Key",
		                "Black Agate Bat Key", "White Howlite Wolf Key", "Rainbow Pyrite Peacock Key", "Mystic Charoite Moon Key",
		                "Celestite Angel Key", "Heliodor Sunflower Key", "Amazonite Jungle Key", "Danburite Desert Key",
		                "Hematite Warrior Key", "Kyanite Crystal Key", "Labradorite Moonlight Key", "Moldavite Meteor Key",
		                "Orthoclase Mountain Key", "Pietersite Storm Key", "Rhodonite Rose Key", "Serpentine Serpent Key",
		                "Sodalite Sky Key", "Zircon Feather Key", "Ametrine Sunset Key", "Iolite Moon Key",
		                "Jet Shadow Key", "Kunzite Rose Key", "Larimar Ocean Key", "Melanite Night Key",
		                "Nuummite Galaxy Key", "Prasiolite Forest Key", "Que Sera Seraph Key", "Rainbow Moonstone Unicorn Key",
		                "Thulite Fairy Key", "Uvarovite Vine Key", "Vesuvianite Volcano Key", "Wulfenite Crystal Key",
		                "Xenotime Stardust Key", "Yttrium Celestial Key", "Zoisite Nature Key"
		            );
		            break;
		        case "modern":
		            _item_name = choose(
		                "High-Tech Access Key", "Biometric Security Key", "Nano-lock Encryption Key", "Quantum Code Key",
		                "Cybernetic Key Card", "Digital Iris Scanner Key", "Smart Lock Key", "Augmented Reality Key",
		                "Virtual Reality Key", "Stealthy Shadow Key", "Plasma Data Key", "Wireless Link Key",
		                "Neural Network Key", "Encryption Key 404", "AI Master Key", "Crypto Lock Key",
		                "Quantum Tunnel Key", "Cyber Fusion Key", "Holographic Key Token", "Nanobot Key Swarm",
		                "Invisible Cloak Key", "Laser Grid Key", "Stealth Matrix Key", "Cipher Lock Key",
		                "Phantom Key Signature", "Biohack Key Implant", "Stealth Bio-Key", "Nanofiber Mesh Key",
		                "Plasma Barrier Key", "Augmented Nano Key", "Data Stream Key", "Neuro Sync Key",
		                "Codebreaker Key", "Quantum Firewall Key", "Holocode Key", "Nanomesh Encryption Key",
		                "Stealth Matrix Key", "Optical Camouflage Key", "Nanobot Lock Key", "Neural Impulse Key",
		                "Cryptographic Key Card", "Cyber Defense Key", "Hacker's Backdoor Key", "Tracer Lock Key",
		                "Artificial Intelligence Key", "Quantum Encryption Key", "Digital Imprint Key", "Holo-Access Key",
		                "Intrusion Detection Key", "Neural Interface Key", "Cipher-locked Key Token", "Bio-code Key Implant",
		                "Plasma Shield Key", "Stealth Security Key", "Nano-Encoded Key", "Data Surge Key",
		                "Neuro-link Key", "Holographic Data Key", "Nanoflux Key", "Quantum Signature Key",
		                "Cybernetic Synchronization Key", "Invisible Bio-Key", "Laser Mesh Key", "Cipher Matrix Key",
		                "Phantom Neural Key", "Stealth AI Key", "Cryptolock Implant", "Nanoweave Lock Key",
		                "Plasma Fusion Key", "Virtual Reality Access Key", "Neural Encryption Key", "Holo-Matrix Key"
		            );
		            break;
		        case "sci fi":
		            _item_name = choose(
		                "Nanotech Unlocker", "Quantum Keyblade", "Gravity Keyflux", "Plasma Keypad Key",
		                "Dark Matter Skeleton Key", "Antigravity Access Key", "Graviton Lockpick", "Photon Crystal Key",
		                "Chrono Lock Key", "Nanomesh Encryption Key", "Zero-G Key Card", "Plasma Particle Key",
		                "Tachyon Security Key", "Nuclear Fusion Key", "Holographic Hex Key", "Molecular Stabilizer Key",
		                "Astrovoid Keychain", "Extradimensional Skeleton Key", "Stellar Gate Key", "Ionized Plasma Key",
		                "Fusion Core Key", "Radiant Resonance Key", "Transdimensional Key", "Warp Rift Access Key",
		                "Photon Flux Key", "Quantum Quasar Key", "Galactic Access Crystal", "Nebula Nexus Key",
		                "Plasma Pulse Keypad", "Singularity Skeleton Key", "Temporal Time Key", "Void Vortex Lockpick",
		                "Warp Bubble Key", "Xenomatter Unlocker", "Zeta-Phase Keycard", "Gravitational Gate Key",
		                "Nanopulse Encryption Key", "Interstellar Skeleton Key", "Synthetic Singularity Key", "Hypernova Access Key",
		                "Quantum Entanglement Key", "Antigravity Keypad", "Neutron Star Key", "Photonic Plasma Lock",
		                "Electromagnetic Skeleton Key", "Chroniton Code Key", "Nanoflare Access Key", "Zero-G Security Key",
		                "Dark Energy Key", "Exoplanet Encryption Key", "Stellar Rift Key", "Ion Storm Access Key",
		                "Fusion Flame Keypad", "Radiant Ripple Key", "Wormhole Access Key", "Plasma Prismatic Lock",
		                "Tachyon Tear Key", "Nucleonic Key", "Holographic Hyperion Key", "Molecular Meteorite Lockpick",
		                "Astrofire Access Key", "Exotic Echo Key", "Cosmic Conflux Key", "Nebula Nexus Keychain",
		                "Plasma Particle Keypad", "Singularity Spark Key", "Temporal Twist Lock", "Void Vortex Access Key"
		            );
		            break;
		    }
		    break;
        case "treasure":
		    switch (_genre) {
		        case "fantasy":
		            _item_name = choose(
		                "Golden Chalice", "Jeweled Crown", "Enchanted Amulet", "Silver Scepter",
		                "Gem-Encrusted Dagger", "Ancient Reliquary", "Elven Tiara", "Dragon's Hoard",
		                "Mystic Idol", "Gilded Coffer", "Emerald Pendant", "Chest of Arcane Runes",
		                "Sapphire Medallion", "Ruby-Adorned Goblet", "Diamond-Embossed Gauntlet", "Pearl-Encased Mirror",
		                "Citrine Figurine", "Topaz Statue", "Obsidian Carving", "Amethyst Adorned Skull",
		                "Garnet-Encrusted Scepter", "Jade-Embedded Staff", "Aquamarine Relic", "Onyx-Encrusted Coffer",
		                "Moonstone Jewelry Box", "Opal-Adorned Crown", "Quartz-Encrusted Sword", "Tourmaline-Studded Armor",
		                "Lapis Lazuli Scarab", "Malachite-Adorned Necklace", "Azurite-Inlaid Shield", "Tiger's Eye Idol",
		                "Coral-Encrusted Trident", "Amazonite Reliquary", "Agate-Adorned Bracers", "Bloodstone Chalice",
		                "Rainbow Moonstone Tiara", "Rhodonite-Encased Tome", "Sardonyx-Embedded Helm", "Sunstone-Encrusted Ring",
		                "Turquoise Statuette", "Fluorite-Adorned Robes", "Jasper-Inlaid Staff", "Kyanite Figurine",
		                "Labradorite Relic", "Aventurine Carving", "Moonstone Pendant", "Nuummite-Adorned Scepter",
		                "Prasiolite-Encrusted Bow", "Rhodochrosite Idol", "Sodalite-Adorned Chalice", "Zircon-Encrusted Coffer",
		                "Ametrine Figurine", "Heliodor-Embedded Staff", "Iolite-Inlaid Shield", "Jet-Encrusted Dagger",
		                "Kunzite-Adorned Mirror", "Larimar Reliquary", "Melanite-Encrusted Gauntlet", "Nuummite-Encased Tome",
		                "Prasiolite Jewelry Box", "Que Sera-Adorned Crown", "Rainbow Pyrite Sword", "Thulite-Studded Armor",
		                "Uvarovite Scarab", "Vesuvianite-Adorned Necklace", "Wulfenite-Inlaid Tiara", "Xenotime-Encrusted Ring",
		                "Yttrium Statuette", "Zoisite-Adorned Robes", "Ametrine-Inlaid Staff", "Heliodor Figurine",
		                "Amazonite Relic", "Danburite Carving", "Hematite Pendant", "Kyanite-Encrusted Scepter",
		                "Labradorite-Adorned Bracers", "Moldavite Chalice", "Orthoclase-Encrusted Trident", "Pietersite Idol",
		                "Rhodonite-Embedded Helm", "Serpentine-Encrusted Shield", "Sodalite Tiara", "Zircon-Adorned Mirror",
		                "Aventurine Jewelry Box", "Bloodstone-Adorned Crown", "Rainbow Moonstone Gauntlet", "Thulite-Encrusted Dagger"
		            );
		            break;
		        case "modern":
		            _item_name = choose(
		                "Priceless Artwork", "Rare Vintage Wine", "Antique Pocket Watch", "Precious Gemstone Necklace",
		                "Limited Edition Collectible", "Vintage Movie Poster", "Exotic Car Model", "Historical Memorabilia",
		                "Signed First Edition Book", "Rare Coin Collection", "Luxury Timepiece", "Exclusive Fashion Accessory",
		                "Designer Handbag", "Customized Sports Jersey", "High-End Electronics", "Rare Vinyl Record",
		                "Limited Edition Sneakers", "Vintage Arcade Machine", "Classic Retro Game Console", "High-Performance Racing Bike",
		                "Luxury Yacht", "Private Jet", "Custom Supercar", "State-of-the-Art Smartphone",
		                "Top-of-the-Line Gaming PC", "Designer Sunglasses", "Premium Whiskey Collection", "Fine Art Sculpture",
		                "Exquisite Crystal Vase", "Custom Tailored Suit", "Rare Stamps Collection", "Handcrafted Fountain Pen",
		                "Collectible Trading Cards", "Premium Cigar Humidor", "Designer Perfume Collection", "Exclusive Wine Cellar",
		                "Luxurious Spa Retreat", "High-End Home Theater System", "Customized Guitar",
		                "Rare Limited Edition Sneakers", "Exclusive Members-Only Club Access", "Diamond-Encrusted Cufflinks",
		                "Premium Quality Leather Wallet", "Luxury Vacation Package", "Private Island Getaway", "Fine Silver Tea Set",
		                "Vintage Typewriter", "Collectible Art Prints", "Exclusive Fashion Runway Show Tickets", "Designer Diamond Ring",
		                "Custom-Made Furniture", "Handcrafted Swiss Watch", "Premium Champagne Collection", "Rare Whiskey Tasting Experience",
		                "Exclusive Celebrity Meet and Greet", "Limited Edition Smartwatch", "Custom Art Commission",
		                "Luxury Safari Adventure", "Top-Of-The-Line Camera Equipment", "Designer Home Decor", "Rare Book Collection",
		                "Exclusive Culinary Masterclass", "Vintage Fountain Pen Collection", "High-End Audio Speakers",
		                "Luxury Business Class Travel Package", "Premium Quality Headphones", "Rare Vintage Car",
		                "Custom-Made Luxury Shoes", "Designer Evening Gown", "Collectible Action Figures",
		                "Exclusive VIP Concert Experience", "Diamond-Encrusted Smartphone", "Premium Leather Travel Bag",
		                "Luxury Golfing Experience", "Top-Of-The-Line Fitness Equipment", "Designer Silk Scarf", "Fine Crystal Decanter",
		                "Collectible Movie Props", "Exclusive Wine Tasting Tour", "Rare Artifacts from Historical Events",
		                "Custom-Made Tailored Tuxedo", "Handcrafted Platinum Pen", "Premium Quality Luggage Set"
		            );
		            break;
		        case "sci fi":
		            _item_name = choose(
		                "Alien Artifact", "Quantum Energy Core", "Time-Travel Device", "Celestial Star Map",
		                "Anti-Gravity Device", "Extraterrestrial Crystal", "Nanobot Swarm Capsule", "Cosmic Singularity Lens",
		                "Holographic Holo-Disc", "Interstellar Warp Drive", "Hyperdrive Navigation Module", "Quantum Entanglement Communicator",
		                "Plasma Blaster Cannon", "Xeno-Technology Implant", "Dark Matter Container", "Synthetic AI Brain",
		                "Astro-Relic Decoder", "Galactic Plasma Reactor", "Exotic Matter Manipulator", "Temporal Rift Stabilizer",
		                "Exoplanetary Exploration Rover", "Nebula Infused Nebulizer", "Stellar Radiation Shield", "Ion Thruster Engine",
		                "Fusion Power Generator", "Radiant Plasma Sword", "Wormhole Manipulator", "Cosmic Plasma Coil",
		                "Photon Beam Emitter", "Graviton Particle Accelerator", "Nuclear Fusion Capsule", "Exo-Quantum Capacitor",
		                "Stellar Cartography Console", "Astrovoid Probe Launcher", "Antigravity Hoverboard", "Nanotech Replicator Module",
		                "Chrono-Anchor Timepiece", "Vortex Phase Manipulator", "Transdimensional Gateway", "Astro-Plasma Crystal",
		                "Exo-Suit Plasma Cannon", "Quantum Phase Shifter", "Gravity Inversion Matrix", "Quantum Gravity Amplifier",
		                "Xenomorph Sample Container", "Temporal Displacement Device", "Interstellar Wormhole Beacon", "Nuclear Star Core",
		                "Dark Energy Infused Alloy", "Astro-Tracker Scanning Array", "Exotic Particle Projector", "Ionized Plasma Grenade",
		                "Fusion Plasma Blaster", "Radiant Energy Crystal", "Warp Singularity Inducer", "Photon Energy Cell",
		                "Graviton Wave Emitter", "Cosmic Radiation Shield", "Photon Pulse Generator", "Nuclear Fusion Reactor",
		                "Synthetic AI Consciousness Matrix", "Astro-Graviton Thruster", "Antigravity Suspension System", "Nanotech Quantum Scanner",
		                "Chrono-Phase Manipulator", "Vortex Singularity Generator", "Transdimensional Warp Drive", "Astro-Quantum Crystal",
		                "Exo-Graviton Capacitor", "Quantum Flux Stabilizer", "Gravity Displacement Matrix", "Quantum Singularity Engine",
		                "Xenomorph Genome Sequencer", "Temporal Disruptor Array", "Interstellar Star Chart", "Nuclear Fusion Propulsion System",
		                "Dark Energy Infused Shield", "Astro-Pulse Radar", "Exotic Particle Accelerator", "Ionized Plasma Blaster",
		                "Fusion-Powered Energy Sword", "Radiant Plasma Pistol", "Warp Singularity Manipulator", "Photon Phase Modulator"
		            );
		            break;
		    }
		    break;
        default:
            return "";
    }

    return _item_name;
}