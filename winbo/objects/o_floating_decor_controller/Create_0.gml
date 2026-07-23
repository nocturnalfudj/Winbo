foreground_sprites = [
	spr_floating_butterfly_green,
	spr_floating_butterfly_blue,
	spr_floating_firefly,
	spr_floating_leaf_green_a,
	spr_floating_leaf_green_b,
	spr_floating_leaf_green_c,
	spr_floating_leaf_purple_a,
	spr_floating_leaf_purple_b,
	spr_floating_leaf_purple_c,
	spr_floating_flower_a,
	spr_floating_flower_b,
	spr_floating_flower_c,
	spr_floating_flower_d,
	spr_floating_flower_e
];

// Levels 1 and 2 intentionally omit spr_floating_ember. Later level
// controllers can opt into it through their own concrete sprite array.
spawn_count_max = 4;
spawn_countdown = random_range(0.5,1.5) * SECOND;
spawn_interval_min = 1.5 * SECOND;
spawn_interval_max = 4 * SECOND;
background_chance = 0.3;
