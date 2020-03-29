/datum/outfit/job/clown
	name = "Joker"
	jobtype = /datum/job/clown

	belt = /obj/item/gun/ballistic/revolver/detective/joker
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/rank/civilian/clown/green
	shoes = /obj/item/clothing/shoes/clown_shoes/combat
	mask = /obj/item/clothing/mask/gas/clown_hat/joker
	l_pocket = /obj/item/bikehorn
	r_pocket = /obj/item/pda/clown
	backpack_contents = list(
		/obj/item/stamp/clown = 1,
		/obj/item/reagent_containers/spray/waterflower = 1,
		/obj/item/reagent_containers/food/snacks/grown/banana = 1,
		/obj/item/instrument/bikehorn = 1,
		/obj/item/storage/fancy/cigarettes/cigpack_robustgold = 1,
		/obj/item/ammo_box/c38/hotshot = 1,
		/obj/item/ammo_box/c38/iceblox = 1,
		/obj/item/ammo_box/c38/lethal = 2,
		/obj/item/kitchen/knife/joker = 1
		)

	implants = list(/obj/item/implant/sad_trombone)

	backpack = /obj/item/storage/backpack/clown
	satchel = /obj/item/storage/backpack/clown
	duffelbag = /obj/item/storage/backpack/duffelbag/clown //strangely has a duffel

	box = /obj/item/storage/box/hug/survival

/obj/item/clothing/mask/gas/clown_hat/joker
	name = "Fleck's Mask"
	desc = "I'm the joker, baby!"
	icon_state = "joker"

/datum/outfit/job/clown/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE, client/preference_source)
	..()
	if(visualsOnly)
		return

	var/client/C = H.client || preference_source
	if(C)
		H.apply_pref_name("clown", C) //rename the mob AFTER they're equipped so their ID gets updated properly.
	else
		H.fully_replace_character_name(H.real_name, "The Joker")
	H.dna.add_mutation(SMILE)
	var/datum/antagonist/traitor/A = New()
	A.add_objective(datum/objective/joker)
	A.admin_add(H.mind)

/datum/objective/joker
	name = "Sad Clown"
	explanation_text = "What do you get when you cross a mentally ill loner with a society that abandons him and treats him like trash?You get what you fucking deserve!"

/obj/item/gun/ballistic/revolver/detective/joker
	name = "Smith & Wesson Model 36"
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
	desc = "This knife is full of hate."
	force = 20
	throwforce = 20
	throw_speed = 6
