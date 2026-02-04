/// @description Generate a random name for food.
/// @function random_name_generator_food
/// @param type - The type of food ("snack", "meal", "dessert", "beverage").
/// @param genre - The genre for which the food name should be generated ("fantasy", "modern", "sci-fi").
/// @returns The generated food name as a string.
function random_name_generator_food(_type, _genre) {
    var _food_name;
	
	if(_genre == undefined)
		_genre = choose("fantasy", "modern", "sci-fi");
	
    // Randomly select a food name based on the type and genre.
    switch (_type) {
        case "snack":
		    switch (_genre) {
		        case "fantasy":
		            _food_name = choose(
		                "Enchanted Crystals", "Dragon Bites", "Pixie Popcorn", "Fairy Fizz", "Wizard Wafers", "Unicorn Drops",
		                "Goblin Gummies", "Mermaid Munchies", "Centaur Chips", "Sorcerer Snacks", "Elf Eclairs", "Griffin Grains",
		                "Phoenix Puffs", "Pegasus Pretzels", "Magic Morsels", "Gnome Grits", "Troll Treats", "Mystical Macarons",
		                "Chimera Chews", "Wyvern Wonders", "Ogre Oreos", "Siren Sweets", "Gorgon Granola", "Banshee Biscuits",
		                "Faun Fries", "Nymph Nibbles", "Cyclops Crunch", "Satyr Skittles", "Hippogriff Hushpuppies", "Leprechaun Loot",
		                "Minotaur Munchkins", "Vampire Velvet Cake", "Werewolf Waffles", "Witch's Whims", "Kraken Krunch", "Genie Gems",
		                "Dwarf Delights", "Sphinx Snaps", "Basilisk Bites", "Gremlin Grub", "Manticore Mix", "Harpy Hashbrowns",
		                "Centaurs' Caramel", "Changeling Cheesecake", "Hobgoblin Hash", "Imp Icing", "Lich Lollipops", "Naiad Nuggets",
		                "Phoenix Popsicles", "Salamander Slices", "Valkyrie Vittles", "Yeti Yummies", "Zombie Zingers", "Djinn Donuts",
		                "Cerberus Cookies", "Faerie Fritters", "Jinn Jellies", "Wendigo Wraps", "Boggart Bites", "Specter Sliders",
		                "Satyr Sorbet", "Hydra Hashbrowns", "Ghoul Goulash", "Merfolk Muffins", "Kelpie Krisps", "Unicorn Upside-Down Cake",
		                "Griffon Gelato", "Golem Gravy", "Kraken Krackles", "Orc Oreos", "Elemental Energy Bars", "Vampire Voodoo Dolls",
		                "Werewolf Wontons", "Medusa Meringue", "Banshee Brownies", "Chimera Chunks", "Witch's Wontons", "Hobgoblin Hotdogs",
		                "Mummy Macaroons", "Nymph Noodles", "Gargoyle Goo", "Sphinx Sausages", "Leprechaun Loaves", "Marauder Muffins",
		                "Doppelganger Dumplings", "Banshee Berries", "Kitsune Kettle Corn", "Harpy Hot Sauce", "Gorgon Gushers",
		                "Ghoul Gumbo", "Nereid Nachos", "Pixie Pudding", "Goblin Goulash", "Hag Hash", "Sylph Sundaes", "Cyclops Cupcakes",
		                "Nymph Nog", "Kobold Kookies", "Oni Omelettes", "Siren Souffle", "Harpie Hash", "Gargoyle Grapes", "Kraken Kelp",
		                "Valkyrie Veggies", "Yeti Yogurt", "Zombie Ziti", "Lich Linguine", "Troll Tacos", "Naiad Nectar", "Orc Onigiri",
		                "Pegasus Pancakes", "Basilisk Burritos", "Gremlin Guacamole", "Minotaur Mousse"
		            );
		            break;
		        case "modern":
		            _food_name = choose(
		                "Cheesy Nachos", "Buffalo Wings", "Crispy Tater Tots", "Mozzarella Sticks", "Garlic Knots", "Loaded Fries",
		                "Onion Rings", "Sweet Potato Fries", "Jalapeno Poppers", "Mini Sliders", "Sriracha Popcorn", "Chicken Skewers",
		                "BBQ Ribs", "Fish Tacos", "Teriyaki Meatballs", "Spicy Guacamole", "Bruschetta", "Bacon-wrapped Shrimp", "Artichoke Dip",
		                "Stuffed Mushrooms", "Caprese Salad", "Baked Mac and Cheese Bites", "Hummus Platter", "Deviled Eggs", "Caesar Salad",
		                "Shrimp Cocktail", "Fried Calamari", "Spinach and Artichoke Dip", "Crab Cakes", "Fried Pickles", "Chicken Quesadilla",
		                "Chili Cheese Fries", "Mango Salsa", "Chicken Wings Sampler", "Pita and Hummus", "Buffalo Cauliflower Bites", "Garlic Bread",
		                "Loaded Potato Skins", "Veggie Spring Rolls", "Gourmet Popcorn", "Chicken Satay", "Guacamole and Chips", "Stuffed Bell Peppers",
		                "Chicken Tenders", "Crispy Spring Rolls", "Avocado Toast", "Greek Salad", "Teriyaki Wings", "Chicken Taquitos", "Potato Wedges",
		                "Stuffed Jalapenos", "Bacon-wrapped Dates", "Mango Habanero Wings", "Steak Bites", "Cucumber Sushi Rolls", "Tomato Bruschetta",
		                "Garlic Parmesan Wings", "Loaded Nachos", "Fried Mozzarella Balls", "Sausage Stuffed Mushrooms", "Soy-glazed Meatballs",
		                "Garlic Butter Shrimp", "Baked Brie with Cranberries", "Coconut Shrimp", "Sweet Chili Chicken", "Chicken Fajita Nachos",
		                "Fried Avocado Bites", "Bacon-wrapped Scallops", "Vegetable Dumplings", "Cauliflower Buffalo Bites", "Spicy Tuna Tartare",
		                "Stuffed Grape Leaves", "Caramelized Onion Dip", "Baked Buffalo Cauliflower", "Teriyaki Salmon Bites", "Chicken Dumplings",
		                "Sweet and Sour Meatballs", "Avocado Fries", "Bacon-wrapped Jalapenos", "Cheese Stuffed Pretzels", "Pulled Pork Sliders",
		                "Bruschetta Chicken", "Baked Spinach Dip", "Garlic Herb Shrimp", "Fried Ravioli", "Caprese Skewers", "Thai Lettuce Wraps",
		                "Buffalo Chicken Dip", "Vegetarian Spring Rolls", "Bacon Cheeseburger Sliders", "Spinach and Feta Phyllo Cups", "Mango BBQ Wings",
		                "Crab Rangoon", "Vegetable Samosas", "Crispy Coconut Shrimp", "Fried Green Beans", "Chicken Parmesan Sliders",
		                "Jalapeno Bacon-wrapped Shrimp", "Spicy Tofu Bites", "Guava Glazed Chicken Wings", "Baked Zucchini Fries", "Shrimp Ceviche",
		                "Feta Stuffed Mushrooms", "Greek Spanakopita", "Coconut Chicken Tenders", "Buffalo Chicken Egg Rolls"
		            );
		            break;
		        case "sci-fi":
		            _food_name = choose(
		                "Alien Antennas", "Space Sliders", "Cosmic Quesadillas", "Galactic Guacamole", "Meteor Muffins", "Astronaut Apples",
		                "Satellite Sundaes", "Rocket Rolls", "Interstellar Ice Cream", "Nebula Nachos", "Starship Spring Rolls", "Cosmos Cookies",
		                "Lunar Lasagna", "Orbiting Onion Rings", "Robotic Ramen", "Futuristic Fried Rice", "UFO Utensils", "Quantum Quiche",
		                "Astro Avocado Toast", "Supernova Sushi", "Zero-Gravity Gummies", "Solar System Skewers", "Cybernetic Cheesecake",
		                "Cosmonaut Cauliflower", "Asteroid Almonds", "Martian Macarons", "Galaxy Goulash", "Cosmic Cake Pops", "Laser-Beam Lemons",
		                "Black-Hole Brownies", "Extraterrestrial Eclairs", "Cosmic Carrots", "Neptune Nectarines", "Saturnian Smoothies",
		                "Jupiterian Jello", "Andromeda Algae", "Pluto Popsicles", "Celestial Sorbet", "Mars Melons", "Mercury Mints",
		                "Venusian Veggies", "Earthly Energy Bars", "Solar Flare Fajitas", "Galaxy Granola Bars", "Starfruit Salad", "Rocketeer Ravioli",
		                "Astro-Adventurer Asparagus", "Cosmic Cranberries", "Meteorite Mushrooms", "Galactic Gingerbread", "Saturn's Sweet Potato Fries",
		                "Quasar Quail Eggs", "Asteroid Anchovies", "Jovian Jellybeans", "Galaxy Garlic Bread", "Nebula Noodles", "Starlight Swiss Chard",
		                "Cosmic Cucumber Salad", "Astronomer's Artichokes", "Supernova Snickers", "Lunar Lemonade", "Stellar Sausages", "Milky Way Meringues",
		                "Zero-Gravity Gnocchi", "Cyborg Cauliflower Rice", "Exoplanet Empanadas", "Comet Caramel Corn", "Stardust Spinach", "Space Station Stew",
		                "Galactic Gouda", "Rocketfuel Radishes", "Asteroid Almond Butter", "Martian Mashed Potatoes", "Meteorite Meatballs",
		                "Nebula Nougat", "Robot Romaine Lettuce", "Quasar Quinoa", "Astronomer's Almond Milk", "Cosmic Coconuts", "Jovian Jasmine Rice",
		                "Galactic Grapefruit", "Stardust Streusel", "Supernova Sweetbreads", "Extraterrestrial Escargot", "Cybernetic Cabbage Rolls",
		                "Satellite Seitan", "Asteroid Avocado", "Solar-Flare Salsa", "Interstellar Italian Ice", "Cosmic Cornbread", "Galaxy Gourmet Grapes"
		            );
		            break;
		    }
			break;
		
		case "meal":
		    switch (_genre) {
		        case "fantasy":
		            _food_name = choose(
		                "Dragonfire Grilled Steak", "Elven Enchanted Quinoa Bowl", "Mage's Magical Meat Pie", "Orcish Feast Stew",
		                "Goblin Gourmet Goulash", "Sorcerer's Supreme Salad", "Wizard's Whimsical Wontons", "Unicorn Unicornicorn Burger",
		                "Mermaid's Seafood Platter", "Centaur's Herb-Roasted Chicken", "Fairy's Fabled Fried Rice", "Gryphon's Gourmet Grilled Cheese",
		                "Phoenix Flame-Grilled Fish", "Pegasus Pesto Pasta", "Troll Tenderloin Tacos", "Mystic Mushroom Risotto", "Chimera Charred Chops",
		                "Wyvern Wings and Waffles", "Enchanted Forest Frittata", "Gnome's Garden Greens", "Manticore Meatball Sub", "Harpy's Harvest Hash",
		                "Cyclops Charcuterie Board", "Satyr's Savory Skewers", "Hippogriff's Hearty Hashbrowns", "Leprechaun's Lucky Lamb Stew",
		                "Minotaur's Mighty Meatloaf", "Vampire's Voluptuous Vegetables", "Werewolf's Wondrous Wrap", "Witch's Wholesome Waffles",
		                "Kraken Krusty Calamari", "Genie's Glorious Grains", "Dwarf's Delicious Dumplings", "Sphinx's Sensational Souvlaki",
		                "Gremlin's Grilled Greens", "Banshee's Bewitching Burrito", "Faun's Fresh Fajitas", "Nymph's Nutritious Noodles",
		                "Centaurs' Carrot Cake", "Changeling's Charming Chowder", "Hobgoblin's Hearty Hummus", "Imp's Incendiary Ice Cream",
		                "Lich's Luscious Lasagna", "Naiad's Nutty Naan", "Phoenix's Phenomenal Pizza", "Salamander's Sizzling Seafood",
		                "Valkyrie's Veggie Vol-au-vent", "Yeti's Yummy Yams", "Zombie's Zesty Ziti", "Djinn's Delicious Dolmas",
		                "Cerberus's Celebrated Cornbread", "Faerie's Flavorful Falafel", "Jinn's Juicy Jambalaya", "Wendigo's Wholesome Wrap",
		                "Boggart's Bountiful Bowl", "Specter's Spooky Sushi", "Satyr's Spicy Sliders", "Hydra's Heavenly Hotpot",
		                "Ghoul's Grilled Gnocchi", "Merfolk's Medley", "Kelpie's Kelp Noodles", "Unicorn's Uplifting Upside-Down Cake",
		                "Griffon's Gracious Gratin", "Golem's Gourmet Gravy", "Kraken's Kooky Kebabs", "Orc's Outrageous Orzo",
		                "Elemental's Energizing Energy Bars", "Vampire's Voodoo Veggies", "Werewolf's Wonderful Wraps", "Medusa's Marvelous Moussaka",
		                "Banshee's Bewitching Brownies", "Chimera's Cheesy Chips", "Witch's Wonton Wrappers", "Hobgoblin's Hotdogs",
		                "Mummy's Marvelous Macarons", "Nymph's Nutty Nectar", "Gargoyle's Gourmet Gumbo", "Sphinx's Spicy Stew",
		                "Leprechaun's Lucky Loaves", "Marauder's Mesmerizing Muffins", "Doppelganger's Delightful Dumplings",
		                "Banshee's Berry-licious Bites", "Kitsune's Krazy Kettle Corn", "Harpy's Hearty Hot Sauce", "Gorgon's Grape Gazpacho",
		                "Ghoul's Gumbo", "Nereid's Nourishing Nachos", "Pixie's Party Pudding", "Goblin's Gratifying Goulash",
		                "Hag's Homestyle Hash", "Sylph's Scrumptious Sundaes", "Cyclops's Creamy Cupcakes", "Nymph's Nutty Nog",
		                "Kobold's Karrot Kookies", "Oni's Outstanding Onigiri", "Siren's Serenading Souffle", "Harpie's Hearty Hash",
		                "Gargoyle's Grape Grapes", "Kraken's Kelp Wrap", "Valkyrie's Vibrant Veggies", "Yeti's Yogurt",
		                "Zombie's Zesty Ziti", "Lich's Linguine", "Troll's Tasty Tacos", "Naiad's Nutritious Nectar", "Orc's Outstanding Onigiri",
		                "Pegasus's Palatable Pancakes", "Basilisk's Bold Burritos", "Gremlin's Guacamole", "Minotaur's Magnificent Mousse"
		            );
		            break;
		        case "modern":
		            _food_name = choose(
		                "Classic Cheeseburger", "Chicken Alfredo", "Margherita Pizza", "BBQ Pulled Pork Sandwich", "Grilled Vegetable Panini",
		                "Caesar Salad with Grilled Chicken", "Steak Fajitas", "Teriyaki Salmon", "Mushroom and Swiss Burger", "Fettuccine Alfredo",
		                "Pepperoni Pizza", "Grilled Chicken Wrap", "Caprese Salad", "Pesto Chicken Panini", "Buffalo Chicken Sandwich", "Cobb Salad",
		                "Fish and Chips", "Spaghetti Bolognese", "Mushroom Burger", "Chicken Caesar Wrap", "California Cobb Salad", "Lobster Roll",
		                "Club Sandwich", "Chicken and Waffles", "Mango Habanero Wings", "Chicken Parmesan", "Greek Salad", "Cajun Shrimp Pasta",
		                "BBQ Bacon Cheeseburger", "Southwest Chicken Salad", "Fish Tacos", "Chicken and Avocado Quesadilla", "Caesar Salad Wrap",
		                "BBQ Bacon Chicken Sandwich", "Teriyaki Veggie Stir-Fry", "Italian Sub", "Bacon Ranch Chicken Wrap", "Classic Cobb Salad",
		                "Hawaiian Pizza", "Philly Cheesesteak", "Avocado Caprese Wrap", "Grilled Chicken and Quinoa Salad", "Pulled BBQ Chicken Sandwich",
		                "Mediterranean Pasta Salad", "Veggie Panini", "Turkey Club Wrap", "Chicken Pesto Pasta", "Crispy Chicken BLT Sandwich",
		                "Asian Sesame Chicken Salad", "Lemon Herb Grilled Salmon", "Mushroom and Spinach Quesadilla", "BBQ Chicken Salad",
		                "Grilled Portobello Burger", "Shrimp Scampi", "California Club Sandwich", "Thai Peanut Chicken Wrap", "Spinach and Feta Pizza",
		                "Steak and Cheese Sub", "Caprese Panini", "Chicken Caesar Salad", "Baja Fish Tacos", "Spicy Buffalo Chicken Wrap",
		                "Greek Chicken Souvlaki", "Pesto Veggie Pizza", "Classic Reuben Sandwich", "Grilled Veggie Wrap", "Mediterranean Chicken Salad",
		                "Garlic Butter Shrimp Pasta", "Crispy Chicken Sandwich", "Cobb Salad Wrap", "Hawaiian BBQ Chicken Pizza", "Meatball Sub",
		                "Chicken and Broccoli Alfredo", "BBQ Ranch Chicken Salad", "Vegetarian Panini", "Turkey and Bacon Club", "Pesto Shrimp Pasta",
		                "Buffalo Cauliflower Sandwich", "Chicken Caesar Wrap", "California Chicken Salad", "Fisherman's Seafood Pizza", "Philly Cheesesteak Wrap",
		                "Caprese Salad Wrap", "Teriyaki Tofu Stir-Fry", "Italian Hero Sub", "Avocado BLT Wrap", "Greek Orzo Salad", "Bacon Avocado Burger",
		                "Southwest Steak Salad", "Lemon Garlic Shrimp Pasta", "Grilled Chicken Club Sandwich", "Mediterranean Veggie Panini",
		                "Thai Peanut Veggie Wrap", "Spinach and Artichoke Pizza", "Chicken Pesto Panini", "Classic Turkey Sandwich", "Grilled Vegetable Salad",
		                "Sweet and Sour Shrimp Stir-Fry", "Crispy Chicken Caesar Salad", "Buffalo Chicken Wrap", "California Turkey Club", "Shrimp Alfredo",
		                "BBQ Chicken Sandwich", "Mediterranean Chickpea Salad", "Portobello Mushroom Panini", "Turkey Reuben Sandwich", "Pesto Chicken Pasta"
		            );
		            break;
		        case "sci-fi":
		            _food_name = choose(
		                "Astro Burger", "Stellar Steak", "Alien Asparagus", "Cosmic Carbonara", "Saturnian Sushi", "Lunar Lasagna",
		                "Neptune Noodles", "Interstellar Stir-Fry", "Martian Meatloaf", "Pluto Popsicles", "Jupiterian Jambalaya", "Andromeda Artichokes",
		                "Black-Hole Bagels", "Galactic Grilled Cheese", "Meteor Macarons", "Exoplanet Enchiladas", "Supernova Sliders", "Quantum Quiche",
		                "Cosmic Cauliflower", "Space Shrimp Scampi", "UFO Udon Noodles", "Solar Flare Fajitas", "Robot Ramen", "Nebula Nachos",
		                "Stardust Sushi Rolls", "Cyborg Cabbage Rolls", "Galaxy Gumbo", "Asteroid Alfredo", "Orbiting Onion Rings", "Celestial Cheesecake",
		                "Stellar Salmon", "Comet Caramel Corn", "Galactic Goulash", "Rocket Roll-ups", "Meteorite Meatballs", "Cybernetic Cheesesteak",
		                "Space Station Stew", "Astronaut Asparagus", "Planetary Poutine", "Soylent Sliders", "Cosmonaut Cauliflower Rice", "Starship Stir-Fry",
		                "Neon Noodles", "Astro Avocado Toast", "Moon Mochi", "Zero-Gravity Gummies", "Satellite Salad", "Spacey Spinach", "Robot Risotto",
		                "Meteorite Meringue", "Stardust Smoothie", "Galactic Granola", "Rocketeer Ravioli", "Alien Antipasto", "Supernova Sorbet",
		                "Quantum Quinoa", "Cosmic Cornbread", "Space-age Spinach Dip", "Astronomer's Apple Pie", "Starlight S'mores", "Cybernetic Cinnamon Rolls",
		                "Martian Muffins", "Galactic Gingersnaps", "Asteroid Almond Butter Cups", "Stellar Shortbread", "Comet Cupcakes", "Robot Raspberry Bars",
		                "Saturn's Sugar Cookies", "Extraterrestrial Éclairs", "Space Station Snickerdoodles", "Astronaut Ice Cream Sandwiches",
		                "Galactic Gooey Butter Cake", "Lunar Lemon Bars", "Nebula Nutella Crepes", "Rocket Fuel Red Velvet Cake", "Cosmic Carrot Cake",
		                "Soylent Chocolate Cake", "Starship Strawberry Shortcake", "Neon Neapolitan Ice Cream", "Astro Apple Crisp", "Moon Mousse",
		                "Meteor Mochaccino", "Quantum Quince Tart", "Galaxy Gelato", "Space Shuttle Sorbet", "Interstellar Iced Tea", "Robot Rooibos Tea",
		                "Satellite Smoothie", "Nebula Nitro Cold Brew", "Stardust Sparkling Water", "Cosmic Cappuccino", "Astro Affogato", "Milky Way Macchiato",
		                "Rocketeer Roasted Coffee", "Comet Cold Brew", "Astronaut Americano", "Supernova Soy Latte", "Quantum Quencher", "Cosmic Caramel Macchiato"
		            );
		            break;
		    }
			break;
		
        case "dessert":
		    switch (_genre) {
		        case "fantasy":
		            _food_name = choose(
		                "Enchanted Chocolate Cake", "Magical Berry Tart", "Fairy's Frosty Cupcake", "Dragon's Breath Brownie", "Pixie's Plum Pudding",
		                "Unicorn's Rainbow Macaron", "Wizard's Wand Wafer", "Mermaid's Seafoam Sorbet", "Elf's Eclairs", "Sorcerer's Stone Ice Cream",
		                "Goblin's Gourmet Gelato", "Gryphon's Golden Donut", "Phoenix's Fire Fruitcake", "Cyclops's Cherry Crisp", "Mystic Mango Mousse",
		                "Chimera's Choco-Chip Cookies", "Satyr's S'mores", "Hippogriff's Honeycomb", "Nymph's Nougat", "Centaur's Caramel Corn",
		                "Harpy's Hazelnut Truffles", "Valkyrie's Velvet Cupcake", "Minotaur's Mint Milkshake", "Siren's Sea Salt Caramel", "Leprechaun's Lucky Pudding",
		                "Gargoyle's Gingerbread", "Kraken's Krunchy Kringle", "Banshee's Blueberry Cobbler", "Medusa's Magic Muffin", "Naiad's Nutella Crepe",
		                "Cerberus's Cinnamon Rolls", "Fairy's Fig Fudge", "Djinn's Date Delight", "Gorgon's Glazed Grapes", "Sylph's Sugar Swirls",
		                "Gnome's Grapefruit Granita", "Manticore's Mango Float", "Witch's Walnut Brownie", "Imp's Ice Cream Sandwich", "Vampire's Velvet Pie",
		                "Werewolf's Whipped Cheesecake", "Yeti's Yogurt Parfait", "Zombie's Zesty Zabaglione", "Kitsune's Kinako Kudzu Cake", "Griffon's Golden Gelato",
		                "Elemental's Eclair Extravaganza", "Basilisk's Blueberry Biscuit", "Gremlin's Gooey Gingersnap", "Wendigo's White Chocolate Mousse",
		                "Boggart's Blackberry Buckle", "Specter's Spooky Sundae", "Hydra's Honeydew Sorbet", "Ghoul's Grape Gelatin", "Merfolk's Mango Marshmallow",
		                "Kelpie's Kiwi Kiwifruit Tart", "Unicorn's Ube Utopia", "Marauder's Mocha Macaron", "Doppelganger's Delightful Danish", "Kitsune's Kooky Kabocha Pie",
		                "Harpy's Heavenly Hazelnut Cake", "Gorgon's Glittering Green Grapes", "Nereid's Nutty Nectarine Parfait", "Pixie's Peach Puff Pastry",
		                "Banshee's Bewitched Blackberry Cobbler", "Chimera's Cherry Chocolate Chip Cookies", "Witch's Whimsical White Chocolate Macadamia Nut Cookies",
		                "Siren's Sensational Strawberry Shortcake", "Gremlin's Ginger Snap Ice Cream Sandwiches", "Hobgoblin's Haunting Honeycomb Candy",
		                "Basilisk's Bewitching Blueberry Buckle", "Faun's Fantastic Fig and Honey Ice Cream", "Goblin's Ghoulish Grape Gelatin", "Mummy's Mesmerizing Mango Mousse",
		                "Nymph's Nutty Nutella Crepe Cake", "Phoenix's Fiery Fruitcake", "Salamander's Sizzling S'mores", "Valkyrie's Velvety Vanilla Cupcake",
		                "Yeti's Yummy Yogurt Parfait", "Ghoul's Gruesome Grapefruit Granita", "Manticore's Marvelous Mango Float", "Sphinx's Scintillating Strawberry Sorbet",
		                "Zombie's Zany Zabaglione", "Djinn's Delectable Date Delight", "Wendigo's Wicked White Chocolate Mousse", "Cyclops's Crunchy Cherry Crisp",
		                "Gorgon's Glossy Glazed Grapes", "Sylph's Swirling Sugar Swirls", "Boggart's Bewitching Blackberry Buckle", "Specter's Spectacular Spooky Sundae",
		                "Naiad's Nourishing Nutella Crepe Cake", "Marauder's Marvelous Mocha Macaron", "Doppelganger's Divine Danish", "Kitsune's Kooky Kabocha Pie",
		                "Griffon's Glittering Gelato", "Elemental's Extraordinary Eclair Extravaganza", "Banshee's Blissful Blueberry Cobbler", "Medusa's Marvelous Magic Muffin",
		                "Gargoyle's Gleaming Gingerbread", "Gremlin's Gorgeous Gooey Gingersnap", "Hag's Haunting Hazelnut Truffles", "Vampire's Velvety Velvet Pie",
		                "Minotaur's Minty Milkshake", "Witch's Wonderful Walnut Brownie", "Imp's Irresistible Ice Cream Sandwich", "Centaur's Creamy Caramel Corn",
		                "Satyr's Scrumptious S'mores", "Hippogriff's Heavenly Honeycomb", "Nymph's Nice Nougat"
		            );
		            break;
		        case "modern":
		            _food_name = choose(
		                "Classic Chocolate Cake", "Cheesecake with Raspberry Sauce", "Fudgy Brownies", "Apple Pie with Vanilla Ice Cream", "New York Style Cheesecake",
		                "Red Velvet Cupcakes", "Lemon Bars", "Chocolate Chip Cookies", "Strawberry Shortcake", "Key Lime Pie", "Oreo Cheesecake", "Carrot Cake",
		                "Peanut Butter Chocolate Chip Cookies", "Banana Pudding", "Blueberry Cobbler", "Salted Caramel Brownies", "Tiramisu", "Coconut Cream Pie",
		                "Chocolate Mousse", "Pecan Pie", "Pumpkin Roll", "Cannoli", "Mixed Berry Crisp", "Peanut Butter Pie", "Lemon Meringue Pie",
		                "Chocolate Dipped Strawberries", "Black Forest Cake", "Caramel Apple Crisp", "S'mores Brownies", "Raspberry Chocolate Tart",
		                "Mint Chocolate Chip Ice Cream", "Peach Cobbler", "Peanut Butter Fudge", "Cinnamon Roll Cake", "Key Lime Bars", "Cherry Pie",
		                "Triple Chocolate Cookies", "Strawberry Rhubarb Crisp", "Caramel Macchiato Cheesecake", "Cookies and Cream Ice Cream", "Chocolate Lava Cake",
		                "Baklava", "Blueberry Lemon Bars", "Chocolate Covered Pretzels", "Raspberry Swirl Cheesecake", "Coconut Macaroons", "Peanut Butter Blossoms",
		                "Snickers Bar Cheesecake", "Mocha Brownies", "Pineapple Upside-Down Cake", "Chocolate Banana Bread", "Lemon Raspberry Cupcakes",
		                "Pecan Praline Ice Cream", "Pumpkin Cheesecake Bars", "Raspberry Almond Thumbprint Cookies", "Butterscotch Pudding", "Key Lime Cheesecake",
		                "Caramel Brownie Trifle", "Espresso Chocolate Mousse", "Chocolate Hazelnut Tart", "Strawberry Cheesecake Swirl Brownies",
		                "Salted Caramel Chocolate Chip Cookies", "Lemon Poppy Seed Cake", "Apple Crisp Cheesecake", "Blueberry Cheesecake Ice Cream",
		                "Peanut Butter Cup Blondies", "Coconut Chocolate Chip Cookies", "Raspberry Chocolate Chip Muffins", "Blackberry Cobbler Cheesecake",
		                "S'mores Dip", "Tiramisu Brownies", "Cherry Chocolate Chip Cookies", "Peanut Butter Chocolate Chip Blondies", "Lemon Blueberry Bundt Cake",
		                "Strawberry Shortcake Ice Cream", "Caramel Apple Cheesecake Bars", "Coconut Cream Pie Bars", "Mint Chocolate Chip Brownies",
		                "Pumpkin Spice Latte Cheesecake", "Raspberry Chocolate Chip Cheesecake Bars", "Banana Cream Pie Dip", "Chocolate Turtle Brownies",
		                "Lemon Raspberry Swirl Cheesecake Bars", "Pecan Pie Cheesecake", "Salted Caramel Chocolate Cupcakes", "S'mores Pie", "Cinnamon Roll Cheesecake Bars",
		                "Key Lime Pie Cheesecake", "Coconut Lime Sugar Cookies", "Peanut Butter S'mores Bars", "Raspberry Lemonade Cupcakes", "Black Forest Brownies"
		            );
		            break;
		        case "sci-fi":
		            _food_name = choose(
		                "Astronaut's Freeze-Dried Ice Cream", "Galactic Chocolate Nebula", "Cybernetic Caramel Crunch", "Quantum Quasar Cheesecake",
		                "Robot's Raspberry Sorbet", "Interstellar Inverted Cake", "Neon Nebula Cake Pops", "Martian Martianmallow Treats", "Cosmic Cookie Cluster",
		                "Extraterrestrial Eclair", "Satellite Shortbread", "Stellar Spaceship Sundaes", "Astro-Apple Tart", "Black Hole Brownie",
		                "Robot Rock Candy", "Astro-Popcorn Balls", "Cosmic Cake-In-A-Jar", "Neon Nougat Nuggets", "Zero-Gravity Gumdrops", "Saturn's Saturnpea Pods",
		                "Galactic Glazed Donut", "Milky Way Macarons", "Astro-Almond Biscotti", "Moonrock Mint Chip Ice Cream", "Comet Cupcakes", "Robot's Raspberry Macaron",
		                "Astro-Apple Cider", "Cybernetic Cinnamon Churros", "Cosmic Cannoli Cones", "Galactic Grape Gummies", "Neon Nutella Waffle",
		                "Stellar Space Sherbet", "Astro-Apple Turnover", "Interstellar Ice Cream Float", "Black Hole Blackberry Cobbler", "Robot's Red Velvet Cupcakes",
		                "Astro-Apple Strudel", "Milky Way Mousse", "Quantum Quesadilla", "Neon Nectarine Tart", "Cosmic Cotton Candy", "Saturn's Stellar Sandwich",
		                "Galactic Gooey Butter Cake", "Moonrock Mint Chocolate Truffles", "Astro-Almond Brittle", "Robot's Rock Candy", "Astro-Apple Slushie",
		                "Cybernetic Caramel Apple", "Cosmic Coconut Cream Pie", "Galactic Grape Gelatin", "Neon Nutella Crepes", "Quantum Quiche",
		                "Astro-Apple Caramel Cake", "Stellar Space Soup", "Robot's Rainbow Macarons", "Astro-Apple Crisp", "Milky Way Macchiato", "Saturn's Stellar Sorbet",
		                "Galactic Gingersnaps", "Moonrock Marshmallow Pops", "Astro-Almond Macaroons", "Robot's Raspberry Muffins", "Astro-Apple Caramel Cupcake",
		                "Cybernetic Caramel Corn", "Cosmic Cheesecake", "Galactic Grape Popsicles", "Neon Nutella Pancakes", "Quantum Quinoa Salad",
		                "Astro-Apple Fritter", "Stellar Space Shake", "Robot's Raspberry Milkshake", "Astro-Apple Cinnamon Roll", "Milky Way Malt",
		                "Saturn's Saturnberry Smoothie", "Galactic Gumballs", "Moonrock Mint Brownies", "Astro-Almond Biscuit", "Robot's Raspberry Oatmeal",
		                "Astro-Apple Pancakes", "Cybernetic Caramel Cake", "Cosmic Coconut Candy", "Galactic Grape Gelato", "Neon Nutella Frappe",
		                "Quantum Quail Egg", "Astro-Apple Danish", "Stellar Space Snack Mix", "Robot's Rainbow Pancakes", "Astro-Apple Popsicle", "Milky Way Mocha",
		                "Saturn's Saturnberry Sorbet", "Galactic Gooey Cake", "Moonrock Mint Milkshake", "Astro-Almond Milk", "Robot's Raspberry Toast",
		                "Astro-Apple Crumble", "Cybernetic Caramel Cappuccino", "Cosmic Cream-Filled Cookie", "Galactic Grape Sorbet", "Neon Nutella Latte",
		                "Quantum Quinoa Bar", "Astro-Apple Caramel Cone", "Stellar Space Sushi"
		            );
		            break;
		    }
		    break;
        case "beverage":
		    switch (_genre) {
		        case "fantasy":
		            _food_name = choose(
		                "Elixir of the Enchantress", "Dragon's Breath Brew", "Fairy Fizz", "Magical Mead", "Unicorn's Tears", "Wizard's Potion", "Pixie Punch",
		                "Centaur Cider", "Sorcerer's Smoothie", "Gryphon's Gulp", "Phoenix Flame Frappuccino", "Cyclops Coffee", "Mystic Mulled Wine",
		                "Chimera Cherry Soda", "Satyr's Sangria", "Hippogriff Hot Chocolate", "Nymph's Nectar", "Harpy's Honeysuckle Tea", "Valkyrie's Vigor",
		                "Minotaur's Milkshake", "Mermaid's Melody", "Elf's Elixir", "Goblin's Grog", "Kraken Krush", "Banshee's Brew", "Medusa's Mojito",
		                "Cerberus Cola", "Fairy Froyo", "Djinn's Delight", "Gorgon's Gazebo", "Sylph's Sparkling Water", "Gnome's Ginger Ale", "Manticore's Mocha",
		                "Witch's Whiskey", "Imp's Iced Tea", "Vampire's Velvet Vodka", "Werewolf's Whiskey Sour", "Yeti's Yerba Mate", "Zombie's Zombie",
		                "Kitsune Kombucha", "Griffon's Grappa", "Elemental's Energy Drink", "Basilisk's Blackberry Lemonade", "Gremlin's Green Smoothie",
		                "Wendigo's White Russian", "Boggart's Bubble Tea", "Specter's Sprite", "Hydra's Herbal Infusion", "Ghoul's Grapefruit Spritzer",
		                "Merfolk's Mango Lassi", "Kelpie's Kelp Smoothie", "Unicorn's Ube Latte", "Marauder's Matcha", "Doppelganger's Decaf",
		                "Kitsune Kukicha Tea", "Harpy's Hibiscus Punch", "Gorgon's Grape Juice", "Nereid's Nutmeg Nog", "Pixie's Papaya Smoothie",
		                "Banshee's Blueberry Lemonade", "Chimera's Caramel Macchiato", "Witch's White Wine", "Siren's Strawberry Daiquiri",
		                "Gremlin's Green Apple Cider", "Hobgoblin's Honey Mead", "Basilisk's Blueberry Lavender Lemonade", "Faun's Fig Infused Water",
		                "Goblin's Grape Gatorade", "Mummy's Mango Lassi", "Nymph's Nettle Tea", "Phoenix's Pomegranate Punch", "Salamander's Strawberry Slushie",
		                "Valkyrie's Vanilla Chai", "Yeti's Yerba Mate Latte", "Ghoul's Ginger Beer", "Manticore's Mocha Frappe", "Sphinx's Spiced Cider",
		                "Zombie's Zesty Zinfandel", "Djinn's Date Shake", "Wendigo's Whipped Cream White Hot Chocolate", "Cyclops's Cold Brew",
		                "Gorgon's Grapefruit Green Tea", "Sylph's Sparkling Lemonade", "Boggart's Blackcurrant Smoothie", "Specter's Strawberry Soda",
		                "Naiad's Nettle Infused Water", "Marauder's Maple Latte", "Doppelganger's Dirty Martini", "Kitsune's Kombucha Sangria",
		                "Griffon's Green Grape Juice", "Elemental's Elderflower Elixir", "Banshee's Blue Raspberry Lemonade", "Medusa's Mint Mojito",
		                "Gargoyle's Ginger Spice Chai", "Gremlin's Green Grape Smoothie", "Hag's Honey Hibiscus Tea", "Vampire's Velvet Vanilla Latte",
		                "Minotaur's Malted Milkshake", "Witch's Watermelon Margarita", "Imp's Iced Vanilla Latte", "Satyr's Spiced Mulled Wine",
		                "Hippogriff's Hazelnut Hot Chocolate", "Nymph's Nourishing Nettle Tea"
		            );
		            break;
		        case "modern":
		            _food_name = choose(
		                "Classic Lemonade", "Iced Coffee", "Mango Lassi", "Green Smoothie", "Strawberry Milkshake", "Orange Creamsicle Float", "Peach Iced Tea",
		                "Raspberry Lemon Sparkler", "Chai Latte", "Watermelon Lemonade", "Blueberry Mint Lemonade", "Pineapple Coconut Smoothie", "Cucumber Limeade",
		                "Pomegranate Iced Tea", "Caramel Macchiato", "Vanilla Bean Frappuccino", "Cinnamon Hot Chocolate", "Mint Mojito Iced Coffee", "Berry Blast Smoothie",
		                "Honeydew Melon Cooler", "Coconut Water", "Lavender London Fog", "Iced Matcha Latte", "Peanut Butter Banana Smoothie", "Raspberry White Hot Chocolate",
		                "Caramelized Pineapple Cooler", "Mocha Espresso Shake", "Vanilla Chai Latte", "Strawberry Banana Smoothie", "Minty Iced Chocolate",
		                "Vanilla Iced Latte", "Caramel Frappuccino", "Cookies and Cream Milkshake", "Honey Vanilla Iced Coffee", "Peanut Butter Cup Smoothie",
		                "Salted Caramel Mocha", "Cold Brew Hibiscus Tea", "Pumpkin Spice Latte", "Mango Green Iced Tea", "Blueberry Almond Smoothie",
		                "Iced Caramel Macchiato", "Coconut Pineapple Iced Coffee", "Peach Raspberry Lemonade", "Cherry Almond Iced Tea", "Oreo Milkshake",
		                "Honey Lavender Latte", "Iced Tiramisu Latte", "Cranberry Orange Cooler", "Maple Pecan Iced Coffee", "Tropical Passionfruit Smoothie",
		                "Iced Raspberry Mocha", "Toasted Marshmallow Hot Chocolate", "White Chocolate Caramel Macchiato", "Mixed Berry Lemonade",
		                "Raspberry Coconut Iced Coffee", "Ginger Turmeric Latte", "Iced Brown Sugar Cinnamon Latte", "Mocha Protein Shake",
		                "Strawberry Kiwi Lemonade", "Vanilla Almond Smoothie", "Peppermint Mocha", "Pineapple Ginger Cooler", "Caramel Hazelnut Macchiato",
		                "Iced Vanilla Bean Latte", "Matcha Green Tea Latte", "Blueberry Lavender Smoothie", "S'mores Hot Chocolate", "Cookies and Cream Frappuccino",
		                "Toasted Coconut Iced Coffee", "Raspberry Limeade", "Cinnamon Dolce Latte", "Coconut Raspberry Smoothie", "Iced Maple Cinnamon Latte",
		                "Honeydew Mint Cooler", "Salted Caramel Cold Brew", "Mint Chocolate Chip Frappuccino", "Tropical Mango Smoothie", "Iced Hazelnut Macchiato",
		                "Vanilla Chai Frappuccino", "Iced Coconut Mocha", "Strawberry Guava Lemonade", "Honey Cinnamon Latte", "Caramel Banana Smoothie",
		                "Cherry Vanilla Iced Coffee", "Blueberry Basil Lemonade", "Peanut Butter Mocha", "Minty Iced Mocha", "Iced Caramelized Honey Latte",
		                "Toasted Almond Iced Coffee", "Caramel Pumpkin Spice Latte", "Peach Green Iced Tea", "Blackberry Vanilla Smoothie"
		            );
		            break;
		        case "sci-fi":
		            _food_name = choose(
		                "Galactic Geyser", "Rocket Fuel", "Cosmic Cola", "Neon Nebula Latte", "Space Slush", "Hyperdrive Horchata", "Alien Almond Milk",
		                "Astro Apple Cider", "Supernova Smoothie", "Robot Raspberry Shake", "Satellite Soda", "Gravity Grape Juice", "Stardust Strawberry Lemonade",
		                "Meteor Mocha", "Quantum Quencher", "Celestial Cherry Bomb", "Nebula Nectar", "Infinity Iced Tea", "Cyber Caramel Macchiato",
		                "Martian Mocha Frappuccino", "Solar Soy Milk", "Galaxy Ginger Ale", "Moonbeam Mint Julep", "Cosmo Coffee", "UFO Unicorn Lemonade",
		                "Orbit Orange Juice", "Spacewalk Watermelon Slush", "Nova Nitro Cold Brew", "Asteroid Almond Smoothie", "Stellar Soy Latte",
		                "Robot Raspberry Lemonade", "Cosmic Cucumber Cooler", "Nebula Nectarine Iced Tea", "Meteor Mango Lassi", "Supernova Salted Caramel Latte",
		                "Satellite Strawberry Smoothie", "Infinity Iced Chai", "Alien Avocado Smoothie", "Galactic Grape Soda", "Robot Raspberry Cappuccino",
		                "Neon Nebula Vanilla Latte", "Astro Apple Chai", "Cosmo Cold Brew", "Moonbeam Mint Mojito", "Cyber Caramel Frappuccino",
		                "Stellar Strawberry Lemonade", "Meteor Mocha Frappuccino", "Quantum Quenching Quinoa Drink", "Orbit Orange Smoothie", "Spacewalk Watermelon Cooler",
		                "Galactic Green Tea", "UFO Unicorn Hot Chocolate", "Nebula Nutella Latte", "Nova Nitro Nitro Cold Brew", "Infinity Iced Almond Milk Latte",
		                "Robot Raspberry White Mocha", "Celestial Cherry Cola", "Cosmic Cranberry Mocktail", "Martian Maple Macchiato", "Solar Soy Caramel Latte",
		                "Galaxy Green Smoothie", "Moonbeam Mint Chocolate Shake", "Supernova Strawberry Lemonade", "Satellite Salted Caramel Mocha", "Gravity Grape Slush",
		                "Stardust Strawberry Frappuccino", "Nebula Nutmeg Latte", "Cyber Caramel Cold Brew", "Astro Apple Smoothie", "Robot Raspberry Iced Macchiato",
		                "Neon Nebula Matcha Latte", "Cosmo Caramel Frappuccino", "Martian Mint Mocha", "Solar Soy Vanilla Latte", "Galactic Ginger Smoothie",
		                "UFO Unicorn Raspberry Lemonade", "Nebula Nutella Frappe", "Nova Nitro Nitro Cold Brew", "Infinity Iced Chai Latte", "Robot Raspberry Caramel Macchiato",
		                "Cosmic Coconut Cold Brew", "Moonbeam Mint Milkshake", "Stellar Strawberry Iced Tea", "Meteor Maple Macchiato", "Supernova Soy Latte",
		                "Satellite Strawberry Lemonade", "Gravity Grape Milkshake", "Nebula Nutmeg Frappe", "Cyber Caramel Latte", "Astro Apple Chai Frappuccino",
		                "Robot Raspberry Iced Cappuccino", "Neon Nebula Vanilla Frappe", "Cosmo Caramel Macchiato", "Martian Mint Mojito", "Solar Soy Mocha",
		                "Galactic Green Iced Tea", "UFO Unicorn Almond Milk Latte", "Nebula Nutella Cold Brew", "Nova Nitro Nitro Cold Brew", "Infinity Iced Matcha Latte",
		                "Robot Raspberry White Chocolate Mocha", "Celestial Cherry Iced Coffee", "Cosmic Coconut Chai", "Martian Maple Mocha", "Stellar Strawberry Smoothie",
		                "Meteor Mocha Frappe", "Quantum Quenching Quinoa Smoothie", "Orbit Orange Milkshake", "Spacewalk Watermelon Lemonade"
		            );
		            break;
		    }
		    break;
        default:
            _food_name = "Unknown";
    }
    
    return _food_name;
}
