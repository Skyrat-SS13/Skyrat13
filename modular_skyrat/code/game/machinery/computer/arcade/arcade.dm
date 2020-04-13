/obj/machinery/computer/arcade
	list/prizes = list(
		/obj/item/toy/balloon = ARCADE_WEIGHT_USELESS,
		/obj/item/toy/beach_ball = ARCADE_WEIGHT_USELESS,
		/obj/item/toy/cattoy = ARCADE_WEIGHT_USELESS,
		/obj/item/toy/clockwork_watch = ARCADE_WEIGHT_TRICK,
		/obj/item/toy/dummy = ARCADE_WEIGHT_TRICK,
		/obj/item/toy/eightball = ARCADE_WEIGHT_USELESS,
		/obj/item/toy/eightball/haunted = ARCADE_WEIGHT_RARE,
		/obj/item/storage/box/actionfigure = ARCADE_WEIGHT_USELESS,
		/obj/item/toy/foamblade = ARCADE_WEIGHT_TRICK,
		/obj/item/toy/gun = ARCADE_WEIGHT_TRICK,
		/obj/item/toy/gun/justicar = ARCADE_WEIGHT_TRICK,
		/obj/item/toy/gun/m41 = ARCADE_WEIGHT_TRICK,
		/obj/item/toy/katana = ARCADE_WEIGHT_TRICK,
		/obj/item/toy/minimeteor = ARCADE_WEIGHT_TRICK,
		/obj/item/toy/nuke = ARCADE_WEIGHT_TRICK,
		/obj/item/toy/redbutton = ARCADE_WEIGHT_TRICK,
		/obj/item/toy/spinningtoy = ARCADE_WEIGHT_TRICK,
		/obj/item/toy/sword = ARCADE_WEIGHT_TRICK,
		/obj/item/toy/sword/cx = ARCADE_WEIGHT_TRICK,
		/obj/item/toy/talking/AI = ARCADE_WEIGHT_USELESS,
		/obj/item/toy/talking/codex_gigas = ARCADE_WEIGHT_USELESS,
		/obj/item/toy/talking/griffin = ARCADE_WEIGHT_USELESS,
		/obj/item/toy/talking/owl = ARCADE_WEIGHT_USELESS,
		/obj/item/toy/toy_dagger = ARCADE_WEIGHT_TRICK,
		/obj/item/toy/toy_xeno = ARCADE_WEIGHT_TRICK,
		/obj/item/toy/windupToolbox = ARCADE_WEIGHT_TRICK,

		/mob/living/simple_animal/bot/secbot/grievous/toy = ARCADE_WEIGHT_RARE,
		/obj/item/clothing/mask/facehugger/toy = ARCADE_WEIGHT_RARE,
		/obj/item/gun/ballistic/automatic/toy/pistol/unrestricted = ARCADE_WEIGHT_TRICK,
		/obj/item/hot_potato/harmless/toy = ARCADE_WEIGHT_RARE,
		/obj/item/twohanded/dualsaber/toy = ARCADE_WEIGHT_RARE,
		/obj/item/twohanded/dualsaber/hypereutactic/toy = ARCADE_WEIGHT_RARE,
		/obj/item/twohanded/dualsaber/hypereutactic/toy/rainbow = ARCADE_WEIGHT_RARE,

		/obj/item/storage/box/snappops = ARCADE_WEIGHT_TRICK,
		/obj/item/clothing/under/syndicate/tacticool = ARCADE_WEIGHT_TRICK,
		/obj/item/gun/ballistic/shotgun/toy/crossbow = ARCADE_WEIGHT_TRICK,
		/obj/item/storage/box/fakesyndiesuit = ARCADE_WEIGHT_TRICK,
		/obj/item/storage/crayons = ARCADE_WEIGHT_USELESS,
		/obj/item/coin/antagtoken = ARCADE_WEIGHT_USELESS,
		/obj/item/stack/tile/fakespace/loaded = ARCADE_WEIGHT_TRICK,
		/obj/item/stack/tile/fakepit/loaded = ARCADE_WEIGHT_TRICK,
		/obj/item/restraints/handcuffs/fake = ARCADE_WEIGHT_TRICK,
		/obj/item/clothing/gloves/fingerless/pugilist/rapid/hug = ARCADE_WEIGHT_TRICK,

		/obj/item/grenade/chem_grenade/glitter/pink = ARCADE_WEIGHT_TRICK,
		/obj/item/grenade/chem_grenade/glitter/blue = ARCADE_WEIGHT_TRICK,
		/obj/item/grenade/chem_grenade/glitter/white = ARCADE_WEIGHT_TRICK,

		/obj/item/extendohand/acme = ARCADE_WEIGHT_TRICK,
		/obj/item/card/emagfake	= ARCADE_WEIGHT_TRICK,
		/obj/item/clothing/shoes/wheelys = ARCADE_WEIGHT_RARE,
		/obj/item/clothing/shoes/kindleKicks = ARCADE_WEIGHT_RARE,
		/obj/item/storage/belt/military/snack = ARCADE_WEIGHT_RARE,

		/obj/item/clothing/mask/fakemoustache/italian = ARCADE_WEIGHT_RARE,
		/obj/item/clothing/suit/hooded/wintercoat/ratvar/fake = ARCADE_WEIGHT_TRICK,
		/obj/item/clothing/suit/hooded/wintercoat/narsie/fake = ARCADE_WEIGHT_TRICK
	)
	var/prizecharge = 5

/obj/machinery/computer/arcade/prizevend(mob/user, list/rarity_classes)
	if(prizecharge == 0)
		to_chat(user, "<span class='notice'>Warning: Maximum amount of prizes have been vended!</span>")
		return
	prizecharge--
	. = ..()

