//joker bundle, also i'm gonna do all items here because i'm lazy
/datum/uplink_item/bundles_TC/joker
	name = "Society Box"
	desc = "A crate with a .38 revolver with ammo, special knife and special clothing to enact revenge on society as a whole."
	item = /obj/item/storage/box/hug/angryclown
	cost = 20
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops)
	restricted_roles = list("Clown")

/obj/item/clothing/mask/gas/clown_hat/joker
	name = "\proper Fleck's Mask"
	desc = "I'm the joker, baby! ...This mask is incredibly armored, somehow."
	icon_state = "joker"
	armor = list("melee" = 25, "bullet" = 25, "laser" = 25,"energy" = 25, "bomb" = 25, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)

/obj/item/gun/ballistic/revolver/detective/joker
	name = "\proper Smith and Wesson Model 36"
	desc = "Wanna hear another joke, captain?"
	/obj/item/ammo_box/magazine/internal/cylinder/rev38/joker

/obj/item/ammo_box/magazine/internal/cylinder/rev38/joker
	caliber = list("38", "357")
	max_ammo = 5
	ammo_type = /obj/item/ammo_casing/c38/lethal

/obj/item/gun/ballistic/revolver/detective/joker/Initialize()
	..()
	safe_calibers += "357"

/obj/item/kitchen/knife/joker
	name = "sad knife"
	desc = "This knife is full of hate and angst."
	force = 20
	throwforce = 20
	throw_speed = 6

/obj/item/storage/box/hug/angryclown
	name = "arthur's box"
	desc = "Knock knock. Who's there? It's the police ma'am, your son has been hit by a drunk driver. He's dead."

/obj/item/storage/box/hug/angryclown/PopulateContents()
	. = ..()
	new /obj/item/kitchen/knife/joker(src)
	new /obj/item/gun/ballistic/revolver/detective/joker(src)
	new /obj/item/ammo_box/c38/lethal(src)
	new /obj/item/ammo_box/c38/lethal(src)
	new /obj/item/ammo_box/c38/hotshot(src)
	new /obj/item/storage/fancy/cigarettes/cigpack_robustgold(src)
	new /obj/item/clothing/suit/armor(src)
	new /obj/item/clothing/shoes/clown_shoes/combat(src)
	new /obj/item/clothing/under/rank/civilian/clown/green/armored(src)

/obj/item/clothing/under/rank/civilian/clown/green/armored
	name = "armored clown suit"
	desc = "<b>I'LL MAKE YOU HONK ALRIGHT.</b>"
	armor = list("melee" = 10, "bullet" = 5, "laser" = 5,"energy" = 10, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)

//punished venom traitor bundle. yes i'll keep the theme of inconsistent file paths and shit because i'm too lazy to create new files and shit for everything here.
/datum/uplink_item/bundles_TC/punished
	name = "Motherbase Shipment"
	desc = "A kit containing the essentials for any 'big boss'. Contains a tactical turtleneck, thermal eyepatch, sneaking boots and a robotic CQC arm implanter."
	item = /obj/item/storage/box/syndicate/snake
	cost = 20
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops)

/obj/item/storage/box/syndicate/snake
	name = "Motherbase Shipment"
	desc = "Kept you waiting, huh?"

/obj/item/storage/box/syndicate/snake/PopulateContents()
	new /obj/item/clothing/glasses/thermal/eyepatch(src)
	new /obj/item/clothing/under/syndicate(src)
	new /obj/item/clothing/shoes/combat/sneakboots(src) //HNNNG COLONEL, I'M TRYING TO SNEAK AROUND-
	new /obj/item/autosurgeon/martialarm(src)

/obj/item/autosurgeon/martialarm
	starting_organ = /obj/item/bodypart/l_arm/robot/martial
	organ_type = /obj/item/bodypart
	uses = 1

/obj/item/bodypart/l_arm/robot/martial
	var/datum/martial_art/ourmartial = /datum/martial_art/cqc
	name = "punished left arm"
	desc = "Has no markings of any kind, because that would offer no tactical advantages. But it's distinctly a syndicate item, somehow."

/obj/item/bodypart/l_arm/robot/martial/update_limb(dropping_limb, mob/living/carbon/source) //this is probably not the best way to do it, but i want to make sure that it always checks if the limb is viable. if not viable, owner loses the martial art.
	..() ///we call the parent first to do all the necessary checks and what the fuck ever
	if(owner && !is_disabled())
		if(owner.mind)
			if(!owner.mind.martial_art) //if we already have a martial art, let's not add another one so as not to cause conflicts
				var/datum/martial_art/MA = new ourmartial
				MA.id = "bigboss" //give it an id to keep track of it
				MA.teach(source)
	if(is_disabled() || dropping_limb && owner) //if the limb is dropped or is disabled, we remove the martial art. well that should be how it works.
		if(owner.mind)
			if(istype(owner.mind.martial_art, ourmartial)) //we don't want to remove a martial art that isn't actually caused by us, say the person has a krav maga glove on
				var/datum/martial_art/lose = owner.mind.martial_art
				if(lose.id == "bigboss") //again, let's not remove a martial art that isn't actually caused by us
					lose.remove(owner)
