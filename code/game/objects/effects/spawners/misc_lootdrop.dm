// FALSE WALLS

/obj/effect/spawner/lootdrop/wall/ten_percent_falsewall
	name = "10% falsewall"
	loot = list(
		/turf/closed/wall = 90,
		/obj/structure/falsewall = 10)

/obj/effect/spawner/lootdrop/wall/twentyfive_percent_falsewall
	name = "25% falsewall"
	loot = list(
		/turf/closed/wall = 75,
		/obj/structure/falsewall = 25)

/obj/effect/spawner/lootdrop/wall/fifty_percent_falsewall
	name = "50% falsewall"
	loot = list(
		/turf/closed/wall = 50,
		/obj/structure/falsewall = 50)

/obj/effect/spawner/lootdrop/wall/seventyfive_percent_falsewall
	name = "75% falsewall"
	loot = list(
		/turf/closed/wall = 25,
		/obj/structure/falsewall = 75)

/obj/effect/spawner/lootdrop/tenpercent_basic_tool
	name = "10% basic tool"
	loot = list(
		/obj/item/screwdriver = 2,
		/obj/item/wrench = 2,
		/obj/item/crowbar = 2,
		/obj/item/weldingtool = 2,
		/obj/item/wirecutters = 2,
		"" = 90)

// BASIC TOOLS

/obj/effect/spawner/lootdrop/tenpercent_basic_tool/screwdriver
	name = "10% screwdriver"
	loot = list(
		/obj/item/screwdriver = 10,
		"" = 90)

/obj/effect/spawner/lootdrop/tenpercent_basic_tool/wrench
	name = "10% wrench"
	loot = list(
		/obj/item/wrench = 10,
		"" = 90)

/obj/effect/spawner/lootdrop/tenpercent_basic_tool/crowbar // GORDON YOU FOOL
	name = "10% crowbar"
	loot = list(
		/obj/item/crowbar = 10,
		"" = 90)

/obj/effect/spawner/lootdrop/tenpercent_basic_tool/weldingtool
	name = "10% welding tool"
	loot = list(
		/obj/item/weldingtool = 10,
		"" = 90)

/obj/effect/spawner/lootdrop/tenpercent_basic_tool/wirecutters
	name = "10% wirecutters"
	loot = list(
		/obj/item/wirecutters = 10,
		"" = 90)
// COINS

/obj/effect/spawner/lootdrop/tenpercent_basic_tool/wirecutters
	name = "10% wirecutters"
	loot = list(
		/obj/item/wirecutters = 10,
		"" = 90)

// COINS

/obj/effect/spawner/lootdrop/coins
	name = "75% falsewall"
	loot = list(
		/obj/item/coin/iron = 60,
		/obj/item/coin/silver = 25,
		/obj/item/coin/gold = 10,
		/obj/item/coin/diamond = 5)

/obj/effect/spawner/lootdrop/coins/iron
	name = "50% iron"
	loot = list(
		/obj/item/coin/iron = 50,
		"" = 50)

/obj/effect/spawner/lootdrop/coins/iron/twentyfivepercent
	name = "25% iron"
	loot = list(
		/obj/item/coin/iron = 25,
		"" = 75)

/obj/effect/spawner/lootdrop/coins/iron/tenpercent
	name = "10% iron"
	loot = list(
		/obj/item/coin/iron = 10,
		"" = 90)

// SPACE CASH

/obj/effect/spawner/lootdrop/space_cash/very_low_chance
	name = "10% cash"
	lootcount = 1
	loot = list(
				/obj/item/stack/spacecash/c1    = 9,
				/obj/item/stack/spacecash/c10   = 1,
				"" = 90)

/obj/effect/spawner/lootdrop/space_cash/low_chance
	name = "25% cash"
	lootcount = 1
	loot = list(
				/obj/item/stack/spacecash/c1    = 15,
				/obj/item/stack/spacecash/c10   = 10,
				"" = 75)

/obj/effect/spawner/lootdrop/space_cash/medium_chance
	name = "50% cash"
	lootcount = 1
	loot = list(
				/obj/item/stack/spacecash/c1    = 5,
				/obj/item/stack/spacecash/c10   = 15,
				/obj/item/stack/spacecash/c50   = 15,
				/obj/item/stack/spacecash/c100  = 7,
				/obj/item/stack/spacecash/c200  = 7,
				/obj/item/stack/spacecash/c500  = 1,
				"" = 50)

/obj/effect/spawner/lootdrop/prison_safe
	name = "prison loot"
	lootcount = 1
	loot = list(
				/obj/item/pda= 10,
				/obj/item/restraints/handcuffs = 1,
				/obj/item/radio/off = 10,
				/obj/item/instrument/violin = 7,
				/obj/item/instrument/eguitar = 7,
				/obj/item/flashlight = 10,
				/obj/item/analyzer = 5,
				"" = 50)

// SEEDS

/obj/effect/spawner/lootdrop/seeds
	name = "prison seeds"
	loot = list(
		/obj/item/seeds/cotton/durathread = 30,
		/obj/item/seeds/tomato/blood = 20,
		/obj/item/seeds/tomato/blue = 20,
		/obj/item/seeds/cherry/blue	 = 20,
		/obj/item/seeds/replicapod = 10)

/obj/effect/spawner/lootdrop/seeds/durathread
	name = "50% durathread"
	loot = list(
		/obj/item/seeds/cotton/durathread = 50,
		"" = 50)

/obj/effect/spawner/lootdrop/seeds/replicapod
	name = "25% replicapod"
	loot = list(
		/obj/item/seeds/replicapod = 25,
		"" = 75)

// SOAP

/obj/effect/spawner/lootdrop/soap
	name = "50% soap"
	loot = list(
		/obj/item/soap = 50,
		"" = 50)

/obj/effect/spawner/lootdrop/soap/twentyfive_percent
	name = "25% soap"
	loot = list(
		/obj/item/soap = 25,
		"" = 75)

/obj/effect/spawner/lootdrop/soap/seventyfive_percent
	name = "75% soap"
	loot = list(
		/obj/item/soap = 75,
		"" = 25)
