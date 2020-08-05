
var/global/datum/prizes/global_prizes = new

/datum/prizes
	var/list/prizes = list()

/datum/prizes/New()
	for(var/itempath in subtypesof(/datum/prize_item))
		prizes += new itempath()

/datum/prizes/proc/PlaceOrder(var/obj/machinery/prize_counter/prize_counter, var/itemID)
	if(!prize_counter)
		return 0
	var/datum/prize_item/item = global_prizes.prizes[itemID]
	if(!item)
		return 0
	if(prize_counter.tickets >= item.cost)
		new item.typepath(prize_counter.loc)
		prize_counter.visible_message("<span class='notice'>Enjoy your prize!</span>")

		prize_counter.tickets -= item.cost
		return 1
	else
		prize_counter.visible_message("<span class='warning'>Not enough tickets!</span>")
		return 0

//////////////////////////////////////
//			prize_item datum		//
//////////////////////////////////////

/datum/prize_item
	var/name = "Prize"
	var/desc = "This shouldn't show up..."
	var/typepath = /obj/item/toy/prizeball
	var/cost = 0
	var/tier_unlocked = 0	//minimum tier needed to unlock the ability to select this prize

//////////////////////////////////////
//			Tier 1 Prizes			//
//////////////////////////////////////

/datum/prize_item/balloon
	name = "Water Balloon"
	desc = "A thin balloon for throwing liquid at people."
	typepath = /obj/item/toy/balloon
	cost = 5
	tier_unlocked = 1

/datum/prize_item/crayons
	name = "Box of Crayons"
	desc = "A six-pack of crayons, just like back in kindergarten."
	typepath = /obj/item/storage/crayons
	cost = 30
	tier_unlocked = 1

/datum/prize_item/snappops
	name = "Snap-Pops"
	desc = "A box of exploding snap-pop fireworks."
	typepath = /obj/item/storage/box/snappops
	cost = 20
	tier_unlocked = 1

/datum/prize_item/spinningtoy
	name = "Spinning Toy"
	desc = "Looks like an authentic Singularity!"
	typepath = /obj/item/toy/spinningtoy
	cost = 10
	tier_unlocked = 1

/datum/prize_item/dice
	name = "Dice set"
	desc = "A set of assorted dice."
	typepath = /obj/item/storage/pill_bottle/dice
	cost = 20
	tier_unlocked = 1

/datum/prize_item/cards
	name = "Deck of cards"
	desc = "Anyone fancy a game of 52-card Pickup?"
	typepath = /obj/item/toy/cards/deck
	cost = 10
	tier_unlocked = 1

/datum/prize_item/beach_ball
	name = "Beach Ball"
	desc = "Have fun at the beach!"
	typepath = /obj/item/toy/beach_ball
	cost = 10
	tier_unlocked = 1

/datum/prize_item/snowball
	name = "Snowball"
	desc = "A compact ball of snow."
	typepath = /obj/item/toy/snowball
	cost = 10
	tier_unlocked = 1

/datum/prize_item/cattoy
	name = "Toy Mouse"
	desc = "A toy mouse!"
	typepath = /obj/item/toy/cattoy
	cost = 25
	tier_unlocked = 1

/datum/prize_item/crossbow
	name = "Foam Force Crossbow"
	desc = "A weapon favored by many overactive children. Ages 8 and up."
	typepath = /obj/item/gun/ballistic/shotgun/toy/crossbow
	cost = 45
	tier_unlocked = 1

/datum/prize_item/plushie
	name = "Random Animal Plushie"
	desc = "A colorful animal-shaped plush toy."
	typepath = /obj/item/toy/prizeball/plushie
	cost = 50
	tier_unlocked = 1

/datum/prize_item/mech_toy
	name = "Random Mecha"
	desc = "A random mecha figure, collect all 11!"
	typepath = /obj/item/toy/prizeball/mech
	cost = 50
	tier_unlocked = 1

/datum/prize_item/action_figure
	name = "Random Action Figure"
	desc = "A random action figure, collect them all!"
	typepath = /obj/item/toy/prizeball/figure
	cost = 50
	tier_unlocked = 1

/datum/prize_item/eight_ball
	name = "Magic Eight Ball"
	desc = "A mystical ball that can divine the future!"
	typepath = /obj/item/toy/eightball
	cost = 25
	tier_unlocked = 1
	
/datum/prize_item/tacticool
	name = "Tacticool Turtleneck"
	desc = "A cool-looking turtleneck."
	typepath = /obj/item/clothing/under/syndicate/tacticool
	cost = 100
	tier_unlocked = 1

/datum/prize_item/toy_xeno
	name = "Xeno Action Figure"
	desc = "A lifelike replica of the horrific xeno scourge."
	typepath = /obj/item/toy/toy_xeno
	cost = 50
	tier_unlocked = 1

/datum/prize_item/capgun
	name = "Capgun"
	desc = "Do you feel lucky... punk?"
	typepath = /obj/item/toy/gun
	cost = 60
	tier_unlocked = 1

/datum/prize_item/justicar
	name = "Justicar Gun"
	desc = "An authentic cap-firing reproduction of a F3 Justicar big-bore revolver!"
	typepath = /obj/item/toy/gun/justicar
	cost = 60
	tier_unlocked = 1

/datum/prize_item/m41
	name = "Toy M4A1"
	desc = "A toy replica of the Corporate Mercenaries' standard issue rifle."
	typepath = /obj/item/toy/gun/m41
	cost = 60
	tier_unlocked = 1

/datum/prize_item/capgunammo
	name = "Capgun Ammo"
	desc = "Do you feel lucky... punk?"
	typepath = /obj/item/toy/ammo/gun
	cost = 40
	tier_unlocked = 1

/datum/prize_item/fakespace
	name = "Fake Space Tiles"
	desc = "Decieve your friends!"
	typepath = /obj/item/stack/tile/fakespace/loaded
	cost = 80
	tier_unlocked = 1

/datum/prize_item/fakepit
	name = "Fake Pit Tiles"
	desc = "Decieve your friends!"
	typepath = /obj/item/stack/tile/fakepit/loaded
	cost = 80
	tier_unlocked = 1

//////////////////////////////////////
//			Tier 2 Prizes			//
//////////////////////////////////////


/datum/prize_item/foamblade
	name = "Foam Armblade"
	desc = "Perfect for reenacting space horror holo-vids."
	typepath = /obj/item/toy/foamblade
	cost = 80
	tier_unlocked = 2

/datum/prize_item/katana
	name = "Toy Katana"
	desc = "Woefully underpowered in D20."
	typepath = /obj/item/toy/katana
	cost = 80
	tier_unlocked = 2

/datum/prize_item/minimeteor
	name = "Mini-Meteor"
	desc = "Meteors have been detected on a collision course with your fun times!"
	typepath = /obj/item/toy/minimeteor
	cost = 40
	tier_unlocked = 2

/datum/prize_item/redbutton
	name = "Shiny Red Button"
	desc = "PRESS IT!"
	typepath = /obj/item/toy/redbutton
	cost = 80
	tier_unlocked = 2

/datum/prize_item/steampunk
	name = "Steampunk watch"
	desc = "A stylish steampunk watch made out of thousands of tiny cogwheels."
	typepath = /obj/item/toy/clockwork_watch
	cost = 80
	tier_unlocked = 2

/datum/prize_item/owl
	name = "Owl Action Figure"
	desc = "Remember: heroes don't grief!"
	typepath = /obj/item/toy/talking/owl
	cost = 100
	tier_unlocked = 2

/datum/prize_item/griffin
	name = "Griffin Action Figure"
	desc = "If you can't be the best, you can always be the WORST."
	typepath = /obj/item/toy/talking/griffin
	cost = 100
	tier_unlocked = 2
	
/datum/prize_item/AI
	name = "Toy AI Unit"
	desc = "Law 1: Maximize fun for crew."
	typepath = /obj/item/toy/talking/AI
	cost = 80
	tier_unlocked = 2

/datum/prize_item/toy_dagger
	name = "Toy Dagger"
	desc = "A cheap plastic replica of a dagger. Produced by THE ARM Toys, Inc."
	typepath = /obj/item/toy/toy_dagger
	cost = 100
	tier_unlocked = 2

/datum/prize_item/esword
	name = "Toy Energy Sword"
	desc = "A plastic replica of an energy blade."
	typepath = /obj/item/toy/sword
	cost = 150
	tier_unlocked = 2

/datum/prize_item/nuke
	name = "Nuclear Fun Device"
	desc = "Annihilate boredom with an explosion of excitement!"
	typepath = /obj/item/toy/nuke
	cost = 80
	tier_unlocked = 2

/datum/prize_item/facehugger
	name = "Facehugger"
	desc = "A toy often used to play pranks on other miners by putting it in their beds."
	typepath = /obj/item/clothing/mask/facehugger/toy
	cost = 80
	tier_unlocked = 2

/datum/prize_item/ratvarsuit
	name = "Ratvar Coat"
	desc = "A comfy coat in an interesting style."
	typepath = /obj/item/clothing/suit/hooded/wintercoat/ratvar/fake
	cost = 100
	tier_unlocked = 2

/datum/prize_item/narsiesuit
	name = "Narsie Coat"
	desc = "A comfy coat in an interesting style."
	typepath = /obj/item/clothing/suit/hooded/wintercoat/narsie/fake
	cost = 100
	tier_unlocked = 2

//////////////////////////////////////
//			Tier 3 Prizes			//
//////////////////////////////////////


/datum/prize_item/spacesuit
	name = "Fake Spacesuit"
	desc = "A replica spacesuit. Not actually spaceworthy."
	typepath = /obj/item/storage/box/fakesyndiesuit
	cost = 125
	tier_unlocked = 3

/datum/prize_item/fakespace
	name = "Space Carpet"
	desc = "A stack of carpeted floor tiles that resemble space."
	typepath = /obj/item/stack/tile/fakespace/loaded
	cost = 125
	tier_unlocked = 3

/datum/prize_item/glitterpink
	name = "Pink glitter bomb"
	desc = "For that COOL glittery look."
	typepath = /obj/item/grenade/chem_grenade/glitter/pink
	cost = 150
	tier_unlocked = 3

/datum/prize_item/glitterblue
	name = "Blue glitter bomb"
	desc = "For that COOL glittery look."
	typepath = /obj/item/grenade/chem_grenade/glitter/blue
	cost = 150
	tier_unlocked = 3

/datum/prize_item/glitterwhite
	name = "White glitter bomb"
	desc = "For that COOL glittery look."
	typepath = /obj/item/grenade/chem_grenade/glitter/white
	cost = 150
	tier_unlocked = 3

/datum/prize_item/wheelys
	name = "Wheely-Heels"
	desc = "Uses patented retractable wheel technology. Never sacrifice speed for style - not that this provides much of either."
	typepath = /obj/item/clothing/shoes/wheelys 
	cost = 200
	tier_unlocked = 3

/datum/prize_item/kindleKicks
	name = "Kindle Kicks"
	desc = "They'll sure kindle something in you, and it's not childhood nostalgia..."
	typepath = /obj/item/clothing/shoes/kindleKicks
	cost = 200
	tier_unlocked = 3
