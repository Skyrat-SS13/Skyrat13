//DO NOT INCLUDE THIS FILE. IT CAUSES FUCKING ARRAY ERRORS FOR SOME IDIOTIC REASON.
//Fully-equipped shaft miner outfit to make debugging less tedious for Bob Joga :)
/datum/outfit/job/miner/equipped/fullyequipped
	name = "Shaft Miner (Equpped+)"
	suit = /obj/item/clothing/suit/hooded/explorer/standard
	mask = /obj/item/clothing/mask/gas/explorer
	glasses = /obj/item/clothing/glasses/hud/mining/sunglasses
	suit_store = /obj/item/tank/internals/oxygen
	internals_slot = SLOT_S_STORE
	backpack_contents = list(\
		/obj/item/flashlight/seclite=1,\
		/obj/item/kitchen/knife/combat/survival=1,\
		/obj/item/t_scanner/adv_mining_scanner=1,\
		/obj/item/gun/energy/kinetic_accelerator/premiumka/bdminer=1
		)

/datum/outfit/job/miner/equipped/fullyequipped/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE, client/preference_source)
	..()
	if(visualsOnly)
		return
	for(var/i = 0, i == 6, i++)
		new /obj/item/hivelordstabilizer(H.loc)
		new /obj/item/organ/regenerative_core/legion(H.loc)
		new /obj/item/stack/sheet/animalhide/goliath_hide(H.loc)
	for(var/i = 0, i == 4, i++)
		new /obj/item/borg/upgrade/modkit/cooldown(H.loc)
	new /obj/item/crusher_trophy/legion_skull(H.loc)
	new /obj/item/crusher_trophy/miner_eye(H.loc)
	new /obj/item/crusher_trophy/blaster_tubes/mask(H.loc)
	new /obj/item/twohanded/kinetic_crusher(H.loc)
