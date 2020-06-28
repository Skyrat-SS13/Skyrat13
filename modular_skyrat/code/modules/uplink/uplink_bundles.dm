//joker bundle, also i'm gonna do all items here because i'm lazy
/datum/uplink_item/bundles_TC/joker
	name = "Society Box"
	desc = "A crate with a .38 revolver with ammo, special knife and special clothing to enact revenge on society as a whole."
	item = /obj/item/storage/box/hug/angryclown
	cost = 20
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops)
	restricted_roles = list("Clown", "Mime", "Assistant")

/obj/item/clothing/mask/gas/clown_hat/joker
	name = "\proper Society's Mask"
	desc = "I'm the joker, baby! This mask is incredibly armored, somehow."
	icon_state = "joker"
	armor = list("melee" = 25, "bullet" = 25, "laser" = 25,"energy" = 25, "bomb" = 25, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)

/obj/item/gun/ballistic/revolver/detective/joker
	name = "\proper Smith and Wesson Model 36"
	desc = "Wanna hear another joke, captain?"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev38/joker

/obj/item/ammo_box/magazine/internal/cylinder/rev38/joker
	caliber = list("38", "357")
	max_ammo = 5
	ammo_type = /obj/item/ammo_casing/c38/lethal

/obj/item/gun/ballistic/revolver/detective/joker/Initialize()
	..()
	safe_calibers |= list("38","357")

/obj/item/kitchen/knife/joker
	name = "sad knife"
	desc = "This knife is full of hatred and angst."
	force = 20
	throwforce = 20
	throw_speed = 6

/obj/item/storage/box/hug/angryclown
	name = "jester's box"
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
	armor = list("melee" = 10, "bullet" = 10, "laser" = 10,"energy" = 10, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)

//punished venom traitor bundle. yes i'll keep the theme of inconsistent file paths and shit because i'm too lazy to create new files and shit for everything here.
/datum/uplink_item/bundles_TC/punished
	name = "Motherbase Shipment"
	desc = "A kit containing the essentials for any 'big boss'. Contains a tactical turtleneck, thermal eyepatch, sneaking boots and a robotic CQC arm implanter."
	item = /obj/item/storage/box/syndie_kit/snake
	cost = 20
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops)
	cant_discount = TRUE

/obj/item/storage/box/syndie_kit/snake
	name = "Motherbase Shipment"
	desc = "Kept you waiting, huh?"

/obj/item/storage/box/syndie_kit/snake/PopulateContents()
	new /obj/item/clothing/glasses/thermal/eyepatch(src)
	new /obj/item/clothing/accessory/padding(src)
	new /obj/item/clothing/under/syndicate(src)
	new /obj/item/clothing/shoes/combat/sneakboots/snake(src) //HNNNG COLONEL, I'M TRYING TO SNEAK AROUND-
	new /obj/item/limbsurgeon/martialarm(src)
	new /obj/item/headsetupgrader(src)
	new /obj/item/encryptionkey/syndicate(src)
	new /obj/item/kitchen/knife/combat/survival(src)

/obj/item/limbsurgeon //autosurgeon is shit and does not support limbs, i had to do it to 'em
	name = "limb autosurgeon"
	desc = "A device that automatically removes an old limb and inserts a new one into the user without the hassle of extensive surgery. It has a slot to insert limbs and a screwdriver slot for removing accidentally added items."
	icon = 'icons/obj/device.dmi'
	icon_state = "autoimplanter"
	item_state = "nothing"
	w_class = WEIGHT_CLASS_SMALL
	var/obj/item/bodypart/storedbodypart
	var/bodypart_type = /obj/item/bodypart
	var/uses = INFINITE
	var/starting_bodypart

/obj/item/limbsurgeon/Initialize(mapload)
	. = ..()
	if(starting_bodypart)
		insert_bodypart(new starting_bodypart(src))

/obj/item/limbsurgeon/proc/insert_bodypart(var/obj/item/bodypart/I)
	storedbodypart = I
	I.forceMove(src)
	name = "[initial(name)] ([storedbodypart.name])"

/obj/item/limbsurgeon/attack_self(mob/user)//when the object it used...
	if(!uses)
		to_chat(user, "<span class='warning'>[src] has already been used. The tools are dull and won't reactivate.</span>")
		return
	else if(!storedbodypart)
		to_chat(user, "<span class='notice'>[src] currently has no bodypart stored.</span>")
		return
	var/mob/living/carbon/C = user
	if(C)
		storedbodypart.replace_limb(C)
		user.visible_message("<span class='notice'>[user] presses a button on [src], and you hear a short mechanical noise.</span>", "<span class='notice'>You feel a sharp sting as [src] plunges into your body.</span>")
		playsound(get_turf(user), 'sound/weapons/circsawhit.ogg', 50, 1)
		storedbodypart = null
		name = initial(name)
		if(uses != INFINITE)
			uses--
		if(!uses)
			desc = "[initial(desc)] Looks like it's been used up."
	else
		user.visible_message("<span class='notice'>[user] presses a button on [src], and nothing happens.</span>") //bro you're not carbon how tf you gonna replace that limb bro

/obj/item/limbsurgeon/martialarm
	uses = 1
	starting_bodypart = /obj/item/bodypart/l_arm/robot/martial

/obj/item/bodypart/l_arm/robot/martial
	name = "punished left arm"
	desc = "Has no markings of any kind, because that would offer no tactical advantages. But it's distinctly a syndicate item, somehow."
	var/datum/martial_art/ourmartial = /datum/martial_art/cqc
	var/martialid = "bigboss"
	icon = 'modular_skyrat/icons/mob/venom_parts.dmi'
	icon_state = "l_arm"
	starting_children = list(/obj/item/bodypart/l_hand/robot/martial)

/obj/item/bodypart/l_hand/robot/martial
	name = "punished left hand"
	desc = "Has no markings of any kind, because that would offer no tactical advantages. But it's distinctly a syndicate item, somehow."
	aux_icons = list(BODY_ZONE_PRECISE_L_HAND = HANDS_PART_LAYER, "l_hand_behind" = BODY_BEHIND_LAYER)

/* Though i wanted it to be "only works as long as the arm works", byond hates me and this proc failed me. Instead i'll have to do another approach.
/obj/item/bodypart/l_arm/robot/martial/update_limb(dropping_limb, mob/living/carbon/source) //this is probably not the best way to do it, but i want to make sure that it always checks if the limb is viable. if not viable, owner loses the martial art.
	..() ///we call the parent first to do all the necessary checks and what the fuck ever
	if(owner && !is_disabled())
		if(owner.mind)
			if(!owner.mind.martial_art || owner.mind.martial_art.id != martialid) //if we already have a martial art, let's not add another one so as not to cause conflicts
				var/datum/martial_art/MA = new ourmartial
				MA.id = martialid //give it an id to keep track of it
				MA.teach(source)
	if(is_disabled() || dropping_limb && owner) //if the limb is dropped or is disabled, we remove the martial art. well that should be how it works.
		if(owner.mind)
			if(istype(owner.mind.martial_art, ourmartial)) //we don't want to remove a martial art that isn't actually caused by us, say the person has a krav maga glove on
				var/datum/martial_art/lose = owner.mind.martial_art
				if(lose.id == martialid) //again, let's not remove a martial art that isn't actually caused by us
					lose.remove(owner)
*/

/obj/item/bodypart/l_arm/robot/martial/attach_limb(mob/living/carbon/C, special)
	..()
	var/datum/martial_art/MA = new ourmartial
	MA.id = martialid //give it an id to keep track of it
	MA.teach(owner)

/obj/item/bodypart/l_arm/robot/martial/drop_limb(special, dismembered)
	. = ..()
	if(owner.mind.martial_art.id == martialid)
		var/datum/martial_art/lose = owner.mind.martial_art
		lose.remove(owner)

/obj/item/clothing/shoes/combat/sneakboots/snake
	name = "combat sneakboots"
	desc = "Hnnnng colonel! I'm trying to sneak around!" // yes i will do that fucking joke on the damn description
	icon_state = "combat"
	item_state = "jackboots"
	resistance_flags = FIRE_PROOF |  ACID_PROOF
	clothing_flags = NOSLIP

//"ghostface" bundle
/datum/uplink_item/bundles_TC/ghostface
	name = "Screamer Kit"
	desc = "A box, coming with a mask and robes that render you completely unrecognizable when worn, and a special knife."
	item = /obj/item/storage/box/syndie_kit/ghostface
	cost = 12
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops)

/obj/item/storage/box/syndie_kit/ghostface
	name = "Scary Box"
	desc = "A box to make everyone scream."

/obj/item/storage/box/syndie_kit/ghostface/PopulateContents()
	new /obj/item/clothing/mask/infiltrator/ghostface(src)
	new /obj/item/clothing/suit/hooded/cultrobes/ghostface(src)
	new /obj/item/kitchen/knife/combat/ghost(src)

//true dab bundle
/datum/uplink_item/suits/truedab
	name = "Tactical DAB Suit"
	desc = "Ever found a cheap replica of one of these? Get to wear the real thing! Has slightly better protection than normal riot armor."
	item = /obj/item/storage/box/syndie_kit/truedab
	cost = 6
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops)
	restricted_roles = list("Assistant")

/obj/item/storage/box/syndie_kit/truedab
	name = "Desperate Assistance Battleforce Box (DABB)"
	desc = "DAB suit and helmet, tightly packaged for combat deployment. Not the cheap replica!"

/obj/item/storage/box/syndie_kit/truedab/PopulateContents()
	new /obj/item/clothing/suit/assu_suit/realdeal(src)
	new /obj/item/clothing/head/assu_helmet/realdeal(src)

/obj/item/clothing/suit/assu_suit/realdeal
	desc = "Ancient, but still very functional, SWAT armor. On its back, it is written: \"<i>Desperate Assistance Battleforce</i>\". Tacticool-ish <b>and</b> protective!"
	armor = list("melee" = 60, "bullet" = 15, "laser" = 15, "energy" = 30, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 90, "acid" = 100) //somewhat high energy resistance because harmbatone, 10 points better in melee and 5 points better in boolet and laser than normal riot suit because it's an epic traitor item and NT is a bunch of cheapskates (except with fucking miner armors for some reason??????? bro wtf exo has 55 melee too???)
	allowed = null

/obj/item/clothing/suit/assu_suit/realdeal/Initialize()
	. = ..()
	if(!allowed)
		allowed = GLOB.security_vest_allowed

/obj/item/clothing/head/assu_helmet/realdeal
	desc = "Ancient, yet functional helmet. It has \"D.A.B.\" written on the front. Helps quite a bit against batons to the head."
	armor = list("melee" = 60, "bullet" = 15, "laser" = 15, "energy" = 30, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 90, "acid" = 100)
