//ice walker iglo
#define ICE_WALKER_SPAWN_THRESHOLD 250
/area/ruin/powered/icemoon/underground/ice_walkers
	icon_state = "red"

/obj/structure/ice_walkers
	name = "resonating red crystal"
	desc = "A magical crystal that creates... sentient fish people, when fed with ore."
	icon = 'modular_skyrat/icons/mob/icecrystal.dmi'
	icon_state = "red_crystal"
	move_resist=INFINITY
	anchored = TRUE
	density = TRUE
	max_integrity = 250
	var/faction = list("icewalker")
	light_color = LIGHT_COLOR_RED
	light_intensity = 2
	light_range = 2
	var/consumedore
	var/list/orevalue = list(/obj/item/stack/ore/uranium = 30, \
	 /obj/item/stack/ore/iron = 1, \
	 /obj/item/stack/ore/glass = 1, \
	 /obj/item/stack/ore/plasma = 15, \
	 /obj/item/stack/ore/silver = 16, \
	 /obj/item/stack/ore/gold = 18, \
	 /obj/item/stack/ore/diamond = 50, \
	 /obj/item/stack/ore/bananium = 60, \
	 /obj/item/stack/ore/titanium = 50, \
	 /obj/item/twohanded/required/gibtonite = 100)

/obj/structure/ice_walkers/Initialize()
	.=..()
	START_PROCESSING(SSprocessing, src)

/obj/structure/ice_walkers/deconstruct(disassembled)
	. = ..()
	new /obj/item/assembly/signaler/anomaly (get_step(loc, pick(GLOB.alldirs)))

/obj/structure/ice_walkers/process()
	consume()
	spawn_mob()

/obj/structure/ice_walkers/proc/consume()
	for(var/obj/item/stack/ore/O in view(src, 1))
		if(O in subtypesof(/obj/item/stack/ore)
			consumedore += orevalue[O]
	playsound(get_turf(src),'sound/effects/curse1.ogg', 100, 1)


/obj/structure/lavaland/ash_walker/proc/spawn_mob()
	if(consumedore >= ICE_WALKER_SPAWN_THRESHOLD)
		new /obj/effect/mob_spawn/human/ice_walker(get_step(loc, pick(GLOB.alldirs)))
		visible_message("<span class='danger'>One of the eggs swells to an unnatural size and tumbles free. It's ready to hatch!</span>")
		consumedore -= ICE_WALKER_SPAWN_THRESHOLD

/obj/effect/mob_spawn/human/ice_walker
	name = "ice walker egg"
	desc = "A man-sized white egg, spawned from some unfathomable creature. A humanoid silhouette lurks within."
	mob_name = "an ice walker"
	job_description = "Icewalker"
	icon = 'modular_skyrat/icons/mob/icemoon/icemoon_monsters.dmi'
	icon_state = "large_egg"
	mob_species = /datum/species/aquatic/icewalker
	outfit = /datum/outfit/icewalker
	roundstart = FALSE
	death = FALSE
	anchored = FALSE
	move_resist = MOVE_FORCE_NORMAL
	density = FALSE
	short_desc = "You are an ice walker. Your tribe worships the Deep Ones."
	flavour_text = "You were once an inhabitant of this planet and lived in peace with your colony for years, but the Deep Ones have brought you enlightenment. You must protect your tribe and your gods, and bring enlightenment to other colonizers. You also must destroy the seeping influence of your God's rivals into the snowy wastes and underground."
	assignedrole = "Ice Walker"

/obj/effect/mob_spawn/human/ice_walker/special(mob/living/new_spawn)
	new_spawn.grant_language(/datum/language/fish)
	var/datum/language_holder/holder = new_spawn.get_language_holder()
	holder.selected_default_language = /datum/language/fish

//Ice walkers on birth understand how to make bone bows, bone arrows and ashen arrows

	new_spawn.mind.teach_crafting_recipe(/datum/crafting_recipe/bone_arrow)
	new_spawn.mind.teach_crafting_recipe(/datum/crafting_recipe/bone_bow)
	new_spawn.mind.teach_crafting_recipe(/datum/crafting_recipe/ashen_arrow)
	new_spawn.mind.teach_crafting_recipe(/datum/crafting_recipe/quiver)
	new_spawn.mind.teach_crafting_recipe(/datum/crafting_recipe/bow_tablet)

	if(ishuman(new_spawn))
		var/mob/living/carbon/human/H = new_spawn
		H.underwear = "Nude"
		H.update_body()

/obj/effect/mob_spawn/human/ice_walker/Initialize(mapload)
	. = ..()
	var/area/A = get_area(src)
	if(A)
		notify_ghosts("An ice walker egg is ready to hatch in \the [A.name].", source = src, action=NOTIFY_ATTACK, flashwindow = FALSE, ignore_key = POLL_IGNORE_ASHWALKER, ignore_dnr_observers = TRUE)

/datum/outfit/icewalker
	name ="Icewalker"
	shoes = /obj/item/clothing/shoes/winterboots/ice_boots
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/color
	r_pocket = /obj/item/storage/bag/ore
	suit = /obj/item/clothing/suit/hooded/wintercoat/miner

/datum/language/fish
	name = "Neo-fishen"
	desc = "The common tongue of ice walkers, developed from what was once galactic common."
	speech_verb = "gorgles"
	ask_verb = "borbles iniquiringly"
	exclaim_verb = "blorps"
	key = "z"
	space_chance = 20
	syllables = list(
"a", "ai", "an", "ang", "ao", "ba", "bai", "ban", "bang", "bao", "bei", "ben", "beng", "bi", "bian", "biao",
"bie", "bin", "bing", "bo", "bu", "ca", "cai", "can", "cang", "cao", "ce", "cei", "cen", "ceng", "cha", "chai",
"chan", "chang", "chao", "che", "chen", "cheng", "chi", "chong", "chou", "chu", "chua", "chuai", "chuan", "chuang", "chui", "chun",
"chuo", "ci", "cong", "cou", "cu", "cuan", "cui", "cun", "cuo", "da", "dai", "dan", "dang", "dao", "de", "dei",
"den", "deng", "di", "dian", "diao", "die", "ding", "diu", "dong", "dou", "du", "duan", "dui", "dun", "duo", "e",
"ei", "en", "er", "fa", "fan", "fang", "fei", "fen", "feng", "fo", "fou", "fu", "ga", "gai", "gan", "gang",
"gao", "ge", "gei", "gen", "geng", "gong", "gou", "gu", "gua", "guai", "guan", "guang", "gui", "gun", "guo", "ha",
"hai", "han", "hang", "hao", "he", "hei", "hen", "heng", "hm", "hng", "hong", "hou", "hu", "hua", "huai", "huan",
"huang", "hui", "hun", "huo", "ji", "jia", "jian", "jiang", "jiao", "jie", "jin", "jing", "jiong", "jiu", "ju", "juan",
"jue", "jun", "ka", "kai", "kan", "kang", "kao", "ke", "kei", "ken", "keng", "kong", "kou", "ku", "kua", "kuai",
"kuan", "kuang", "kui", "kun", "kuo", "la", "lai", "lan", "lang", "lao", "le", "lei", "leng", "li", "lia", "lian",
"liang", "liao", "lie", "lin", "ling", "liu", "long", "lou", "lu", "luan", "lun", "luo", "ma", "mai", "man", "mang",
"mao", "me", "mei", "men", "meng", "mi", "mian", "miao", "mie", "min", "ming", "miu", "mo", "mou", "mu", "na",
"nai", "nan", "nang", "nao", "ne", "nei", "nen", "neng", "ng", "ni", "nian", "niang", "niao", "nie", "nin", "ning",
"niu", "nong", "nou", "nu", "nuan", "nuo", "o", "ou", "pa", "pai", "pan", "pang", "pao", "pei", "pen", "peng",
"pi", "pian", "piao", "pie", "pin", "ping", "po", "pou", "pu", "qi", "qia", "qian", "qiang", "qiao", "qie", "qin",
"qing", "qiong", "qiu", "qu", "quan", "que", "qun", "ran", "rang", "rao", "re", "ren", "reng", "ri", "rong", "rou",
"ru", "rua", "ruan", "rui", "run", "ruo", "sa", "sai", "san", "sang", "sao", "se", "sei", "sen", "seng", "sha",
"shai", "shan", "shang", "shao", "she", "shei", "shen", "sheng", "shi", "shou", "shu", "shua", "shuai", "shuan", "shuang", "shui",
"shun", "shuo", "si", "song", "sou", "su", "suan", "sui", "sun", "suo", "ta", "tai", "tan", "tang", "tao", "te",
"teng", "ti", "tian", "tiao", "tie", "ting", "tong", "tou", "tu", "tuan", "tui", "tun", "tuo", "wa", "wai", "wan",
"wang", "wei", "wen", "weng", "wo", "wu", "xi", "xia", "xian", "xiang", "xiao", "xie", "xin", "xing", "xiong", "xiu",
"xu", "xuan", "xue", "xun", "ya", "yan", "yang", "yao", "ye", "yi", "yin", "ying", "yong", "you", "yu", "yuan",
"yue", "yun", "za", "zai", "zan", "zang", "zao", "ze", "zei", "zen", "zeng", "zha", "zhai", "zhan", "zhang", "zhao",
"zhe", "zhei", "zhen", "zheng", "zhi", "zhong", "zhou", "zhu", "zhua", "zhuai", "zhuan", "zhuang", "zhui", "zhun", "zhuo", "zi",
"zong", "zou", "zuan", "zui", "zun", "zuo", "zu",
"al", "an", "ar", "as", "at", "ea", "ed", "en", "er", "es", "ha", "he", "hi", "in", "is", "it",
"le", "me", "nd", "ne", "ng", "nt", "on", "or", "ou", "re", "se", "st", "te", "th", "ti", "to",
"ve", "wa", "all", "and", "are", "but", "ent", "era", "ere", "eve", "for", "had", "hat", "hen", "her", "hin",
"his", "ing", "ion", "ith", "not", "ome", "oul", "our", "sho", "ted", "ter", "tha", "the", "thi",
"al", "an", "ar", "as", "at", "ea", "ed", "en", "er", "es", "ha", "he", "hi", "in", "is", "it",
"le", "me", "nd", "ne", "ng", "nt", "on", "or", "ou", "re", "se", "st", "te", "th", "ti", "to",
"ve", "wa", "all", "and", "are", "but", "ent", "era", "ere", "eve", "for", "had", "hat", "hen", "her", "hin",
"his", "ing", "ion", "ith", "not", "ome", "oul", "our", "sho", "ted", "ter", "tha", "the", "thi",
"al", "an", "ar", "as", "at", "ea", "ed", "en", "er", "es", "ha", "he", "hi", "in", "is", "it",
"le", "me", "nd", "ne", "ng", "nt", "on", "or", "ou", "re", "se", "st", "te", "th", "ti", "to",
"ve", "wa", "all", "and", "are", "but", "ent", "era", "ere", "eve", "for", "had", "hat", "hen", "her", "hin",
"his", "ing", "ion", "ith", "not", "ome", "oul", "our", "sho", "ted", "ter", "tha", "the", "thi",
"al", "an", "ar", "as", "at", "ea", "ed", "en", "er", "es", "ha", "he", "hi", "in", "is", "it",
"le", "me", "nd", "ne", "ng", "nt", "on", "or", "ou", "re", "se", "st", "te", "th", "ti", "to",
"ve", "wa", "all", "and", "are", "but", "ent", "era", "ere", "eve", "for", "had", "hat", "hen", "her", "hin",
"his", "ing", "ion", "ith", "not", "ome", "oul", "our", "sho", "ted", "ter", "tha", "the", "thi",
"al", "an", "ar", "as", "at", "ea", "ed", "en", "er", "es", "ha", "he", "hi", "in", "is", "it",
"le", "me", "nd", "ne", "ng", "nt", "on", "or", "ou", "re", "se", "st", "te", "th", "ti", "to",
"ve", "wa", "all", "and", "are", "but", "ent", "era", "ere", "eve", "for", "had", "hat", "hen", "her", "hin",
"his", "ing", "ion", "ith", "not", "ome", "oul", "our", "sho", "ted", "ter", "tha", "the", "thi",
"al", "an", "ar", "as", "at", "ea", "ed", "en", "er", "es", "ha", "he", "hi", "in", "is", "it",
"le", "me", "nd", "ne", "ng", "nt", "on", "or", "ou", "re", "se", "st", "te", "th", "ti", "to",
"ve", "wa", "all", "and", "are", "but", "ent", "era", "ere", "eve", "for", "had", "hat", "hen", "her", "hin",
"his", "ing", "ion", "ith", "not", "ome", "oul", "our", "sho", "ted", "ter", "tha", "the", "thi") // copied of common because am lazy
	icon_state = "dopefish"
	icon = 'modularskyrat/icons/misc/language.dmi'
	default_priority = 91


/datum/species/aquatic/icewalker
	name = "Icewalker"
	id = "iceaquatic"
	say_mod = "gorgles"
	default_color = "#00BFFF"
	species_traits = list(MUTCOLORS,EYECOLOR,HAIR,FACEHAIR,LIPS,HORNCOLOR,WINGCOLOR)
	mutant_bodyparts = list("mam_tail", "mam_ears", "mam_body_markings", "mam_snouts", "deco_wings", "taur", "horns", "legs")
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	coldmod = 0.4
	heatmod = 1.5
	burnmod = 0.9
	brutemod = 0.9
	default_features = list("mcolor" = "#00BFFF", "mcolor2" = "#00BFFF", "mcolor3" = "#00BFFF", "mam_tail" = "Shark", "snout" = "Shark",
							 "horns" = "None", "frills" = "Aquatic", "spines" = "None", "body_markings" = "None",
							  "legs" = "Digitigrade", "taur" = "None", "deco_wings" = "None")
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	meat = /obj/item/reagent_containers/food/snacks/carpmeat
	exotic_bloodtype = "L"
	liked_food = GROSS | MEAT

/datum/species/aquatic/icewalker/after_equip_job(datum/job/J, mob/living/carbon/human/H)
	H.grant_language(/datum/language/fish)