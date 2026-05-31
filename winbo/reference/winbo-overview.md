# Winbo Overview

Local reference copy of the Winbo overview document.

Original PDF copy: `docs/reference/Winbo Overview Doc.pdf`

## Winbo

Winbo was once one of many colourful characters who skipped and hopped around these lands, but that time has long gone. Upon his return to said lands under dubious circumstances, Winbo finds that the colourful characters and boundless joy of his world is no more, and that it's now crawling with grizzled soldiers and self-serious "warriors". For extinguishing the exuberant charms of Winbo's world, there can be only one punishment; death. Death, by being jumped on.

Winbo is a 2D platformer starring Winbo, presumably the protagonist of some charming, colourful 2D platformer or platformers from a time long past. However, with the help of a vaguely demonic friend with whom he may or may not have made some kind of infernal deal, Winbo has returned to his old stomping grounds to reclaim it in the name of colour, of joy, of fun, and he's going to do so by force.

The humourless protagonists of more "mature" games who make up this game's enemies all know Winbo. They know why he's here, and they're terrified of him. Because all the swords and bullets and cinematic cutscenes in the world can not stop him from jumping on their heads, and reducing them to naught but a cartoonish puff of smoke in a mere instant. Winbo is a game about a silly little guy who looks like Kirby or Poinpy, but whose stoic, unrelenting crusade evokes enough fear in his enemies that he may as well be The Terminator.

## Gameplay

Winbo is a stubby and slow-moving character, not entirely unlike Kirby. This slowness gives the game's world, and particularly some of the comedic moments that will unfold between Winbo and his enemies, time to breathe. Winbo's signature move is the "Bump." Winbo has a medium-length air dash, and when colliding with a wall or solid object with this air dash, Winbo will "Bump" off said object, causing the screen to shake slightly. Because Winbo is fueled by rage, bumping off a wall actually refreshes his jump and Bump, and chaining jumps and Bumps is how he'll manoeuvre around the game world. The dash can not be used on the ground, this would allow Winbo to move too fast and give the character too much "urgency". Winbo does not need to run. He has nothing to fear.

Winbo can also slowly descend with his "Float", which is triggered by holding down whilst in midair. Winbo has no double jump and no attack button, but if he jumps on anyone's head, they will die instantly. Winbo also has collectibles to collect! Orbs are the game's minor collectible, which contribute to your end score. They come in two varieties, Silver (worth 1 Orb) and Red (worth 2 Orbs). There are also collectible Lives, which appear as floating Winbo heads, as well as Talismans - a far less plentiful collectible. There are two Talismans per level, mostly preceded by a tougher platforming challenge. Collecting all 16 Talismans in the game's main levels will unlock the Bonus Level.

## Levels

Winbo will have 7 levels, a bonus level and a final boss. These levels are spread across 4 themes and should be relatively big and long, modelled after Rayman Legends and Donkey Kong Country with smaller rooms that branch off the "main room" for platforming challenges and extra collectibles. The game can be saved in-between levels, but not during them, and the levels will have checkpoints but losing all lives will require you to start the level over again. Levels should have a scoring system based on how fast you completed it, how many enemies you killed, how many Orbs and Talismans you collected and how many hits you took. A rank should be given at the end of the level via a results screen, with "W" (for Winbo) being the highest possible rank, followed by A, B, C and F.

- Level 1: Forest #1 (Forest)
- Level 2: Forest #2 (Riverside)
- Level 3: Lava #1 (Cave)
- Level 4: Lava #2 (Forge)
- Level 5: Sky #1 (Clouds)
- Level 6: Sky #2 (Rainbow)
- Level 7: Mountain #1 (Trail)
- Level 8: Bonus Level

## The Presence

"The Presence" is Winbo's mysterious demonic associate who will make sporadic appearances throughout the game and talk to Winbo in caves. In his first appearance he will tutorialise the collectible Talismans, as well as hint at a lot of the game's subtext.

### Level 1

"Look upon these charlatans, Winbo. With their guns and bombs and internal conflict. So self-important are they that they pay no mind to whose domain this once was until he stands before them. Collect my Talismans and humble them, remind them of whence they came. This is your nature, Winbo. You collect things. Now go, strip them of all their pretences. Strip them of all that they are."

### Level 3

"They fear you because they can not understand you, Winbo. They want you to be like them. They want you to have lore. For so great a sin there can be no punishment too severe. Jump on their heads, Winbo. Jump on all of their heads."

### Level 5

"You have likely surmised by now, Winbo. Collecting all of my Talismans will unlock a bonus level. These degenerates have no concept of bonus levels. It is an art lost to them amidst the mire of their melodrama. At most they can conceive of concept art or cutscenes, rendered by the same profane machines that create the motion pictures they envy so dearly. Release them from their myopic ambition. Give them the violence they so crave."

### Level 7

"Our time is close at hand, Winbo. When I first returned you to these lands I had salivated at the thought of a day like this. At this mountain's summit is a man on a journey as petty and rote as any we have seen. He thinks himself the hero in some grand yet tragic odyssey. He indulges in his own melancholy, and is emboldened by the world that has formed around him. Let us bring it all crashing down. Humbling him will be our first truly great step in returning to The Old Ways. See that it is done, Winbo."

### Bonus Level

"Yes, bonus content. Your reward for gathering all the Talismans. The deed is done, Winbo, but perhaps our job is not. Does your wish to purge these lands remain? Are you satisfied? Or do the embers of rage still crackle within your rattling soul? If so, perhaps we may meet again. For now, enjoy the succulent fruits of your success. Farewell."

## Assets And Obstacles

Needed level content:

- Ranged Soldier Enemy (throws bombs, grenades, or shoots bullets)
- Up-Close Soldier Enemy (uses a riot shield, butt of a gun, or nightstick)
- Flying Soldier Enemy (shoots bullets or drops bombs)
- Ranged Warrior Enemy (throws a returning weapon, boomerang, axe, or shoots bow)
- Up-Close Warrior Enemy (swings sword, mace, axe, or stabs spear)
- Flying Warrior Enemy (throws spears, tomahawks, or casts spells)
- Flying Fish/Flying Skeletal Fish (flies from below screen like fireball enemies in Mario)
- Orbs (Silver value 1, Red value 5)
- Lives (small floating Winbo head)
- Talismans (rarer major collectibles used to unlock the Bonus Level)
- Solid Block
- Floor Tiles
- Spikes
- Spring or bouncy object
- Semi-Solid Platforms
- Crumbling Platforms
- Rising/Falling Platforms
- Spike Walls/Platforms
- Deathstone
- Checkpoint
- Final Boss

Maybe:

- Flamethrower
- Carnivorous Plants
- Water/Lava
- Power Up Collectible

## Programming Needs

- The Bump with minor screenshake
- The Float
- Enemies and enemy AI
- Score system
- Main Menu
- Pause Menu
- Level Select
- Pause Screen
- Game Over Screen
- Options
- Jump Buffer
- Room Transitions
- End Results Screen
- Saving/loading
- Controller input
- Checkpoint system
- Dialogue/textboxes
- Scrolling backgrounds
- Obstacles (retracting spikes/crumbling platforms)
- Water/Lava
- Final Boss
- Brief cutscenes with camera pan
- Inputting animations, sound effects, and music

## Inspiration

Good places to look for inspiration:

- Poinpy
- Kirby
- Super Mario World and Super Mario Maker
- Rayman 1 and Rayman Origins/Legends, especially the first few levels
- Pizza Tower
- Antonblast
