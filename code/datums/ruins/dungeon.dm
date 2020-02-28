// Hey! Listen! Update \config\lavaruinblacklist.txt with your new ruins!

/datum/map_template/ruin/dungeon
	prefix = "_maps/RandomRuins/DungeonRuins/"

/datum/map_template/ruin/dungeon/hierophant
	name = "Hierophant's Arena"
	id = "hierophant"
	description = "A strange, square chunk of metal of massive size. Inside awaits only death and many, many squares."
	suffix = "dungeon_surface_hierophant.dmm"
	always_place = TRUE
	allow_duplicates = FALSE

/datum/map_template/ruin/dungeon/blood_drunk_miner
	name = "Blood-Drunk Miner"
	id = "blooddrunk"
	description = "A strange arrangement of stone tiles and an insane, beastly miner contemplating them."
	suffix = "dungeon_surface_blooddrunk1.dmm"
	cost = 0
	allow_duplicates = FALSE //will only spawn one variant of the ruin

/datum/map_template/ruin/dungeon/elite_tumor
	name = "Pulsating Tumor"
	id = "tumor"
	description = "A strange tumor which houses a powerful beast..."
	suffix = "dungeon_surface_elite_tumor.dmm"
	cost = 5
	always_place = TRUE
	allow_duplicates = TRUE